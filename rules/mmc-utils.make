# -*-makefile-*-
#
# Copyright (C) 2016 by Matthias Klein <matthias.klein@optimeas.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MMC_UTILS) += mmc-utils

#
# Paths and names
#
# No tags: use a fake descriptive commit-ish to include the date
MMC_UTILS_VERSION	:= 2022-09-27-gdfc3b6ecda84
MMC_UTILS_MD5		:= 791e4c512cb044045ae34d7f4b781ac1
MMC_UTILS		:= mmc-utils-$(MMC_UTILS_VERSION)
MMC_UTILS_SUFFIX	:= tar.gz
MMC_UTILS_URL		:= https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git/snapshot/$(MMC_UTILS).$(MMC_UTILS_SUFFIX)
MMC_UTILS_SOURCE	:= $(SRCDIR)/$(MMC_UTILS).$(MMC_UTILS_SUFFIX)
MMC_UTILS_DIR		:= $(BUILDDIR)/$(MMC_UTILS)
MMC_UTILS_LICENSE	:= GPL-2.0-only AND BSD-3-Clause
MMC_UTILS_LICENSE_FILES := \
	file://README;startline=28;endline=31;md5=73e5e3ce638b21eca6e204e260201d4a \
	file://mmc.c;startline=1;endline=20;md5=fae32792e20f4d27ade1c5a762d16b7d \
	file://3rdparty/hmac_sha/sha2.h;startline=1;endline=36;md5=6ce341e87c5fcac36e417f4a0e283afd

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MMC_UTILS_CONF_TOOL	:= NO
MMC_UTILS_MAKE_ENV	:= $(CROSS_ENV) prefix=/usr

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mmc-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mmc-utils)
	@$(call install_fixup, mmc-utils,PRIORITY,optional)
	@$(call install_fixup, mmc-utils,SECTION,base)
	@$(call install_fixup, mmc-utils,AUTHOR,"Matthias Klein <matthias.klein@optimeas.de>")
	@$(call install_fixup, mmc-utils,DESCRIPTION,missing)

	@$(call install_copy, mmc-utils, 0, 0, 0755, -, /usr/bin/mmc)

	@$(call install_finish, mmc-utils)

	@$(call touch)

# vim: syntax=make
