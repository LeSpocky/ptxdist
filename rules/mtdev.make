# -*-makefile-*-
#
# Copyright (C) 2013 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MTDEV) += mtdev

#
# Paths and names
#
MTDEV_VERSION	:= 1.1.7
MTDEV_SHA256	:= a107adad2101fecac54ac7f9f0e0a0dd155d954193da55c2340c97f2ff1d814e
MTDEV		:= mtdev-$(MTDEV_VERSION)
MTDEV_SUFFIX	:= tar.bz2
MTDEV_URL	:= http://bitmath.org/code/mtdev/$(MTDEV).$(MTDEV_SUFFIX)
MTDEV_SOURCE	:= $(SRCDIR)/$(MTDEV).$(MTDEV_SUFFIX)
MTDEV_DIR	:= $(BUILDDIR)/$(MTDEV)
MTDEV_LICENSE	:= MIT
MTDEV_LICENSE_FILES := \
	file://COPYING;md5=ea6bd0268bb0fcd6b27698616ceee5d6

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
MTDEV_CONF_TOOL	:= autoconf
MTDEV_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mtdev.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mtdev)
	@$(call install_fixup, mtdev,PRIORITY,optional)
	@$(call install_fixup, mtdev,SECTION,base)
	@$(call install_fixup, mtdev,AUTHOR,"Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, mtdev,DESCRIPTION,multitouch protocol translation library)

	@$(call install_lib, mtdev, 0, 0, 0644, libmtdev)

	@$(call install_finish, mtdev)

	@$(call touch)

# vim: syntax=make
