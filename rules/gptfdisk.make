# -*-makefile-*-
#
# Copyright (C) 2025 by Jonas Rebmann <jre@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GPTFDISK) += gptfdisk

#
# Paths and names
#
GPTFDISK_VERSION	:= 1.0.10
GPTFDISK_MD5		:= 1970269eb7a97560e238611524b7797a
GPTFDISK		:= gptfdisk-$(GPTFDISK_VERSION)
GPTFDISK_SUFFIX		:= tar.gz
GPTFDISK_URL		:= https://downloads.sourceforge.net/project/gptfdisk/gptfdisk/$(GPTFDISK_VERSION)/$(GPTFDISK).$(GPTFDISK_SUFFIX)
GPTFDISK_SOURCE		:= $(SRCDIR)/$(GPTFDISK).$(GPTFDISK_SUFFIX)
GPTFDISK_DIR		:= $(BUILDDIR)/$(GPTFDISK)
GPTFDISK_LICENSE	:= GPL-2.0-only
GPTFDISK_LICENSE_FILES	:= file://COPYING;md5=59530bdf33659b29e73d4adb9f9f6552

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GPTFDISK_TOOLS-$(PTXCONF_GPTFDISK_GDISK)	+= gdisk
GPTFDISK_TOOLS-$(PTXCONF_GPTFDISK_CGDISK)	+= cgdisk
GPTFDISK_TOOLS-$(PTXCONF_GPTFDISK_SGDISK)	+= sgdisk
GPTFDISK_TOOLS-$(PTXCONF_GPTFDISK_FIXPARTS)	+= fixparts

ifdef PTXCONF_GPTFDISK
ifeq ($(strip $(GPTFDISK_TOOLS-y)),)
$(error At least one PTXCONF_GPTFDISK_* option must be enabled)
endif
endif

GPTFDISK_CONF_TOOL	:= NO

GPTFDISK_MAKE_ENV	:= \
	$(CROSS_ENV) \
	PREFIX=/usr

GPTFDISK_MAKE_OPT	:= \
	TARGET=linux \
	$(GPTFDISK_TOOLS-y)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gptfdisk.install:
	@$(call targetinfo)
	@$(call world/execute, GPTFDISK, \
		install -m755 -v \
		$(addprefix $(GPTFDISK_DIR)/,$(GPTFDISK_TOOLS-y)) \
		$(GPTFDISK_PKGDIR)/usr/bin/)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gptfdisk.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gptfdisk)
	@$(call install_fixup, gptfdisk,PRIORITY,optional)
	@$(call install_fixup, gptfdisk,SECTION,base)
	@$(call install_fixup, gptfdisk,AUTHOR,"Jonas Rebmann <jre@pengutronix.de>")
	@$(call install_fixup, gptfdisk,DESCRIPTION,"GPT disk partitioning tools")

	@$(foreach tool,$(GPTFDISK_TOOLS-y), \
		$(call install_copy, gptfdisk, 0, 0, 0755, -, /usr/bin/$(tool))$(ptx/nl))

	@$(call install_finish, gptfdisk)

	@$(call touch)

# vim: syntax=make
