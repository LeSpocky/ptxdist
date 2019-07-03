#!/bin/bash
#
# Copyright (C) 2005, 2006, 2007 Robert Schwebel <r.schwebel@pengutronix.de>
#               2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2011 by George McCollister <george.mccollister@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
#
#
ptxd_make_xpkg_fixup() {
    ptxd_make_xpkg_init || return

    case "${pkg_xpkg_fixup_from}" in
	AUTHOR)
	    pkg_xpkg_fixup_to="`echo ${pkg_xpkg_fixup_to} | sed -e 's/\([^\\]\)@/\1\\\@/g'`"
	    ;;
	DEPENDS|PACKAGE|VERSION)
	    return
	    ;;
    esac

    if [ -n "${pkg_xpkg_fixup_to}" ]; then
	echo -n "install_fixup:	@${pkg_xpkg_fixup_from}@ -> ${pkg_xpkg_fixup_to} ... "
	sed -i -e "s,@$pkg_xpkg_fixup_from@,$pkg_xpkg_fixup_to,g" "${pkg_xpkg_control}" || return
	sed -i -e "s,@$pkg_xpkg_fixup_from@,$pkg_xpkg_fixup_to,g" "${pkg_xpkg_dbg_control}" || return
    else
	echo -n "install_fixup:	append '${pkg_xpkg_fixup_from}' ... "
	echo "${pkg_xpkg_fixup_from}" >> "${pkg_xpkg_control}" || return
    fi
    echo "done."
}

export -f ptxd_make_xpkg_fixup
