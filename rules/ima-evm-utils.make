# -*-makefile-*-
#
# Copyright (C) 2013 by Michael Grzeschik <mgr@pengutronix.de>
#               2015, 2020 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2021 Roland Hieber, Pengutronix <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IMA_EVM_UTILS) += ima-evm-utils

#
# Paths and names
#
IMA_EVM_UTILS_VERSION	:= 1.3.2
IMA_EVM_UTILS_MD5	:= 55cc0e2c77a725f722833c3b4a36038c
IMA_EVM_UTILS		:= ima-evm-utils-$(IMA_EVM_UTILS_VERSION)
IMA_EVM_UTILS_SUFFIX	:= tar.gz
IMA_EVM_UTILS_URL	:= $(call ptx/mirror, SF, linux-ima/ima-evm-utils/$(IMA_EVM_UTILS).$(IMA_EVM_UTILS_SUFFIX))
IMA_EVM_UTILS_SOURCE	:= $(SRCDIR)/$(IMA_EVM_UTILS).$(IMA_EVM_UTILS_SUFFIX)
IMA_EVM_UTILS_DIR	:= $(BUILDDIR)/$(IMA_EVM_UTILS)
IMA_EVM_UTILS_LICENSE	:= GPL-2.0-only WITH custom-exception
IMA_EVM_UTILS_LICENSE_FILES	:= \
	file://src/evmctl.c;startline=13;endline=35;md5=1e6e51503ab04045269a92c0bc5d5b55 \
	file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

IMA_EVM_UTILS_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_lib_tss2_esys_Esys_Free=no \
	ac_cv_lib_tss2_rc_Tss2_RC_Decode=no \
	ac_cv_path_XMLCATALOG=

IMA_EVM_UTILS_CONF_TOOL	:= autoconf
IMA_EVM_UTILS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-openssl-conf \
	--disable-debug

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ima-evm-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ima-evm-utils)
	@$(call install_fixup, ima-evm-utils,PRIORITY,optional)
	@$(call install_fixup, ima-evm-utils,SECTION,base)
	@$(call install_fixup, ima-evm-utils,AUTHOR,"Michael Grzeschik <mgr@pengutronix.de>")
	@$(call install_fixup, ima-evm-utils,DESCRIPTION,missing)

	@$(call install_copy, ima-evm-utils, 0, 0, 0755, -, /usr/bin/evmctl)
	@$(call install_lib, ima-evm-utils, 0, 0, 0644, libimaevm)

	@$(call install_finish, ima-evm-utils)

	@$(call touch)

# vim: syntax=make
