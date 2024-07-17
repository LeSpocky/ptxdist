# -*-makefile-*-
#
# Copyright (C) 2011 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBFFI) += host-libffi

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBFFI_CONF_TOOL	:= autoconf
HOST_LIBFFI_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-builddir \
	--disable-static \
	--disable-docs \
	--disable-multi-os-directory

# vim: syntax=make
