# -*-makefile-*-
#
# Copyright (C) 2009 by Luotao Fu <l.fu@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifndef PTXCONF_ARCH_ARM64
PACKAGES-$(PTXCONF_IOZONE) += iozone
endif

#
# Paths and names
#
IOZONE_VERSION	:= 327
IOZONE_MD5	:= 3b5f8d7fcb5ba5bba139165c8d53f342
IOZONE		:= iozone3_$(IOZONE_VERSION)
IOZONE_SUFFIX	:= tar
IOZONE_URL	:= http://www.iozone.org/src/current/$(IOZONE).$(IOZONE_SUFFIX)
IOZONE_SOURCE	:= $(SRCDIR)/$(IOZONE).$(IOZONE_SUFFIX)
IOZONE_DIR	:= $(BUILDDIR)/$(IOZONE)
IOZONE_LICENSE	:= Freeware

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
IOZONE_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/iozone.targetinstall:
	@$(call targetinfo)

	@$(call install_init, iozone)
	@$(call install_fixup, iozone,PRIORITY,optional)
	@$(call install_fixup, iozone,SECTION,base)
	@$(call install_fixup, iozone,AUTHOR,"Luotao Fu <l.fu@pengutronix.de>")
	@$(call install_fixup, iozone,DESCRIPTION,missing)

	@$(call install_copy, iozone, 0, 0, 0755, -, /usr/bin/iozone)
	@$(call install_copy, iozone, 0, 0, 0755, -, /usr/bin/fileop)

	@$(call install_finish, iozone)

	@$(call touch)

# vim: syntax=make
