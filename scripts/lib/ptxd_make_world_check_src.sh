#!/bin/bash
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#


#
# try to update the md5sum of the current package
# this only works if the makefile contains a "<PKG>_MD5 := ..." line.
#
ptxd_make_world_update_md5() {
    local config file_dotconfig
    set -- $(md5sum "${pkg_src}")
    local md5="${1}"

    local PKG_MD5="PTXCONF_${pkg_PKG}_MD5"
    for config in "${PTXDIST_PLATFORMCONFIG}" "${PTXDIST_PTXCONFIG}"; do
	file_dotconfig="${config}"
	ptxd_normalize_config
	if grep -q "^${PKG_MD5}=\"" "${file_dotconfig}"; then
	    sed -i "s/^${PKG_MD5}=\".*$/${PKG_MD5}=\"${md5}\"/" "${file_dotconfig}"
	    ptxd_warning "New checksum for ${pkg_PKG}: ${md5} in $(ptxd_print_path "${file_dotconfig}")"
	    if [ -e "${file_dotconfig}.diff" ]; then
		if grep -q "^${PKG_MD5}=\"" "${file_dotconfig}.diff"; then
		    sed -i "s/^${PKG_MD5}=\".*$/${PKG_MD5}=\"${md5}\"/" "${file_dotconfig}.diff"
		else
		    echo "${PKG_MD5}=\"${md5}\"" >> "${file_dotconfig}.diff"
		    if [ "${config}" == "${PTXDIST_PLATFORMCONFIG}" ]; then
			arg=" platform"
		    fi
		    ptxd_warning "$(ptxd_print_path "${file_dotconfig}") is dirty. Run 'ptxdist oldconfig${arg}'."
		fi
	    fi
	    return
	fi
    done
    if [ -z "${pkg_makefile}" ]; then
	ptxd_bailout "Could not update md5sum for '${pkg_label}': makefile not found"
    fi
    local count=$(grep "^${pkg_PKG}_MD5[ 	]*:=" "${pkg_makefile}" 2> /dev/null | wc -l)
    if [ "${count}" -gt 1 ]; then
	ptxd_bailout "Could not update md5sum for '${pkg_label}': ${pkg_PKG}_MD5 found ${count} times in '$(ptxd_print_path ${pkg_makefile})'."
    fi
    sed -i "s/^\(\<${pkg_PKG}_MD5[ 	]*:=\) *[a-f0-9]*\$/\1 ${md5}/" "${pkg_makefile}"
    if ! grep -q "${md5}\$" "${pkg_makefile}"; then
	ptxd_bailout "Could not update md5sum for '${pkg_label}': ${pkg_PKG}_MD5 not found"
    fi
    ptxd_warning "New checksum for ${pkg_PKG}: ${md5} in $(ptxd_print_path "${pkg_makefile}")"
}
export -f ptxd_make_world_update_md5

#
# verify the md5sum of the source file of the current package
#
ptxd_make_world_check_src() {
    ptxd_make_world_init &&

    if [ -z "${pkg_src}" ]; then
	return
    fi
    ptxd_make_check_src_impl "${pkg_src}" "${pkg_md5}" && return

    if [ "${PTXCONF_SETUP_CHECK}" = "update" ]; then
	ptxd_make_world_update_md5
    elif [ -z "${pkg_md5}" ]; then
	ptxd_bailout "md5sum for '${pkg_label}' (${pkg_src}) missing."
    else
	ptxd_bailout "Wrong md5sum for '${pkg_label}' (${pkg_src})"
    fi
}
export -f ptxd_make_world_check_src
