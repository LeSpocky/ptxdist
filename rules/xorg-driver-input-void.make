# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_DRIVER_INPUT_VOID) += xorg-driver-input-void

#
# Paths and names
#
XORG_DRIVER_INPUT_VOID_VERSION	:= 1.4.1
XORG_DRIVER_INPUT_VOID_MD5	:= 5227013b52b3ca85d6b7ec8adea988d4
XORG_DRIVER_INPUT_VOID		:= xf86-input-void-$(XORG_DRIVER_INPUT_VOID_VERSION)
XORG_DRIVER_INPUT_VOID_SUFFIX	:= tar.bz2
XORG_DRIVER_INPUT_VOID_URL	:= $(call ptx/mirror, XORG, individual/driver/$(XORG_DRIVER_INPUT_VOID).$(XORG_DRIVER_INPUT_VOID_SUFFIX))
XORG_DRIVER_INPUT_VOID_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_INPUT_VOID).$(XORG_DRIVER_INPUT_VOID_SUFFIX)
XORG_DRIVER_INPUT_VOID_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_INPUT_VOID)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_DRIVER_INPUT_VOID_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-driver-input-void.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-driver-input-void)
	@$(call install_fixup, xorg-driver-input-void,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-input-void,SECTION,base)
	@$(call install_fixup, xorg-driver-input-void,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-driver-input-void,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-input-void, 0, 0, 0755, -, \
		/usr/lib/xorg/modules/input/void_drv.so)

	@$(call install_finish, xorg-driver-input-void)

	@$(call touch)

# vim: syntax=make
