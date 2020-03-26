# -*-makefile-*-
#
# Copyright (C) 2016-2020 by Denis Osterland <Denis.Osterland@diehl.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_IMX_UUC) += imx-uuc

#
# Paths and names
#
IMX_UUC_VERSION		:= 2019-11-07-gd6afb27e55d73d7ad08cd2dd51c784d8ec9694dc
IMX_UUC_MD5		:= 1a807ab59464385309b92794b43b5caa
IMX_UUC			:= imx-uuc-$(IMX_UUC_VERSION)
IMX_UUC_SUFFIX		:= tar.gz
IMX_UUC_URL		:= https://github.com/NXPmicro/imx-uuc/archive/$(IMX_UUC).$(IMX_UUC_SUFFIX)
IMX_UUC_SOURCE		:= $(SRCDIR)/$(IMX_UUC).$(IMX_UUC_SUFFIX)
IMX_UUC_DIR		:= $(BUILDDIR)/$(IMX_UUC)
IMX_UUC_LICENSE		:= GPL-2.0-or-later
IMX_UUC_LICENSE_FILES	:= \
	file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

IMX_UUC_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

IMX_UUC_MAKE_ENV       := $(CROSS_ENV)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/imx-uuc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, imx-uuc)
	@$(call install_fixup, imx-uuc,PRIORITY,optional)
	@$(call install_fixup, imx-uuc,SECTION,base)
	@$(call install_fixup, imx-uuc,AUTHOR,"Denis Osterland <Denis.Osterland@diehl.com>")
	@$(call install_fixup, imx-uuc,DESCRIPTION,missing)

	@$(call install_copy, imx-uuc, 0, 0, 0755, -, /usr/bin/uuc)
	@$(call install_copy, imx-uuc, 0, 0, 0755, -, /usr/bin/ufb)
	@$(call install_copy, imx-uuc, 0, 0, 0755, -, /usr/bin/sdimage)
	@$(call install_alternative, imx-uuc, 0, 0, 0755, /linuxrc)
	@$(call install_alternative, imx-uuc, 0, 0, 0644, /fat)

	@$(call install_finish, imx-uuc)

	@$(call touch)

# vim: syntax=make
