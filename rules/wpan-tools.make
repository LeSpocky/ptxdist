# -*-makefile-*-
#
# Copyright (C) 2014 by Alexander Aring <aar@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WPAN_TOOLS) += wpan-tools

#
# Paths and names
#
WPAN_TOOLS_VERSION	:= 0.7
WPAN_TOOLS_SHA256	:= 8b690ff0e71e08bece5ec541223fda7abd2d5552d97d3d25b4967609b58fef00
WPAN_TOOLS		:= wpan-tools-$(WPAN_TOOLS_VERSION)
WPAN_TOOLS_SUFFIX	:= tar.gz
WPAN_TOOLS_URL		:= http://wpan.cakelab.org/releases/$(WPAN_TOOLS).$(WPAN_TOOLS_SUFFIX)
WPAN_TOOLS_SOURCE	:= $(SRCDIR)/$(WPAN_TOOLS).$(WPAN_TOOLS_SUFFIX)
WPAN_TOOLS_DIR		:= $(BUILDDIR)/$(WPAN_TOOLS)
WPAN_TOOLS_LICENSE	:= unknown

#
# autoconf
#
WPAN_TOOLS_CONF_TOOL	:= autoconf
WPAN_TOOLS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-static \
	--disable-shared

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wpan-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, wpan-tools)
	@$(call install_fixup, wpan-tools,PRIORITY,optional)
	@$(call install_fixup, wpan-tools,SECTION,base)
	@$(call install_fixup, wpan-tools,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, wpan-tools,DESCRIPTION,missing)

	@$(call install_copy, wpan-tools, 0, 0, 0755, -, /usr/bin/iwpan)
	@$(call install_copy, wpan-tools, 0, 0, 0755, -, /usr/bin/wpan-ping)

	@$(call install_finish, wpan-tools)

	@$(call touch)

# vim: syntax=make
