# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XORG_LIB_XAU) += host-xorg-lib-xau

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_XORG_LIB_XAU_CONF_TOOL	:= autoconf
HOST_XORG_LIB_XAU_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-xthreads \
	--$(call ptx/endis, PTXDIST_Y2038)-year2038

# vim: syntax=make
