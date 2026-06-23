# -*-makefile-*-
#
# Copyright (C) 2026 by Sven Püschel <s.pueschel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BUBBLEWRAP) += bubblewrap

#
# Paths and names
#
BUBBLEWRAP_VERSION	:= 0.11.2
BUBBLEWRAP_SHA256	:= 69abc30005d2186baf7737feacd8da35633b93cf5af38838ecff17c5f8e924f6
BUBBLEWRAP		:= bubblewrap-$(BUBBLEWRAP_VERSION)
BUBBLEWRAP_SUFFIX	:= tar.xz
BUBBLEWRAP_URL		:= https://github.com/containers/bubblewrap/releases/download/v$(BUBBLEWRAP_VERSION)/$(BUBBLEWRAP).$(BUBBLEWRAP_SUFFIX)
BUBBLEWRAP_SOURCE	:= $(SRCDIR)/$(BUBBLEWRAP).$(BUBBLEWRAP_SUFFIX)
BUBBLEWRAP_DIR		:= $(BUILDDIR)/$(BUBBLEWRAP)
BUBBLEWRAP_LICENSE	:= LGPL-2.0-or-later
BUBBLEWRAP_LICENSE_FILES := \
	file://COPYING;md5=5f30f0716dfdd0d91eb439ebec522ec2 \
	file://bubblewrap.c;startline=3;endline=16;md5=7632ecc0582c89a5ec336efd45feeade

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
BUBBLEWRAP_CONF_TOOL := meson
BUBBLEWRAP_CONF_OPT := \
	$(CROSS_MESON_USR) \
	-Dbash_completion=disabled \
	-Dman=disabled \
	-Dselinux=disabled \
	-Dsupport_setuid=false \
	-Dtests=false \
	-Dzsh_completion=disabled

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bubblewrap.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bubblewrap)
	@$(call install_fixup, bubblewrap,PRIORITY,optional)
	@$(call install_fixup, bubblewrap,SECTION,base)
	@$(call install_fixup, bubblewrap,AUTHOR,"Sven Püschel <s.pueschel@pengutronix.de>")
	@$(call install_fixup, bubblewrap,DESCRIPTION,Low-level unprivileged sandboxing tool)

	@$(call install_copy, bubblewrap, 0, 0, 0755, -, /usr/bin/bwrap)

	@$(call install_finish, bubblewrap)

	@$(call touch)

# vim: syntax=make
