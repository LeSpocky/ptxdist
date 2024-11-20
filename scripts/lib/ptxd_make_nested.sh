#!/bin/bash
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_nested_ptxdist_impl() {
    # close all unneeded fds. The nested PTXdist will open its own fds.
    exec 9>&-
    if [ -n "${PTXDIST_FD_STDOUT}" ]; then
	exec {PTXDIST_FD_STDOUT}>&-
	exec {PTXDIST_FD_STDERR}>&-
    fi
    exec {ptxd_make_serialize_get_writefd}>&-
    exec {ptxd_make_serialize_get_readfd}>&-
    exec {ptxd_make_serialize_extract_writefd}>&-
    exec {ptxd_make_serialize_extract_readfd}>&-

    # let shell split by IFS
    set -- ${PTXCONF_SETUP_ENV_WHITELIST} ${PTXDIST_ENV_WHITELIST} PTXDIST_ENV_WHITELIST
    whitelist="${*}"
    whitelist="${whitelist:+|}${whitelist// /|}"

    unset $({
	export -p  | sed -n 's/^declare -x \([^=]*\).*$/\1/p'
	export -fp | sed -n 's/^declare -fx \([^=]*\).*$/\1/p'
	} | grep -E -v "^(args|PTXDIST_PTXRC|PTX_AUTOBUILD_DESTDIR|PTXDIST_PLATFORMDIR|CCACHE_.*|PWD|HOME|USER|PATH|TERM|COLUMNS|LINES|DISPLAY|TMPDIR|http_proxy|https_proxy|ftp_proxy|no_proxy${whitelist})$")

    eval "${args[@]}"
}
export -f ptxd_make_nested_ptxdist_impl

#
# Clear the environment and call a nested PTXdist.
# Can be used to build other platforms.
#
ptxd_make_nested_ptxdist() {
    local -a args

    ptxd_make_world_init || return

    if [ -z "${pkg_workspace}" ]; then
	pkg_workspace="${PTXDIST_WORKSPACE}"
    fi
    args=( "cd" "${pkg_workspace}" "&&" "${PTXDIST_TOPDIR}/bin/ptxdist" )

    PTXDIST_TOOLCHAIN="$(readlink "${PTXDIST_PLATFORMDIR}/selected_toolchain")"
    PATH=$(sed -e 's;[^:]*/sysroot-\(host\|cross\)/[^:]*:;;g' -e "s;${PTXDIST_TOPDIR}/bin:;;" -e "s;${PTXDIST_TOOLCHAIN}:;;" <<< "${PATH}")

    if [ "${PTXDIST_WORKSPACE}" != "${pkg_workspace}" ]; then
	unset PTXDIST_PLATFORMDIR
	args[${#args[*]}]="--auto-version"
    fi

    if [ "${PTXDIST_DIRTY}" = true ]; then
	args[${#args[*]}]="--dirty"
    fi
    if [ "${PTXDIST_FORCE}" = true ]; then
	args[${#args[*]}]="--force"
    fi
    if [ "${PTXDIST_PEDANTIC}" = true ]; then
	args[${#args[*]}]="--pedantic"
    fi
    if [ "${PTXDIST_QUIET}" = 1 ]; then
	args[${#args[*]}]="--quiet"
    fi
    if [ "${PTXDIST_VERBOSE}" = 1 ]; then
	args[${#args[*]}]="--verbose"
    fi
    if [ -n "${PTXDIST_PARALLEL_FLAGS}" ]; then
	args[${#args[*]}]="${PTXDIST_PARALLEL_FLAGS}"
    fi
    if [[ "${PTXDIST_JOBSERVER_FLAGS}" =~ ^--jobserver-auth ]]; then
	args[${#args[*]}]="${PTXDIST_JOBSERVER_FLAGS}"
    fi
    args+=( "${@}" )

    ptxd_verbose "executing:" "${args[@]}"

    # run ptxdist but don't log it. It has it's on logfile
    (
	if [ -n "${PTXDIST_FD_STDOUT}" ]; then
	    exec 1> >(sed "s/^/${pkg_label}: /" >&${PTXDIST_FD_STDOUT})
	    exec 2> >(sed "s/^/${pkg_label}: /" >&${PTXDIST_FD_STDERR})
	fi
	ptxd_make_nested_ptxdist_impl
    )
}
export -f ptxd_make_nested_ptxdist
