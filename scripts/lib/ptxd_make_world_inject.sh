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
    target="${inject_dest}/$(echo ${inject_file} | cut -d ":" -f 2)"

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
    mkdir -p "$(dirname "${target}")"
    cp ${source} ${target}
}
export -f ptxd_make_inject


ptxd_make_world_inject() {
    ptxd_make_world_init || return

    if [ -z "${pkg_inject_oot}" ]; then
	pkg_inject_oot=NO
    fi

    case "${pkg_inject_oot}" in
	"YES") inject_dest="${pkg_build_dir}" ;;
	"NO")  inject_dest="${pkg_dir}" ;;
	*)     ptxd_bailout "<PKG>_INJECT_OOT: please set to YES or NO" ;;
    esac

    if [ "${pkg_build_oot:-NO}" = 'NO' ] && [ "${pkg_inject_oot}" != 'NO' ]; then
	ptxd_warning "<PKG>_BUILD_OOT and <PKG>_INJECT_OOT contradict each other." \
	    "Using $(ptxd_print_path ${inject_dest}) as inject destination anyways."
    fi

    if [ ! -d "${inject_dest}" ]; then
	ptxd_bailout "<PKG> inject destination dir missing." \
	    "Correct placement of world/inject depends on <PKG>_BUILD_OOT and <PKG>_INJECT_OOT." \
	    "Check order of calls in prepare stage!"
    fi

    for inject_file in ${pkg_inject_files}; do
	ptxd_make_inject || return
    done
}
export -f ptxd_make_world_inject
