# -*-makefile-*-
#
# Copyright (C) 2021 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_LIBEVDEV) += python3-libevdev

#
# Paths and names
#
PYTHON3_LIBEVDEV_VERSION	:= 0.9
PYTHON3_LIBEVDEV_MD5		:= 1dde911954ea9107c73fbc579f9a18b2
PYTHON3_LIBEVDEV		:= libevdev-$(PYTHON3_LIBEVDEV_VERSION)
PYTHON3_LIBEVDEV_SUFFIX		:= tar.gz
PYTHON3_LIBEVDEV_URL		:= $(call ptx/mirror-pypi, libevdev, $(PYTHON3_LIBEVDEV).$(PYTHON3_LIBEVDEV_SUFFIX))
PYTHON3_LIBEVDEV_SOURCE		:= $(SRCDIR)/$(PYTHON3_LIBEVDEV).$(PYTHON3_LIBEVDEV_SUFFIX)
PYTHON3_LIBEVDEV_DIR		:= $(BUILDDIR)/$(PYTHON3_LIBEVDEV)
PYTHON3_LIBEVDEV_LICENSE	:= MIT
PYTHON3_LIBEVDEV_LICENSE_FILES	:= file://libevdev/event.py;startline=2;endline=21;md5=9d834a5b77f9f11b1956d343db68b639

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_LIBEVDEV_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-libevdev.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-libevdev)
	@$(call install_fixup, python3-libevdev,PRIORITY,optional)
	@$(call install_fixup, python3-libevdev,SECTION,base)
	@$(call install_fixup, python3-libevdev,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python3-libevdev,DESCRIPTION,missing)

	@$(call install_glob, python3-libevdev, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES)/libevdev,, *.py)

	@$(call install_finish, python3-libevdev)

	@$(call touch)

# vim: syntax=make
