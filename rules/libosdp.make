# -*-makefile-*-
#
# Copyright (C) 2023 by Rouven Czerwinski <r.czerwinski@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBOSDP) += libosdp

#
# Paths and names
#
LIBOSDP_VERSION		:= 2.4.0
LIBOSDP_MD5		:= 14484c746fa28a4a0005e893279bd8ec
LIBOSDP			:= libosdp-$(LIBOSDP_VERSION)
LIBOSDP_SUFFIX		:= tar.gz
LIBOSDP_URL		:= https://github.com/goToMain/libosdp/archive/v$(LIBOSDP_VERSION).$(LIBOSDP_SUFFIX)
LIBOSDP_SOURCE		:= $(SRCDIR)/$(LIBOSDP).$(LIBOSDP_SUFFIX)
LIBOSDP_DIR		:= $(BUILDDIR)/$(LIBOSDP)
LIBOSDP_LICENSE		:= Apache-2.0
LIBOSDP_LICENSE_FILES	:= file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327

CUTILS_VERSION		:= 7d5cb004258b8b8a195b63ad15177ff196cefd08
CUTILS_MD5		:= 018ceb214d27bb9ad237274de8307112 
CUTILS_URL		:= https://github.com/goToMain/c-utils/archive/$(CUTILS_VERSION).zip
CUTILS_SOURCE		:= $(SRCDIR)/c-utils-$(CUTILS_VERSION).zip
CUTILS_DIR		:= $(LIBOSDP_DIR)/utils/

LIBOSDP_PARTS		+= \
	CUTILS

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
LIBOSDP_CONF_TOOL	:= cmake
LIBOSDP_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DCONFIG_OSDP_LIB_ONLY=y

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libosdp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libosdp)
	@$(call install_fixup, libosdp, PRIORITY, optional)
	@$(call install_fixup, libosdp, SECTION, base)
	@$(call install_fixup, libosdp, AUTHOR, "Rouven Czerwinski <r.czerwinski@pengutronix.de>")
	@$(call install_fixup, libosdp, DESCRIPTION, missing)

	@$(call install_lib, libosdp, 0, 0, 0755, libosdp)

	@$(call install_copy, libosdp, 0, 0, 0755, -, /usr/bin/osdpctl)

	@$(call install_finish, libosdp)

	@$(call touch)

# vim: syntax=make
