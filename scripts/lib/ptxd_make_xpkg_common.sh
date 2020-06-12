#!/bin/bash
#
# Copyright (C) 2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# perm file separator changed to allow ':' in filenames
#
# $1: perm file path
#
ptxd_check_obsolete_perm() {
	while [ $# -gt 0 ]; do
		if test -s "${1}" && ! grep -q -P "\x1F" "${1}"; then
			ptxd_bailout "obsolete perm file detected, please run 'ptxdist clean root'"
		fi
		shift
	done
}
export -f ptxd_check_obsolete_perm

#
# change permissions and ownership of files and create device nodes.
# the paths specified in the permissions file are prefixed with the
# current working directory.
#
# typically used to create dev nodes in a fakeroot environment in the
# imageing process
#
# $1: permissions file
#
ptxd_dopermissions() {
	ptxd_check_obsolete_perm "${@}" &&
	ptxd_in_path PTXDIST_PATH_SCRIPTS lib/ptxd_lib_dopermissions.awk &&
	gawk -f "${ptxd_reply}" "${@}"
}
export -f ptxd_dopermissions

#
# If multiple packages create the same directory with different ownership
# or permissions, then the result depends on the installation order.
# Avoid this by verifying that such a mismatch does not happen.
#
ptxd_check_dir_permissions() {
	ptxd_check_obsolete_perm "${@}"
	ptxd_in_path PTXDIST_PATH_SCRIPTS lib/ptxd_lib_check_dir_permissions.awk &&
	gawk -f "${ptxd_reply}" "${@}"
}
export -f ptxd_check_dir_permissions

#
# ptxd_do_xpkg_map - do the mapping from package name to xpkg name(s)
#
# in:
# ${@}	package name(s)
#
# out:
# ${ptxd_reply[@]}	array of xpkg names
#
# return:
# 0	if xpkg names are found
# 1	if no xpkg names are found
#
# ptxd_reply (array)
#
ptxd_do_xpkg_map() {
    local pkg
    for pkg in "${@}"; do
	if ! [[ " ${ptx_packages_selected} " =~ " ${pkg} " ]]; then
	    ptxd_bailout "${pkg} is not a package or not selected"
	fi
    done
    set -- "${@/#/${ptx_state_dir}/}"

    ptxd_reply=( $(cat "${@/%/.xpkg.map}" 2>/dev/null) )

    [ ${#ptxd_reply[@]} -ne 0 ]
}
export -f ptxd_do_xpkg_map


#
# initialize variables needed for packaging
#
ptxd_make_xpkg_init() {
    if [ -z "${pkg_xpkg}" ]; then
	ptxd_bailout "'pkg_xpkg' undefined"
    fi

    #
    # sanitize pkg_xpkg name
    #
    # replace "_" by "-"
    #
    pkg_xpkg="${pkg_xpkg//_/-}"

    #
    # sanitize pkg_version
    #
    # separate (alpha|beta|gamma|rc) with "~"
    # replace "_" by "."
    # replace "-" by "+"
    #
    if [ -z "${pkg_xpkg_version}" ]; then
	pkg_xpkg_version="$(sed -r 's/[~\.-]?(alpha|beta|gamma|rc|pre)/~\1/g' <<< ${pkg_version} | tr '_-' '.+')"
    fi
    if [ -z ${pkg_xpkg_version} ]; then
	ptxd_bailout "${FUNCNAME}: please define <PKG>_VERSION"
    fi

    ptxd_make_world_init || return

    # license
    pkg_license="${pkg_license:-unknown}"
    pkg_xpkg_license="${pkg_xpkg_license:-${pkg_license}}"
    pkg_xpkg_license_file="${ptx_state_dir}/${pkg_xpkg}.license"

    # packaging stuff
    pkg_xpkg_install_deps="${ptx_state_dir}/${pkg_xpkg}.deps"
    pkg_xpkg_perms="${ptx_state_dir}/${pkg_xpkg}.perms"
    pkg_xpkg_cmds="${ptx_state_dir}/${pkg_xpkg}.cmds"

    pkg_xpkg_tmp="${ptx_pkg_dir}/${pkg_xpkg}.tmp"
    pkg_xpkg_control_dir="${pkg_xpkg_tmp}/CONTROL"
    pkg_xpkg_control="${pkg_xpkg_control_dir}/control"
    pkg_xpkg_conffiles="${pkg_xpkg_control_dir}/conffiles"
    pkg_xpkg_dbg_tmp="${ptx_pkg_dir}/${pkg_xpkg}-dbgsym.tmp"
    pkg_xpkg_dbg_control_dir="${pkg_xpkg_dbg_tmp}/CONTROL"
    pkg_xpkg_dbg_control="${pkg_xpkg_dbg_control_dir}/control"
}
export -f ptxd_make_xpkg_init
