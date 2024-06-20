# -*-makefile-*-
#
# Copyright (C) 2021 by Christian Melki <christian.melki@t2data.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DUMP1090FA) += dump1090fa

#
# Paths and names
#
DUMP1090FA_VERSION		:= 9.0
DUMP1090FA_MD5			:= c02599228bfc28e3f431cb05a229c067
DUMP1090FA			:= dump1090fa-$(DUMP1090FA_VERSION)
DUMP1090FA_SUFFIX		:= tar.gz
DUMP1090FA_URL			:= https://github.com/flightaware/dump1090/archive/refs/tags/v$(DUMP1090FA_VERSION).$(DUMP1090FA_SUFFIX)
DUMP1090FA_SOURCE		:= $(SRCDIR)/$(DUMP1090FA).$(DUMP1090FA_SUFFIX)
DUMP1090FA_DIR			:= $(BUILDDIR)/$(DUMP1090FA)
DUMP1090FA_LICENSE		:= GPL-2.0-only
DUMP1090FA_LICENSE_FILES	:= \
	file://COPYING;md5=751419260aa954499f7abaabaa882bbe

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DUMP1090FA_ARCH := $(call remove_quotes,$(PTXCONF_ARCH_STRING))
ifeq ($(DUMP1090FA_ARCH),arm64)
DUMP1090FA_ARCH := aarch64
endif

DUMP1090FA_CONF_TOOL := NO
DUMP1090FA_MAKE_ENV := \
	$(CROSS_ENV) \
	BLADERF=no \
	LIMESDR=no \
	HACKRF=no \
	RTLSDR=yes \
	ARCH=$(DUMP1090FA_ARCH) \
	CPUFEATURES_ARCH=$(DUMP1090FA_ARCH) \
	CPUFEATURES_UNAME="Linux"

ifdef PTXCONF_ARCH_ARM
ifndef PTXCONF_ARCH_ARM_NEON
# don't try to use NEON if it's not available
DUMP1090FA_MAKE_ENV += CPUFEATURES=no
endif
endif

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dump1090fa.install:
	@$(call targetinfo)
	@install -vD -m 755 $(DUMP1090FA_DIR)/dump1090 $(DUMP1090FA_PKGDIR)/usr/bin/dump1090-fa
	$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dump1090fa.targetinstall:
	@$(call targetinfo)
	@$(call install_init, dump1090fa)
	@$(call install_fixup, dump1090fa,PRIORITY,optional)
	@$(call install_fixup, dump1090fa,SECTION,base)
	@$(call install_fixup, dump1090fa,AUTHOR,"Christian Melki <christian.melki@t2data.com>")
	@$(call install_fixup, dump1090fa,DESCRIPTION,missing)

	@$(call install_copy, dump1090fa, 0, 0, 0755, -, /usr/bin/dump1090-fa)

	@$(call install_finish, dump1090fa)

	@$(call touch)

# vim: syntax=make
