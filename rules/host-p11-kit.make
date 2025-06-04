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

# stdbool.h check is broken with gcc-15 (-std=c23)
HOST_P11_KIT_CONF_ENV := \
	$(HOST_ENV) \
	ac_cv_header_stdbool_h=yes \
	am_cv_pathless_PYTHON=python3

#
# autoconf
#
HOST_P11_KIT_CONF_TOOL	:= autoconf
HOST_P11_KIT_CONF_OPT	:= \
	$(HOST_AUTOCONF_SYSROOT) \
	--disable-nls \
	--disable-rpath \
	--disable-env-override-paths \
	--disable-trust-module \
	--disable-doc \
	--disable-doc-html \
	--disable-doc-pdf \
	--disable-debug \
	--disable-strict \
	--disable-coverage \
	--with-libtasn1 \
	--with-libffi \
	--with-hash-impl=internal \
	--without-systemd \
	--without-bash-completion

# vim: syntax=make
