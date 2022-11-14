#!/bin/bash

. ${PTXDIST_TOPDIR}/scripts/ptxdist_vars.sh
. ${SCRIPTSDIR}/libptxdist.sh

# $1: lib
#
# out: $lib_path
#
ptxd_get_lib_path() {
    local lib lib_dir lib_path extra_cflags

    lib="${1}"

    # ask the compiler for the lib
    lib_path="$(ptxd_cross_cc -print-file-name=${lib})"
    if test "${lib_path}" = "${lib}"; then
	echo "install_copy_toolchain_lib: ${lib} not found" >&2
	return 1
    fi
    # let the shell canonicalized the path
    lib_dir="$(cd ${lib_path%/${lib}} && echo $PWD)"

    if test \! -d "${lib_dir}"; then
	echo "install_copy_toolchain_lib: ${lib_dir} not found" >&2
	return 1
    fi

    echo "${lib_dir}/${lib}"
}


#
# $1: lib_path	# cannolocilized path to lib or link
# $2: var	# sysroot and prefix will be "prefixed" with this var if existing
#
# out: eval sysroot= prefix=
#
ptxd_split_lib_prefix_sysroot_eval() {
    local lib_path lib lib_dir prefix tmp pre sysroot

    lib_path="${1}"
    pre="${2:+${2}_}"

    lib="${lib_path##*/}"			# the pure library filename "libxxx.so"
    lib_dir="${lib_path%/${lib}}"		# abs path to that lib

    # try to identify sysroot part of that path
    for prefix in {/usr,}/lib{64,32,}{/tls,/gconv,} ""; do
	tmp="${lib_dir%${prefix}}"
	if test "${lib_dir}" != "${tmp}"; then
	    break
	fi
    done
    sysroot="${lib_dir%${prefix}}"
    tmp="${prefix#/usr}"
    if [ "${tmp}" == "${prefix}" ]; then
	prefix="/usr${prefix}"
    fi

    echo "${pre}sysroot=\"${sysroot}\" ${pre}prefix=\"${prefix}\""
}


