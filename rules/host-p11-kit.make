# -*-makefile-*-
#
# Copyright (C) 2018 by Juergen Borleis <jbe@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_P11_KIT) += host-p11-kit

#
# Paths and names
#
HOST_P11_KIT_DEVPKG	:= NO

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#HOST_P11_KIT_CONF_ENV	:= $(HOST_ENV)

#
# autoconf
#
HOST_P11_KIT_CONF_TOOL	:= autoconf
HOST_P11_KIT_CONF_OPT	:= \
	$(HOST_AUTOCONF_SYSROOT) \
	--disable-nls \
	--disable-trust-module \
	--disable-doc \
	--disable-doc-html \
	--disable-doc-pdf \
	--enable-debug=no \
	--with-hash-impl=internal \
	--without-systemd

# vim: syntax=make
