# -*-makefile-*-
#
# Copyright (C) 2011 by Juergen Beisert <juergen@kreuzholzen.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_ARM)-$(PTXCONF_ARM_MEMSPEED) += arm-memspeed

#
# Paths and names
#
ARM_MEMSPEED_VERSION	:= 1.0
ARM_MEMSPEED_SHA256	:= 62b5e99b23b4ef125209002293efafede546d18137ab4a2a98984e43df40ed0e
ARM_MEMSPEED		:= arm-memspeed-$(ARM_MEMSPEED_VERSION)
ARM_MEMSPEED_SUFFIX	:= tar.bz2
ARM_MEMSPEED_URL	:= http://www.kreuzholzen.de/src/arm-memspeed/$(ARM_MEMSPEED).$(ARM_MEMSPEED_SUFFIX)
ARM_MEMSPEED_SOURCE	:= $(SRCDIR)/$(ARM_MEMSPEED).$(ARM_MEMSPEED_SUFFIX)
ARM_MEMSPEED_DIR	:= $(BUILDDIR)/$(ARM_MEMSPEED)
ARM_MEMSPEED_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------
#
# autoconf
#
ARM_MEMSPEED_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/arm-memspeed.targetinstall:
	@$(call targetinfo)

	@$(call install_init, arm-memspeed)
	@$(call install_fixup, arm-memspeed,PRIORITY,optional)
	@$(call install_fixup, arm-memspeed,SECTION,base)
	@$(call install_fixup, arm-memspeed,AUTHOR,"Juergen Beisert <juergen@kreuzholzen.de>")
	@$(call install_fixup, arm-memspeed,DESCRIPTION, "Memory bandwidth measurement tool")

	@$(call install_copy, arm-memspeed, 0, 0, 0755, -, /usr/bin/memspeed)

	@$(call install_finish, arm-memspeed)

	@$(call touch)

# vim: syntax=make
