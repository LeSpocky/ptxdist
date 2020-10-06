# -*-makefile-*-
#
# Copyright (C) 2009 by Erwin Rol
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBCROCO) += libcroco

#
# Paths and names
#
LIBCROCO_VERSION	:= 0.6.2
LIBCROCO_MD5		:= 1429c597aa4b75fc610ab3a542c99209
LIBCROCO		:= libcroco-$(LIBCROCO_VERSION)
LIBCROCO_SUFFIX		:= tar.bz2
LIBCROCO_URL		:= $(call ptx/mirror, GNOME, libcroco/$(basename $(LIBCROCO_VERSION))/$(LIBCROCO).$(LIBCROCO_SUFFIX))
LIBCROCO_SOURCE		:= $(SRCDIR)/$(LIBCROCO).$(LIBCROCO_SUFFIX)
LIBCROCO_DIR		:= $(BUILDDIR)/$(LIBCROCO)
LIBCROCO_LICENSE	:= LGPL-2.1-only
LIBCROCO_LICENSE_FILES	:= \
	file://src/cr-parser.c;md5=7f381b6ab4b4e203dcf9dc22c3f686e3;startline=7;endline=24 \
	file://COPYING.LIB;md5=55ca817ccb7d5b5b66355690e9abc605

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBCROCO_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-gtk-doc

ifdef PTXCONF_LIBCROCO_CHECKS
LIBCROCO_AUTOCONF += --enable-checks=yes
else
LIBCROCO_AUTOCONF += --enable-checks=no
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libcroco.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libcroco)
	@$(call install_fixup, libcroco,PRIORITY,optional)
	@$(call install_fixup, libcroco,SECTION,base)
	@$(call install_fixup, libcroco,AUTHOR,"Erwin Rol")
	@$(call install_fixup, libcroco,DESCRIPTION,missing)

	@$(call install_lib, libcroco, 0, 0, 0644, libcroco-0.6)

	@$(call install_finish, libcroco)

	@$(call touch)

# vim: syntax=make
