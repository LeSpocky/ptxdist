#!/bin/bash
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# get stuff
#
ptxd_make_world_get() {
    ptxd_make_world_init &&

    case "${pkg_url}" in
	file://*)
	    if [ -n "${pkg_src}" ]; then
		ptxd_bailout "<PKG>_SOURCE must not be defined when using a file:// URL!"
	    fi
	    ;;
    esac

    if [ -n "${pkg_src}" ]; then
	ptxd_make_get "${pkg_src}" "${pkg_url}" &&

	ptxd_make_check_src_impl "${pkg_src}" "${pkg_md5}" && return

	if [ "${PTXCONF_SETUP_CHECK}" = "update" ]; then
	    ptxd_make_world_update_md5
	elif [ -z "${pkg_md5}" ]; then
	    ptxd_bailout "Checksum for '${pkg_label}' (${pkg_src}) missing."
	else
	    ptxd_bailout "Wrong checksum for '${pkg_label}' (${pkg_src})"
	fi
    fi
}
export -f ptxd_make_world_get
