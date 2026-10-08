# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBEVDEV) += libevdev

#
# Paths and names
#
LIBEVDEV_VERSION	:= 1.14.0
LIBEVDEV_SHA256		:= 5a0966c7110648665983848bad696c7acba614a2160d2865d535397101007332
LIBEVDEV		:= libevdev-$(LIBEVDEV_VERSION)
LIBEVDEV_SUFFIX		:= tar.xz
LIBEVDEV_URL		:= http://www.freedesktop.org/software/libevdev/$(LIBEVDEV).$(LIBEVDEV_SUFFIX)
LIBEVDEV_SOURCE		:= $(SRCDIR)/$(LIBEVDEV).$(LIBEVDEV_SUFFIX)
LIBEVDEV_DIR		:= $(BUILDDIR)/$(LIBEVDEV)
LIBEVDEV_LICENSE	:= MIT
LIBEVDEV_LICENSE_FILES	:= file://COPYING;md5=80c550b3197bcb8da7d7557ebcc3fc46

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBEVDEV_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_path_VALGRIND= \
	ac_cv_path_DOXYGEN=

#
# autoconf
#
LIBEVDEV_CONF_TOOL	:= autoconf
LIBEVDEV_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-gcov \
	--disable-coverity

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libevdev.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libevdev)
	@$(call install_fixup, libevdev,PRIORITY,optional)
	@$(call install_fixup, libevdev,SECTION,base)
	@$(call install_fixup, libevdev,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libevdev,DESCRIPTION,missing)

	@$(call install_lib, libevdev, 0, 0, 0644, libevdev)

	@$(call install_finish, libevdev)

	@$(call touch)

# vim: syntax=make
