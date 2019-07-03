#!/bin/bash
#
# Copyright (C) 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_image_fix_permissions_generate() {
    case "${kind}" in
	n)
	    # erase existing nodes
	    cat >&3 <<EOF
	    echo "creating device node: ${file##${PTXDIST_WORKSPACE}/}"
	    rm -rf -- "${file}" &&
	    mknod  -- "${file}" ${type} ${major_should} ${minor_should} &&
	    chown  -- ${uid_should}\:${gid_should} "${file}" &&
	    chmod  -- ${prm_should}		   "${file}" || exit

EOF
	    ;;
	l)
	    ;;
    esac
}
export -f ptxd_make_image_fix_permissions_generate



ptxd_make_image_fix_permissions_check() {
    local workdir="${1}"
    local ifs_orig="${IFS}"
    IFS="$(echo -e "\x1F")"

    ptxd_check_obsolete_perm "${ptxd_reply_perm_files[@]}"

    # just care about dev-nodes, for now
    egrep -h "^[n]${IFS}" "${ptxd_reply_perm_files[@]}" |
    while read kind file uid_should gid_should prm_should type major_should minor_should; do
	local fixup=false
	file="${workdir}/${file#/}"

	if [ \! -e "${file}" ]; then
	    fixup=true
	else
	    local uid_is gid_is prm_is
	    eval $(stat -c"uid_is=%u gid_is=%g prm_is=%a" "${file}")

	    # check user/group and permissions
	    if [ \
		 ${uid_is} -ne	${uid_should} -o \
		 ${gid_is} -ne	${gid_should} -o \
		0${prm_is} -ne 0${prm_should} ]; then
		fixup=true

	    # for dev-nodes and pipes
	    elif [ "${kind}" = "n" ]; then
		if [ \
		    "${type}" = "p" -a ! -p "${file}" -o \
		    "${type}" = "c" -a ! -c "${file}" -o \
		    "${type}" = "b" -a ! -b "${file}" ]; then
		    fixup=true

		# for dev-nodes check major/minor
		elif [ "${type}" != "p" ]; then
		    local major_is minor_is
		    eval $(stat -c"major_is=0x%t minor_is=0x%T" "${file}")

		    # convert from hex to dec
		    major_is=$(( major_is ))
		    minor_is=$(( minor_is ))

		    if [ \
			${major_is} -ne ${major_should} -o \
			${minor_is} -ne ${minor_should} ]; then
			fixup=true
		    fi
		fi
	    fi
	fi

	if [ "${fixup}" = "true" ]; then
	    ptxd_make_image_fix_permissions_generate
	fi
    done

    IFS="${ifs_orig}"
}
export -f ptxd_make_image_fix_permissions_check


#
# ptxd_make_image_fix_permissions - create device nodes in nfsroots
#
ptxd_make_image_fix_permissions() {
    ptxd_make_image_init &&

    local fixscript="${PTXDIST_TEMPDIR}/${FUNCNAME}" &&
    touch "${fixscript}" &&
    chmod +x "${fixscript}" &&

    # get permission files
    local -a ptxd_reply_ipkg_file ptxd_reply_perm_files &&
    ptxd_get_ipkg_files ${image_pkgs_selected_target} || return

    set -- "${ptx_nfsroot}"

    exec 3> "${fixscript}"
    while [ ${#} -ne 0 ]; do
	ptxd_make_image_fix_permissions_check "${1}" || return
	shift
    done
    exec 3>&-

    # nothing to do!
    if [ \! -s "${fixscript}" ]; then
	return
    fi

cat <<EOF



-------------------------------------------------------------------
For a proper NFS-root environment, some device nodes are essential.
In order to create them root privileges are required.
-------------------------------------------------------------------

EOF
    read -t 5 -p "(Please press enter to start 'sudo' to gain root privileges.)"
    if [ ${?} -ne 0 ]; then
	cat >&2 <<EOF



WARNING: NFS-root might not be working correctly!


EOF
	return
    fi

    if ! sudo "${fixscript}"; then
	cat <<EOF

error: creation of device node(s) failed.

EOF
	return 1
    fi
    echo
}
export -f ptxd_make_image_fix_permissions