#
# call with "key=value"
#
# lib_path=<canonicalized path to lib>
# strip=[true|false]
# packet=<name of packet>
# dest=<where to install, relative to root{,-debug}>
#
# The work is done here!
# - look at the filename given us, if it's a link then
#   copy it (do not deref, i.e. preserve the link)
# - feed the target of the link recursive into this function
# - if we encounter a regular file, copy it
#   (if it's not a linker script)
# - look into the linker scripts and copy only the _shared_
#   libs mentioned there
#
ptxd_install_toolchain_lib() {
    local lib_path lib lib_dir sysroot prefix script_lib tmp dir v_full lib_v_major
    local packet dest strip lnk lnk_path lnk_prefix lnk_sysroot perm

    eval "${@}"

    while true; do
	lib="${lib_path##*/}"			# the pure library filename "libxxx.so"
	lib_dir="${lib_path%/${lib}}"		# abs path to that lib

	# guess sysroot from given lib
	eval $(ptxd_split_lib_prefix_sysroot_eval "${lib_path}")
	# if the user has given us a $dest use it
	prefix="${dest:-${prefix}}"

	# do sth. with that found lib, action depends on file type (link or regular)
	if test -h "${lib_path}"; then		# link
	    echo "link - ${lib_path}"

	    # get target of the link
	    lnk_path="$(readlink "${lib_path}")" || ptxd_bailout "broken link"
	    lnk="${lnk_path##*/}"

	    # deal with relative and absolute links
	    case "${lnk_path}" in
		/*)
		    # nix
		    ;;
		*)
		    lnk_path="${lib_dir}/${lnk_path}"
		    ;;
	    esac

	    lnk_path="$(ptxd_abspath "${lnk_path}")"
	    eval $(ptxd_split_lib_prefix_sysroot_eval "${lnk_path}" lnk)
	    lnk_prefix="${dest:-${lnk_prefix}}"

	    # if the file name of the link target ist the same then skip creating
	    # the link to avoid a cyclic symlink.
	    # Happens with crosstool-ng with some libraries.
	    if [ "${lib}" != "${lnk}" ]; then
		if test -n "${prefix}"; then
		    lnk_prefix="$(ptxd_abs2rel "${prefix}" "${lnk_prefix}")"
		    lnk_prefix="${lnk_prefix}${lnk_prefix:+/}"
		    # now remember that link for later
		    echo "ptxd_install_link \"${lnk_prefix}${lnk}\" \"${prefix}/${lib}\"" >> "${STATEDIR}/${packet}.cmds"
		fi
	    fi

	    lib_path="${lnk_path}"
	    continue
	elif test -f "${lib_path}"; then	# regular file
	    # is this a linker script?
	    if grep "GNU ld script" "${lib_path}" 1>/dev/null 2>&1; then
		echo "script - ${lib_path}"
		#
		# the libs are in the GROUP line
		# strip all braces and install all shared libs ( *.so*), ignore "GROUP" and static libs
		#
		for script_lib in $(sed -n -e "/GROUP/s/[()]//gp" "${lib_path}"); do
		    # deal with relative and absolute libs
		    case "${script_lib}" in
			/*.so*)
			    if [ "${script_lib#${sysroot}}" = "${script_lib}" ]; then
				script_lib="${sysroot}${script_lib}"
			    fi
			    ;;
			*.so*)
			    script_lib="$(ptxd_get_lib_path "${script_lib}")"
			    ;;
			*)
			    continue
			    ;;
		    esac
		    script_lib="$(ptxd_abspath "${script_lib}")"
		    echo "in script - ${script_lib}"
		    ptxd_install_toolchain_lib strip="${strip}" packet="${packet}" dest="${dest}" lib_path="${script_lib}" || return $?
		done
	    else
		# ordinary shared lib, just copy it
		echo "lib - ${lib_path}"

		if test -z "${prefix}"; then
		    ptxd_bailout "cannot identify prefix and no user supplied dest"
		fi

		perm="$(stat -c %a "${lib_path}")"

		echo "ptxd_install_file \"${lib_path}\" \"${prefix}/${lib}\" 0 0 \"${perm}\" \"${strip}\"" >> "${STATEDIR}/${packet}.cmds"

		# now create some links to that lib
		# e.g. libstdc++.so.6 -> libstdc++.so.6.6.6

		# the fullversion (6.6.6)
		v_full="${lib#*.so.}"
		# library name with major version (libstdc++.so.6)
		lib_v_major="${lib%${v_full}}${v_full%%.*}"

		if test "${v_full}" != "${lib}" -a \
		    "${lib_v_major}" != "${lib}"; then
		    echo "extra link - ${prefix}/${lib_v_major}"

		    echo "ptxd_install_link \"${lib}\" \"${prefix}/${lib_v_major}\"" >> "${STATEDIR}/${packet}.cmds"
		fi
	    fi
	else
	    echo "error: found ${lib_path}, but neither file nor link" 2>&1
	    return 1
	fi

	return 0
    done
}


#
# $@:
#     usr=<what to copy>
#     packet=<packet>
#     dest=<dest in sysroot>
#     strip=<true or false>
#
ptxd_install_toolchain_usr() {
    local sysroot_usr usr usr_src usr_perm

    eval "${@}"

    sysroot_usr="${PTXDIST_SYSROOT_TOOLCHAIN}/usr"

    if test -z "$(find ${sysroot_usr} -path "${sysroot_usr}/${usr}" -a \! -type d)"; then
	echo "file ${usr} not found"
	return 1
    fi

    find ${sysroot_usr} -path "${sysroot_usr}/${usr}" -a \! -type d | while read usr_src; do
	eval $(stat -c"usr_perm=%a" "${usr_src}")
	usr_dst="/usr${usr_src#${sysroot_usr}}"

	echo "usr - ${usr_dst}"

	echo "ptxd_install_file \"${usr_src}\" \"${usr_dst}\" 0 0 \"${usr_perm}\" \"${strip}\"" >> "${STATEDIR}/${packet}.cmds"
    done
}


ptxd_install_copy_toolchain() {
    local args opt lib usr

    while getopts "p:l:u:d:s::" opt; do
	case "${opt}" in
	    p)
		args="${args} packet=\"${OPTARG}\""
		;;
	    l)
		lib="${OPTARG}"
		;;
	    u)
		usr="${OPTARG}"
		;;
	    d)
		args="${args} dest=\"${OPTARG}\""
		;;
	    s)
		case "${OPTARG}" in
		    y|yes|1|true)
			args="${args} strip=y"
			;;
		    "")
			args="${args} strip="
			;;
		    *)
			args="${args} strip=n"
			;;
		esac
		;;
	esac
    done

    if [ -n "${lib}" ]; then
	if [ "${lib}" == "LINKER" ]; then
	    lib="$(ptxd_get_dl)" || return $?
	fi
	lib_path="$(ptxd_get_lib_path "${lib}")" || return $?
	ptxd_install_toolchain_lib "${args}" lib_path="${lib_path}" || return $?
    elif test -n "${usr}"; then
	ptxd_install_toolchain_usr "${args}" "usr=${usr}" || return $?
    fi
}


#
# main()
#
ptxd_install_copy_toolchain "${@}"
