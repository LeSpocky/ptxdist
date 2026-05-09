#!/bin/bash
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#


#
# $1: checksum tool, e.g. md5sum
# $2: hash type suffix appended to <PKG>_, e.g. MD5
#
ptxd_make_world_update_checksum() {
    local tool="${1}"
    local SUFFIX="${2}"
    local config file_dotconfig
    set -- $("${tool}" "${pkg_src}")
    local checksum="${1}"

    local PKG_SUM="PTXCONF_${pkg_PKG}_${SUFFIX}"
    for config in "${PTXDIST_PLATFORMCONFIG}" "${PTXDIST_PTXCONFIG}"; do
	file_dotconfig="${config}"
	ptxd_normalize_config
	if grep -q "^${PKG_SUM}=\"" "${file_dotconfig}"; then
	    sed -i "s/^${PKG_SUM}=\".*$/${PKG_SUM}=\"${checksum}\"/" "${file_dotconfig}"
	    ptxd_warning "New checksum for ${pkg_PKG}: ${checksum} in $(ptxd_print_path "${file_dotconfig}")"
	    if [ -e "${file_dotconfig}.diff" ]; then
		if grep -q "^${PKG_SUM}=\"" "${file_dotconfig}.diff"; then
		    sed -i "s/^${PKG_SUM}=\".*$/${PKG_SUM}=\"${checksum}\"/" "${file_dotconfig}.diff"
		else
		    echo "${PKG_SUM}=\"${checksum}\"" >> "${file_dotconfig}.diff"
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
	ptxd_bailout "Could not update checksum for '${pkg_label}': makefile not found"
    fi
    local count=$(grep "^${pkg_PKG}_${SUFFIX}[ 	]*:=" "${pkg_makefile}" 2> /dev/null | wc -l)
    if [ "${count}" -gt 1 ]; then
	ptxd_bailout "Could not update checksum for '${pkg_label}': ${pkg_PKG}_${SUFFIX} found ${count} times in '$(ptxd_print_path ${pkg_makefile})'."
    fi
    sed -i "s/^\(\<${pkg_PKG}_${SUFFIX}[ 	]*:=\)\( *[a-f0-9]*\)\+\$/\1 ${checksum}/" "${pkg_makefile}"
    if ! grep -q "${checksum}\$" "${pkg_makefile}"; then
	ptxd_bailout "Could not update checksum for '${pkg_label}': ${pkg_PKG}_${SUFFIX} not found"
    fi
    ptxd_warning "New checksum for ${pkg_PKG}: ${checksum} in $(ptxd_print_path "${pkg_makefile}")"
}
export -f ptxd_make_world_update_checksum

# try to update the md5sum of the current package
# this only works if the makefile contains a "<PKG>_MD5 := ..." line.
ptxd_make_world_update_md5() {
    ptxd_make_world_update_checksum md5sum MD5
}
export -f ptxd_make_world_update_md5

# try to update the sha256sum of the current package
# this only works if the makefile contains a "<PKG>_SHA256 := ..." line.
ptxd_make_world_update_sha256() {
    ptxd_make_world_update_checksum sha256sum SHA256
}
export -f ptxd_make_world_update_sha256
