# -*-makefile-*-
#
# Copyright (C) 2007 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBPTHREAD_STUBS) += libpthread-stubs

#
# Paths and names
#
LIBPTHREAD_STUBS_VERSION	:= 0.5
LIBPTHREAD_STUBS_MD5		:= d42052cb343c3e050ff40adc1675e79f
LIBPTHREAD_STUBS		:= libpthread-stubs-$(LIBPTHREAD_STUBS_VERSION)
LIBPTHREAD_STUBS_SUFFIX		:= tar.xz
LIBPTHREAD_STUBS_URL		:= http://xcb.freedesktop.org/dist/$(LIBPTHREAD_STUBS).$(LIBPTHREAD_STUBS_SUFFIX)
LIBPTHREAD_STUBS_SOURCE		:= $(SRCDIR)/$(LIBPTHREAD_STUBS).$(LIBPTHREAD_STUBS_SUFFIX)
LIBPTHREAD_STUBS_DIR		:= $(BUILDDIR)/$(LIBPTHREAD_STUBS)
LIBPTHREAD_STUBS_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBPTHREAD_CONF_TOOL := autoconf
LIBPTHREAD_CONF_OPT := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libpthread-stubs.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make
