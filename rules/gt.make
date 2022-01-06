# -*-makefile-*-
#
# Copyright (C) 2021 by Michael Grzeschik <m.grzeschik@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GT) += gt

#
# Paths and names
#
# No tags: use a fake descriptive commit-ish to include the date
GT_VERSION	:= 2021-09-30-g7247547a
GT_MD5		:= ac390e90cc866ca95cf4821fbf25812b
GT		:= gt-$(GT_VERSION)
GT_SUFFIX	:= tar.gz
GT_URL		:= https://github.com/linux-usb-gadgets/gt/archive/$(GT_VERSION).$(GT_SUFFIX)
GT_SOURCE	:= $(SRCDIR)/$(GT).$(GT_SUFFIX)
GT_DIR		:= $(BUILDDIR)/$(GT)
GT_SUBDIR	:= source
GT_LICENSE	:= Apache-2.0
GT_LICENSE_FILES	:= \
	file://source/main.c;startline=2;endline=14;md5=239ab3ef885c745f3896a83f17482d6d \
	file://LICENSE;md5=785f417ec07d653f268e6eb621218d5d

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GT_CONF_TOOL	:= cmake
GT_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DENABLE_MANUAL_PAGE:BOOL=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gt.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gt)
	@$(call install_fixup, gt, PRIORITY, optional)
	@$(call install_fixup, gt, SECTION, base)
	@$(call install_fixup, gt, AUTHOR, "Michael Grzeschik <m.grzeschik@pengutronix.de>")
	@$(call install_fixup, gt, DESCRIPTION, missing)

	@$(call install_copy, gt, 0, 0, 0755, -, /usr/bin/gt)
	@$(call install_alternative, gt, 0, 0, 0644, /etc/gt/gt.conf)

	@$(call install_finish, gt)

	@$(call touch)

# vim: syntax=make
