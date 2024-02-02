#!/bin/bash
#
# Copyright (C) 2022 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# remove flags that are not needed and cause warnings from clangd
#
ptxd_make_world_compile_commands_cleanup() {
    sed -i \
	-e 's/ *-fno-diagnostics-show-caret//g' \
	"${pkg_dir}/compile_commands.json"
}
export -f ptxd_make_world_compile_commands_cleanup

ptxd_make_world_compile_commands_filter() {
    local src_cmds="${1:-${pkg_build_dir}/compile_commands.json}"
    local dst_cmds="${pkg_dir}/compile_commands.json"

    if [[ "${pkg_url}" =~ ^lndir:// ]]; then
	# find the real source dir for lndir:// URLs
	dst_cmds="$(ptxd_abspath "$(ptxd_file_url_path "${pkg_url}")")/compile_commands.json"
    fi

    if [ ! -e "${src_cmds}" ]; then
	ptxd_verbose "Ignoring missing '${src_cmds}'."
	return
    fi

    if [ "${src_cmds}" = "${dst_cmds}" ]; then
	if grep -q -F -e "${PTXDIST_CROSS_CPPFLAGS}" "${src_cmds}"; then
	    ptxd_warning "compile_commands.json is already up to date!"
	    return
	fi
	mv "${src_cmds}" "${src_cmds}.orig"
	src_cmds="${src_cmds}.orig"
    fi

    ptxd_verbose "Generating '$(ptxd_print_path "${dst_cmds}")'"
    sed \
	-e "s#\(\"command\": \" *[^ ]*\(gcc\|clang\) \)#\1 ${PTXDIST_CROSS_CPPFLAGS} ${pkg_cflags} #" \
	-e "s#\(\"command\": \" *[^ ]*++ \)#\1 ${PTXDIST_CROSS_CPPFLAGS} ${pkg_cxxflags} #" \
	"${src_cmds}" > "${dst_cmds}" &&
    ptxd_make_world_compile_commands_cleanup
}
export -f ptxd_make_world_compile_commands_filter

ptxd_make_world_compile_commands() {
    ptxd_make_world_init &&
    ptxd_make_world_compile_commands_filter "${@}"
}
export -f ptxd_make_world_compile_commands
