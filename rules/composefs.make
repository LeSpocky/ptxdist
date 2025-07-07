# -*-makefile-*-
#
# Copyright (C) 2025 by Bruno Thomsen <bruno.thomsen@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_COMPOSEFS) += composefs

#
# Paths and names
#
COMPOSEFS_VERSION	:= 1.0.8
COMPOSEFS_MD5		:= 6f4714015bcfdd9c79b215c49da41b26
COMPOSEFS		:= composefs-$(COMPOSEFS_VERSION)
COMPOSEFS_SUFFIX	:= tar.xz
COMPOSEFS_URL		:= https://github.com/composefs/composefs/releases/download/v$(COMPOSEFS_VERSION)/$(COMPOSEFS).$(COMPOSEFS_SUFFIX)
COMPOSEFS_SOURCE	:= $(SRCDIR)/$(COMPOSEFS).$(COMPOSEFS_SUFFIX)
COMPOSEFS_DIR		:= $(BUILDDIR)/$(COMPOSEFS)
COMPOSEFS_LICENSE	:= (GPL-2.0-or-later OR Apache-2.0) AND LGPL-2.1-or-later
COMPOSEFS_LICENSE_FILES	:= \
	file://COPYING;md5=5cbca48090f7fe0169186a551a5bf78c \
	file://COPYING.GPL-2.0-only;md5=94fa01670a2a8f2d3ab2de15004e0848 \
	file://COPYING.GPL-2.0-or-later;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
	file://COPYING.LGPL-2.1-or-later;md5=4fbd65380cdd255951079008b364516c \
	file://LICENSE.Apache-2.0;md5=3b83ef96387f14655fc854ddc3c6bd57

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
COMPOSEFS_CONF_TOOL	:= meson
COMPOSEFS_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dman=disabled \
	-Dfuse=disabled

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/composefs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, composefs)
	@$(call install_fixup, composefs, PRIORITY, optional)
	@$(call install_fixup, composefs, SECTION, base)
	@$(call install_fixup, composefs, AUTHOR, "Bruno Thomsen <bruno.thomsen@gmail.com>")
	@$(call install_fixup, composefs, DESCRIPTION, missing)

	@$(call install_copy, composefs, 0, 0, 0755, -, /usr/bin/mkcomposefs)
	@$(call install_copy, composefs, 0, 0, 0755, -, /usr/bin/composefs-info)
	@$(call install_copy, composefs, 0, 0, 0755, -, /usr/sbin/mount.composefs)
	@$(call install_lib, composefs, 0, 0, 0644, libcomposefs)

	@$(call install_finish, composefs)

	@$(call touch)

# vim: syntax=make
