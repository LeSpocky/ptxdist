# -*-makefile-*-
#
# Copyright (C) 2018 by Rouven Czerwinski <r.czerwinski@pengutronix.de>
#               2019 by Ahmad Fatoum <a.fatoum@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TF_A) += tf-a

#
# Paths and names
#
TF_A_VERSION	:= $(call ptx/config-version, PTXCONF_TF_A)
TF_A_MD5	:= $(call ptx/config-md5, PTXCONF_TF_A)
TF_A		:= tf-a-$(TF_A_VERSION)
TF_A_SUFFIX	:= tar.gz
TF_A_URL	:= $(call remove_quotes, $(PTXCONF_TF_A_URL))/$(TF_A_VERSION).$(TF_A_SUFFIX)
TF_A_SOURCE	:= $(SRCDIR)/$(TF_A).$(TF_A_SUFFIX)
TF_A_DIR	:= $(BUILDDIR)/$(TF_A)
TF_A_BUILD_DIR	:= $(TF_A_DIR)/build
TF_A_BUILD_OOT	:= YES
TF_A_LICENSE	:= BSD-3-Clause AND BSD-2-Clause \
		   AND (GPL-2.0-or-later OR BSD-2-Clause) \
		   AND (NCSA OR MIT) \
		   AND Zlib \
		   AND (GPL-2.0-or-later OR BSD-3-Clause)
TF_A_CVE_PRODUCT:= arm:trusted_firmware-a
TF_A_CVE_VERSION:= $(patsubst v%,%,$(TF_A_VERSION))

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

TF_A_PLATFORMS		:= $(call remove_quotes, $(PTXCONF_TF_A_PLATFORMS))
TF_A_ARTIFACTS		:= $(call remove_quotes, $(PTXCONF_TF_A_ARTIFACTS))

TF_A_WRAPPER_BLACKLIST	:= \
	$(PTXDIST_LOWLEVEL_WRAPPER_BLACKLIST)

TF_A_EXTRA_ARGS		:= $(call remove_quotes,$(PTXCONF_TF_A_EXTRA_ARGS))
TF_A_BINDIR		 = $(TF_A_BUILD_DIR)/$(1)/$(if $(filter DEBUG=1,$(TF_A_EXTRA_ARGS)),debug,release)
TF_A_BINDIR_BOARD	 = $(TF_A_BUILD_DIR)/$(1)/*/$(if $(filter DEBUG=1,$(TF_A_EXTRA_ARGS)),debug,release)
TF_A_MAKE_OPT	:= \
	-C $(TF_A_DIR) \
	CROSS_COMPILE=$(BOOTLOADER_CROSS_COMPILE) \
	HOSTCC=$(HOSTCC) \
	ARCH=$(PTXCONF_TF_A_ARCH_STRING) \
	ARM_ARCH_MAJOR=$(PTXCONF_TF_A_ARM_ARCH_MAJOR) \
	BUILD_STRING=$(PTXCONF_TF_A_VERSION) \
	$(TF_A_EXTRA_ARGS) \
	all

ifdef PTXCONF_TF_A_BL32_TSP
TF_A_MAKE_OPT += ARM_TSP_RAM_LOCATION=$(PTXCONF_TF_A_BL32_TSP_RAM_LOCATION_STRING)
endif
ifdef PTXCONF_TF_A_ARM_ARCH_MINOR
TF_A_MAKE_OPT += ARM_ARCH_MINOR=$(PTXCONF_TF_A_ARM_ARCH_MINOR)
endif
ifdef PTXCONF_TF_A_BL32_SP_MIN
TF_A_MAKE_OPT += AARCH32_SP=sp_min
endif

ifdef PTXCONF_TF_A
ifeq ($(TF_A_ARTIFACTS),)
$(call ptx/error, TF_A_ARTIFACTS is empty. Nothing to install.)
endif
endif

TF_A_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/tf-a.compile:
	@$(call targetinfo)

	@$(foreach plat, $(TF_A_PLATFORMS), \
		$(call compile, TF_A, \
		$(TF_A_MAKE_OPT) PLAT=$(plat))$(ptx/nl))

	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

tf-a/inst_pkgdir = \
	install -v -D -m 644 $(2) $(TF_A_PKGDIR)/usr/lib/firmware/$(3)

tf-a/inst_plat = $(foreach artifact, \
	$(wildcard $(addprefix $(TF_A_BINDIR)/, $(TF_A_ARTIFACTS))) \
	$(wildcard $(addprefix $(TF_A_BINDIR_BOARD)/, $(TF_A_ARTIFACTS))), \
	$(call $(2),TF_A,$(artifact),$(1)-$(notdir $(artifact)))$(ptx/nl))

tf-a/inst_bins = $(foreach plat, $(TF_A_PLATFORMS), $(call tf-a/inst_plat,$(plat),$(1)))

$(STATEDIR)/tf-a.install:
	@$(call targetinfo)
	@$(call tf-a/inst_bins,tf-a/inst_pkgdir)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tf-a.targetinstall:
	@$(call targetinfo)
	@$(call tf-a/inst_bins,ptx/image-install)
	@$(call touch)

# vim: syntax=make
