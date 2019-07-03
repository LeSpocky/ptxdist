# -*-makefile-*-
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SYSLINUX) += syslinux

#
# Paths and names
#
SYSLINUX_VERSION	:= 3.86
SYSLINUX_MD5		:= d6fb0231e82190b4932b2aa20274911a
SYSLINUX		:= syslinux-$(SYSLINUX_VERSION)
SYSLINUX_SUFFIX		:= tar.bz2
SYSLINUX_URL		:= $(call ptx/mirror, KERNEL, utils/boot/syslinux/3.xx/$(SYSLINUX).$(SYSLINUX_SUFFIX))
SYSLINUX_SOURCE		:= $(SRCDIR)/$(SYSLINUX).$(SYSLINUX_SUFFIX)
SYSLINUX_DIR		:= $(BUILDDIR)/$(SYSLINUX)
SYSLINUX_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SYSLINUX_MAKE_ENV := \
	$(CROSS_ENV) \
	ICECC=no

SYSLINUX_WRAPPER_BLACKLIST := \
	TARGET_HARDEN_STACKCLASH \
	TARGET_HARDEN_PIE
SYSLINUX_MAKE_OPT := $(CROSS_ENV_PROGS)
SYSLINUX_INSTALL_OPT := install INSTALLROOT=$(SYSLINUX_PKGDIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/syslinux.targetinstall:
	@$(call targetinfo)
# no ipkg
	@$(call touch)

# vim: syntax=make
