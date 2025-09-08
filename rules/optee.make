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
OPTEE_VERSION	:= 4.7.0
OPTEE_MD5	:= 28e0d1349527223574bc243c926f586f
OPTEE		:= optee-$(OPTEE_VERSION)
OPTEE_SUFFIX	:= tar.gz
OPTEE_URL	:= https://github.com/OP-TEE/optee_os/archive/$(OPTEE_VERSION).$(OPTEE_SUFFIX)
OPTEE_SOURCE	:= $(SRCDIR)/$(OPTEE).$(OPTEE_SUFFIX)
OPTEE_DIR	:= $(BUILDDIR)/$(OPTEE)
OPTEE_LICENSE	:= BSD-2-Clause AND BSD-3-Clause
OPTEE_LICENSE_FILES := \
	file://LICENSE;md5=c1f21c4f72f372ef38a5a4aee55ec173
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

	@install -vd -m755 $(OPTEE_PKGDIR)/usr/lib/optee-os
	@cp -vr $(OPTEE_OUT_DIR)/$(OPTEE_LIB_DIR)/* $(OPTEE_PKGDIR)/usr/lib/optee-os

	@install -vd -m755 $(OPTEE_PKGDIR)/usr/lib/optee_armtz
	@install -v -D -m444 $(OPTEE_OUT_DIR)/$(OPTEE_LIB_DIR)/ta/*.ta \
		$(OPTEE_PKGDIR)/usr/lib/optee_armtz

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

OPTEE_USER_TAS := \
	023f8f1a-292a-432b-8fc4-de8471358067.ta \
	80a4c275-0a47-4905-8285-1486a9771a08.ta \
	f04a0fe7-1f5d-4b9b-abf7-619b85b4ce8c.ta \
	fd02c9da-306c-48c7-a49c-bbd827ae86ee.ta

$(STATEDIR)/optee.targetinstall:
	@$(call targetinfo)

ifdef PTXCONF_OPTEE_INSTALL_USER_TAS
	@$(call install_init, optee)
	@$(call install_fixup, optee,PRIORITY,optional)
	@$(call install_fixup, optee,SECTION,base)
	@$(call install_fixup, optee,AUTHOR,"Rouven Czerwinski <rouven@czerwinskis.de>")
	@$(call install_fixup, optee,DESCRIPTION,missing)

	@$(foreach ta, $(OPTEE_USER_TAS), \
		$(call install_copy, optee, 0, 0, 0444, -, \
			/usr/lib/optee_armtz/$(ta))$(ptx/nl))

	@$(call install_finish, optee)
endif

	@$(foreach binary, $(OPTEE_BINARIES), \
		$(call ptx/image-install, OPTEE, \
			$(OPTEE_OUT_DIR)/core/$(binary), \
			$(binary))$(ptx/nl))

	@$(call touch)

# vim: syntax=make
