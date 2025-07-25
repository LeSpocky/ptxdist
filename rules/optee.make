# -*-makefile-*-
#
# Copyright (C) 2018 by Rouven Czerwinski <rouven@czerwinskis.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_OPTEE_PLATFORM
PACKAGES-$(PTXCONF_OPTEE) += optee
endif

#
# Paths and names
#
OPTEE_VERSION	:= 4.6.0
OPTEE_MD5	:= aa77c03cf9927e65edd141b6847c88ec
OPTEE		:= optee-$(OPTEE_VERSION)
OPTEE_SUFFIX	:= tar.gz
OPTEE_URL	:= https://github.com/OP-TEE/optee_os/archive/$(OPTEE_VERSION).$(OPTEE_SUFFIX)
OPTEE_SOURCE	:= $(SRCDIR)/$(OPTEE).$(OPTEE_SUFFIX)
OPTEE_DIR	:= $(BUILDDIR)/$(OPTEE)
OPTEE_LICENSE	:= BSD-2-Clause AND BSD-3-Clause
OPTEE_DEVPKG	:= NO

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OPTEE_WRAPPER_BLACKLIST := \
	$(PTXDIST_LOWLEVEL_WRAPPER_BLACKLIST)

OPTEE_PLATFORM		:= $(call remove_quotes,$(PTXCONF_OPTEE_PLATFORM))
OPTEE_PLATFORM_FLAVOUR	:= $(call remove_quotes,$(PTXCONF_OPTEE_PLATFORM_FLAVOUR))
OPTEE_PLATFORM_FLAVOUR	:= $(if $(OPTEE_PLATFORM_FLAVOUR),-$(OPTEE_PLATFORM_FLAVOUR))

OPTEE_CONF_TOOL := NO
OPTEE_MAKE_ENV += \
	PATH=$(CROSS_PATH) \
	CROSS_COMPILE=$(COMPILER_PREFIX) \
	CROSS_COMPILE64=$(COMPILER_PREFIX) \
	$(call ptx/ifdef,PTXCONF_ARCH_ARM64,CFG_ARM64_core=y) \
	PLATFORM=$(OPTEE_PLATFORM)$(OPTEE_PLATFORM_FLAVOUR) \
	$(call remove_quotes,$(PTXCONF_OPTEE_CFG))

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

OPTEE_LIB_DIR := \
	$(call ptx/ifdef,PTXCONF_ARCH_ARM64,export-ta_arm64,export-ta_arm32)

OPTEE_OUT_DIR        := \
	$(OPTEE_DIR)/out/arm-plat-$(PTXCONF_OPTEE_PLATFORM)

$(STATEDIR)/optee.install:
	@$(call targetinfo)

	@$(call install_init, optee)
	@install -vd -m755 $(OPTEE_PKGDIR)/usr/lib/optee-os
	@cp -vr $(OPTEE_OUT_DIR)/$(OPTEE_LIB_DIR)/* $(OPTEE_PKGDIR)/usr/lib/optee-os

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

OPTEE_BINARIES := \
	tee.bin \
	tee-header_v2.bin \
	tee-pager_v2.bin \
	tee-pageable_v2.bin \
	tee.elf

$(STATEDIR)/optee.targetinstall:
	@$(call targetinfo)

	@$(call install_init, optee)
	@$(foreach binary, $(OPTEE_BINARIES), \
		$(call ptx/image-install, OPTEE, \
			$(OPTEE_OUT_DIR)/core/$(binary), \
			$(binary))$(ptx/nl))

	@$(call touch)

# vim: syntax=make
