# -*-makefile-*-
#
# Copyright (C) 2020 by Daniel Glöckner <dg@emlix.com>
# Copyright (C) 2021 Roland Hieber, Pengutronix <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PPS_TOOLS) += pps-tools

#
# Paths and names
#
PPS_TOOLS_VERSION	:= 1.0.3
PPS_TOOLS_MD5		:= 9b18c55efe020d02c26cd8c759ac258d
PPS_TOOLS		:= pps-tools-$(PPS_TOOLS_VERSION)
PPS_TOOLS_SUFFIX	:= tar.gz
PPS_TOOLS_URL		:= https://github.com/redlab-i/pps-tools/archive/v$(PPS_TOOLS_VERSION).$(PPS_TOOLS_SUFFIX)
PPS_TOOLS_SOURCE	:= $(SRCDIR)/$(PPS_TOOLS).$(PPS_TOOLS_SUFFIX)
PPS_TOOLS_DIR		:= $(BUILDDIR)/$(PPS_TOOLS)
PPS_TOOLS_LICENSE	:= GPL-2.0-or-later
PPS_TOOLS_LICENSE_FILES	:= \
	file://COPYING;md5=751419260aa954499f7abaabaa882bbe \
	file://ppsctl.c;startline=6;endline=14;md5=681a7c053fa782c41658ac9fc7dd1579

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PPS_TOOLS_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

PPS_TOOLS_MAKE_ENV	:= $(CROSS_ENV)

$(STATEDIR)/pps-tools.compile:
	@$(call targetinfo)

	@# Everything depends on .depends, which is made by but also included
	@# in the Makefile, so make sure that "make install" does not rebuild
	@# everything
	@$(call compile, PPS_TOOLS, .depend)
	@$(call world/compile, PPS_TOOLS)

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pps-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pps-tools)
	@$(call install_fixup, pps-tools,PRIORITY,optional)
	@$(call install_fixup, pps-tools,SECTION,base)
	@$(call install_fixup, pps-tools,AUTHOR,"Daniel Glöckner <dg@emlix.com>")
	@$(call install_fixup, pps-tools,DESCRIPTION,missing)

	@$(call install_copy, pps-tools, 0, 0, 0755, -, /usr/bin/ppsfind)
	@$(call install_copy, pps-tools, 0, 0, 0755, -, /usr/bin/ppstest)
	@$(call install_copy, pps-tools, 0, 0, 0755, -, /usr/bin/ppsctl)
	@$(call install_copy, pps-tools, 0, 0, 0755, -, /usr/bin/ppswatch)
	@$(call install_copy, pps-tools, 0, 0, 0755, -, /usr/bin/ppsldisc)

	@$(call install_finish, pps-tools)

	@$(call touch)

# vim: syntax=make
