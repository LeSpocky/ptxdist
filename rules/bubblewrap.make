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
BUBBLEWRAP_VERSION	:= 0.13.1
BUBBLEWRAP_SHA256	:= 0e85c8702248b8dd64144f594147553650cdd0e4c951690345faace79c217c4d
BUBBLEWRAP		:= bubblewrap-$(BUBBLEWRAP_VERSION)
BUBBLEWRAP_SUFFIX	:= tar.xz
BUBBLEWRAP_URL		:= https://github.com/containers/bubblewrap/releases/download/v$(BUBBLEWRAP_VERSION)/$(BUBBLEWRAP).$(BUBBLEWRAP_SUFFIX)
BUBBLEWRAP_SOURCE	:= $(SRCDIR)/$(BUBBLEWRAP).$(BUBBLEWRAP_SUFFIX)
BUBBLEWRAP_DIR		:= $(BUILDDIR)/$(BUBBLEWRAP)
BUBBLEWRAP_LICENSE	:= LGPL-2.1-or-later
BUBBLEWRAP_LICENSE_FILES := \
	file://COPYING;md5=4fbd65380cdd255951079008b364516c \
	file://chroot_realpath.c;startline=3;endline=18;md5=71ca6c0528821c23695654d8a1032f53

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
	-Ddebug_logging=false \
	-Dman=disabled \
	-Dselinux=disabled \
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
