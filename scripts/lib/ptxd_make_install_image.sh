#!/bin/bash
#
# Copyright (C) 2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#


ptxd_make_image_install_record() {
    (
	if [ -e "${pkg_image_stamp}" ]; then
	    grep -v "^${pkg_image}$" "${pkg_image_stamp}"
	fi
	echo "${pkg_image}"
    ) > "${pkg_image_stamp}.tmp" &&
    mv "${pkg_image_stamp}.tmp" "${pkg_image_stamp}"
}
export -f ptxd_make_image_install_record

ptxd_make_image_install() {
    ptxd_make_world_init || return
    local pkg_image_stamp="${ptx_state_dir}/${pkg_label}.images"

    if [ -z "${pkg_image}" ]; then
	pkg_image="$(basename "${pkg_file}")"
    fi
    pkg_image="${ptx_image_dir}/${pkg_image}"

    echo "Installing '$(ptxd_print_path "${pkg_file}")' to '$(ptxd_print_path "${pkg_image}")'"

    install -D -m644 "${pkg_file}" "${pkg_image}" &&
    ptxd_make_image_install_record
}
export -f ptxd_make_image_install

ptxd_make_image_install_link() {
    ptxd_make_world_init || return
    local pkg_image_stamp="${ptx_state_dir}/${pkg_label}.images"

    pkg_image="${ptx_image_dir}/${pkg_image}"

    echo "Linking '${pkg_file}' to '$(ptxd_print_path "${pkg_image}")'"

    ln -sf "${pkg_file}" "${pkg_image}" &&
    ptxd_make_image_install_record
}
export -f ptxd_make_image_install_link
