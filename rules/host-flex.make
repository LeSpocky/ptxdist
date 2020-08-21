# -*-makefile-*-
#
# Copyright (C) 2010 by Erwin Rol <erwin@erwinrol.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_FLEX) += host-flex

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_FLEX_CONF_TOOL	:= autoconf
HOST_FLEX_CONF_OPT	:= \
	$(HOST_AUTOCON) \
	--disable-nls \
	--disable-rpath \
	--disable-warnings \
	--disable-libfl \
	--enable-bootstrap

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

HOST_FLEX_MAKE_OPT	:= \
	SUBDIRS=src

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

HOST_FLEX_INSTALL_OPT	:= \
	$(HOST_FLEX_MAKE_OPT) \
	install

# vim: syntax=make
