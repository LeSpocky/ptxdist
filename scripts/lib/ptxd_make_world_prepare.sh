#!/bin/bash
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_world_hash()
{
    local -a hashes
    local hash h
    local target="${1}"
    local ptr="pkg_${target}"
    local pkg_hash="${!ptr}"

    ptxd_make_world_init || return

    hashes=( "${ptx_state_dir}/${pkg_label}."*".${target}" )
    hash="${ptx_state_dir}/${pkg_label}.${pkg_hash}.${target}"

    if [ ${hashes[0]} = "${ptx_state_dir}/${pkg_label}.*.${target}" ]; then
	hashes=()
    fi
    if [ ${#hashes[@]} -gt 1 ]; then
	ptxd_warning "more than one ${target} found!"
    fi
    for h in "${hashes[@]}"; do
	if [ "${h}" != "${hash}" ]; then
	    if [ "${target}" = "cfghash" ]; then
		echo -e "Configuration changed! Reconfiguring...\n"
	    else
		echo -e "Patches changed! Reextracting...\n"
	    fi
	fi
	rm "${h}" || break
    done
}
export -f ptxd_make_world_hash

#
# perform sanity check
#
ptxd_make_world_prepare_sanity_check() {
    if [ "${pkg_conf_tool}" = "autoconf" -a \! -x "${pkg_conf_dir_abs}/configure" ]; then
	cat >&2 <<EOF

error: 'configure' not found or not executable in:
'${pkg_conf_dir_abs}'

EOF
	exit 1
    elif [ "${pkg_conf_tool}" = "cmake" -a \! -e "${pkg_conf_dir_abs}/CMakeLists.txt" ]; then
	cat >&2 <<EOF

error: 'CMakeLists.txt' not found in:
'${pkg_conf_dir_abs}'

EOF
	exit 1
    elif [ \( "${pkg_conf_tool}" = "qmake" -o "${pkg_conf_tool}" = "perl" \) -a "${pkg_type}" != "target" ]; then
	cat >&2 <<EOF

error: only ${pkg_conf_tool} target packages are supported

EOF
	exit 1
    fi
}
export -f ptxd_make_world_prepare_sanity_check

#
# prepare for cmake based pkgs
#
ptxd_make_world_prepare_cmake() {
    full_log="CMakeFiles/CMakeOutput.log"
    ptxd_eval \
	"${pkg_path}" \
	"${pkg_env}" \
	"${pkg_conf_env}" \
	cmake \
	"${pkg_conf_opt}" \
	"${pkg_conf_dir}" &&
    ptxd_make_world_compile_commands_filter
}
export -f ptxd_make_world_prepare_cmake


#
# prepare for qmake based pkgs
#
ptxd_make_world_prepare_qmake() {
    ptxd_eval \
	"${pkg_path}" \
	"${pkg_env}" \
	"${pkg_conf_env}" \
	qmake \
	"${pkg_conf_opt}" \
	"${pkg_conf_dir}"/*.pro
}
export -f ptxd_make_world_prepare_qmake


#
# prepare for autoconf based pkgs
#
ptxd_make_world_prepare_autoconf() {
    full_log="config.log"
    ptxd_eval \
	"${pkg_path}" \
	"${pkg_env}" \
	"${pkg_conf_env}" \
	"${pkg_conf_dir}/configure" \
	"${pkg_conf_opt}"
}
export -f ptxd_make_world_prepare_autoconf


#
# prepare for kconfig based pkgs
#
ptxd_make_world_prepare_kconfig() {
    ptxd_make_kconfig oldconfig
}
export -f ptxd_make_world_prepare_kconfig


#
# prepare for perl modules
#
ptxd_make_world_prepare_perl() {
    ptxd_eval \
	"${pkg_path}" \
	"${pkg_env}" \
	"${pkg_conf_env}" \
	cross-perl \
	Makefile.PL \
	"${pkg_conf_opt}"
}
export -f ptxd_make_world_prepare_perl


#
# prepare for meson based pkgs
#
ptxd_make_world_prepare_meson() {
    full_log="meson-logs/meson-log.txt"
    ptxd_eval \
	"${pkg_path}" \
	"${pkg_env}" \
	"${pkg_conf_env}" \
	meson setup \
	"${pkg_conf_opt}" \
	"${pkg_conf_dir}" &&
    ptxd_make_world_compile_commands_filter
}
export -f ptxd_make_world_prepare_meson

#
# prepare for cargo based pkgs
#
ptxd_make_world_prepare_cargo_check() {
    local arg cargo_lock_md5 crate workspace
    local -a tmp
    local pkg_makefile_cargo="${pkg_makefile%.make}.cargo.make"

    if [ -z "${pkg_cargo_lock}" ]; then
	return
    fi

    if [ -z "${pkg_cargo_lock_md5}" ]; then
	ptxd_bailout "Cargo dependency config is missing!" \
	    "Run 'ptxdist cargosync ${pkg_label}' to generate '$(ptxd_print_path ${pkg_makefile_cargo})'."
    fi
    tmp=( $(cd "${pkg_dir}" && md5sum "${pkg_cargo_lock}" 2> /dev/null) )
    if [ "${tmp[0]}" != "${pkg_cargo_lock_md5}" ]; then
	echo "|${tmp[0]}|${pkg_cargo_lock_md5}|"
	ptxd_bailout "${pkg_cargo_lock} has changed!" \
	    "Run 'ptxdist cargosync ${pkg_label}' to regenerate '$(ptxd_print_path ${pkg_makefile_cargo})'."
    fi &&
    ptxd_in_path PTXDIST_PATH_SCRIPTS vendor-cargo-workspace-package &&
    vendor_cargo_workspace_package="${ptxd_reply}" &&

    find "${pkg_cargo_home}/source" -maxdepth 1 -type l | while read link; do
	crate="$(readlink "${link}")" &&
	crate="${crate#../workspaces/}" &&
	workspace="${pkg_cargo_home}/workspaces/${crate%%/*}" &&
	crate="${pkg_cargo_home}/workspaces/${crate}" &&
	if [ -e "${link}/Cargo.toml.orig" ]; then
	    # already handed during a previous prepare run
	    continue
	fi &&
	cp "${crate}/Cargo.toml" "${crate}/Cargo.toml.orig" &&
	set -x
	"${vendor_cargo_workspace_package}" \
	    --input "${crate}/Cargo.toml.orig" \
	    --output "${crate}/Cargo.toml" \
	    --workspace "${workspace}/Cargo.toml" || {
	    rm "${link}/Cargo.toml.orig"
	    return
	}
    done
}
export -f ptxd_make_world_prepare_cargo_check

ptxd_make_world_prepare_init() {
    # delete existing build_dir
    if [ -n "${pkg_build_oot}" ]; then
	if [ "${pkg_build_oot}" = "YES" ]; then
	    rm -rf   -- "${pkg_build_dir}"
	fi &&
	mkdir -p -- "${pkg_build_dir}"
    fi &&
    # remove files from sysroot from the last build
    ptxd_make_world_clean_sysroot
}
export -f ptxd_make_world_prepare_init

#
# generic prepare
#
ptxd_make_world_prepare() {
    local full_log
    ptxd_make_world_init &&
    ptxd_make_world_prepare_sanity_check || return

    if [ -z "${pkg_conf_dir_abs}" ]; then
	# no conf dir -> assume the package has nothing to configure.
	return
    fi

    ptxd_make_world_prepare_init &&
    ptxd_make_world_prepare_cargo_check|| return

    case "${pkg_conf_tool}" in
	cmake|meson)
	    if ! [[ "${pkg_build_deps}" =~ "host-${pkg_conf_tool}" ]]; then
		ptxd_bailout "'${pkg_label}' uses '${pkg_conf_tool}' but does not select 'host-${pkg_conf_tool}'"
	    fi
	    ;;
	qmake)
	    if ! [[ " ${pkg_build_deps} " =~ ' 'qt[56]' ' ]]; then
		ptxd_bailout "'${pkg_label}' uses 'qmake' but does not select 'qt5' or 'qt6'"
	    fi
	    ;;
	perl)
	    if ! [[ " ${pkg_build_deps} " =~ ' perl ' ]]; then
		ptxd_bailout "'${pkg_label}' uses 'perl' but does not select 'perl' <${pkg_build_deps}>"
	    fi
	    ;;
	python*)
	    if ! [[ "${pkg_build_deps}" =~ (host-(system-)?)?"${pkg_conf_tool}" ]]; then
		ptxd_bailout "'${pkg_label}' uses '${pkg_conf_tool}' but does not select any python"
	    fi
	    ;;
	scons)
	    if ! [[ "${pkg_build_deps}" =~ "host-python3-${pkg_conf_tool}" ]]; then
		ptxd_bailout "'${pkg_label}' uses '${pkg_conf_tool}' but does not select 'host-python3-${pkg_conf_tool}'"
	    fi
	    ;;
    esac

    case "${pkg_conf_tool}" in
	autoconf|cmake|qmake|kconfig|perl|meson)
	    cd -- "${pkg_build_dir}" &&
	    ptxd_make_world_prepare_"${pkg_conf_tool}" ;;
	python|python3|scons|cargo)
	    : ;; # nothing to do
	"NO") echo "prepare stage disabled." ;;
	"")   echo "No prepare tool found. Do nothing." ;;
	*)    ptxd_bailout "automatic prepare tool selection failed. Set <PKG>_CONF_TOOL";;
    esac
    local ret=$?
    if [ ${ret} -ne 0 -a -f "${full_log}" ]; then
	echo
	echo "Full ${pkg_conf_tool} logfile (${full_log}):"
	echo
	cat "${pkg_build_dir}/${full_log}"
    fi >&${PTXDIST_QUIET:=${PTXDIST_FD_LOGFILE}}
    return ${ret}
}
export -f ptxd_make_world_prepare
