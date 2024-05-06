#!/bin/bash
#
# Copyright (C) 2021 by Michael Riesch <michael.riesch@wolfvision.net>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_inject() {
    local source target

    source="$(echo ${inject_file} | cut -d ":" -f 1)"
    target="${pkg_dir}/$(echo ${inject_file} | cut -d ":" -f 2)"

    if [[ "${source}" =~ ^/.* ]]; then
	ptxd_bailout "'${source}' must not be an absolute path!" \
	    "Use <PKG>_INJECT_PATH to specify the search path."
    fi

    if ! ptxd_in_path pkg_inject_path "${source}"; then
	ptxd_bailout "Blob '${source}' not found in '${pkg_inject_path}'."
    fi
    source="${ptxd_reply}"

    echo -e "\nInject file $(ptxd_print_path ${source}) into" \
	 "$(ptxd_print_path ${target})..."
    cp ${source} ${target}
}
export -f ptxd_make_inject


ptxd_make_world_inject() {
    ptxd_make_world_init || return

    if [ -z "${pkg_dir}" ]; then
	ptxd_bailout "<PKG>_DIR empty, no destination to inject to."
    fi

    for inject_file in ${pkg_inject_files}; do
	ptxd_make_inject || return
    done
}
export -f ptxd_make_world_inject
