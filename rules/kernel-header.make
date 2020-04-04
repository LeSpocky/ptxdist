# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_KERNEL_HEADER) += kernel-header

#
# Paths and names
#
KERNEL_HEADER			:= linux-$(KERNEL_HEADER_VERSION)
KERNEL_HEADER_MD5		:= $(call remove_quotes,$(PTXCONF_KERNEL_HEADER_MD5))
ifneq ($(KERNEL_HEADER_NEEDS_GIT_URL),y)
KERNEL_HEADER_SUFFIX		:= tar.xz
KERNEL_HEADER_URL		:= $(call kernel-url, KERNEL_HEADER)
else
KERNEL_HEADER_SUFFIX		:= tar.gz
KERNEL_HEADER_URL		:= https://git.kernel.org/torvalds/t/$(KERNEL_HEADER).$(KERNEL_HEADER_SUFFIX)
endif
KERNEL_HEADER_SOURCE		:= $(SRCDIR)/linux-$(KERNEL_HEADER_VERSION).$(KERNEL_HEADER_SUFFIX)
KERNEL_HEADER_DIR		:= $(BUILDDIR)/kernel-header-$(KERNEL_HEADER_VERSION)
KERNEL_HEADER_BUILD_DIR		:= $(KERNEL_HEADER_DIR)-build
KERNEL_HEADER_PKGDIR		:= $(PKGDIR)/kernel-header-$(KERNEL_HEADER_VERSION)
KERNEL_HEADER_LICENSE		:= GPL-2.0-only
KERNEL_HEADER_BUILD_OOT	:= KEEP

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

KERNEL_HEADER_CONF_ENV		:= $(CROSS_ENV)
KERNEL_HEADER_PATH		:= PATH=$(CROSS_PATH)
KERNEL_HEADER_CONF_TOOL		:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel-header.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

KERNEL_HEADER_INSTALL_OPT	:= \
	-C $(KERNEL_HEADER_DIR) \
	V=$(PTXDIST_VERBOSE) \
	O=$(KERNEL_HEADER_BUILD_DIR) \
	HOSTCC=$(HOSTCC) \
	ARCH=$(GENERIC_KERNEL_ARCH) \
	CROSS_COMPILE=$(PTXCONF_COMPILER_PREFIX) \
	INSTALL_HDR_PATH=$(KERNEL_HEADER_PKGDIR)/kernel-headers \
	headers_install

# vim: syntax=make
