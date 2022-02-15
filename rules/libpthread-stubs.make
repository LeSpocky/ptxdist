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
LIBPTHREAD_STUBS_VERSION	:= 0.4
LIBPTHREAD_STUBS_MD5		:= 48c1544854a94db0e51499cc3afd797f
LIBPTHREAD_STUBS		:= libpthread-stubs-$(LIBPTHREAD_STUBS_VERSION)
LIBPTHREAD_STUBS_SUFFIX		:= tar.bz2
LIBPTHREAD_STUBS_URL		:= http://xcb.freedesktop.org/dist/$(LIBPTHREAD_STUBS).$(LIBPTHREAD_STUBS_SUFFIX)
LIBPTHREAD_STUBS_SOURCE		:= $(SRCDIR)/$(LIBPTHREAD_STUBS).$(LIBPTHREAD_STUBS_SUFFIX)
LIBPTHREAD_STUBS_DIR		:= $(BUILDDIR)/$(LIBPTHREAD_STUBS)
LIBPTHREAD_STUBS_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBPTHREAD_STUBS_PATH	:= PATH=$(CROSS_PATH)
LIBPTHREAD_STUBS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBPTHREAD_STUBS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libpthread-stubs.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make
