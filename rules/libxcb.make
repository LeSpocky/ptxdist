# -*-makefile-*-
#
# Copyright (C) 2007 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBXCB) += libxcb

#
# Paths and names
#
LIBXCB_VERSION		:= 1.17.0
LIBXCB_MD5		:= 96565523e9f9b701fcb35d31f1d4086e
LIBXCB			:= libxcb-$(LIBXCB_VERSION)
LIBXCB_SUFFIX		:= tar.xz
LIBXCB_URL		:= https://xcb.freedesktop.org/dist/$(LIBXCB).$(LIBXCB_SUFFIX)
LIBXCB_SOURCE		:= $(SRCDIR)/$(LIBXCB).$(LIBXCB_SUFFIX)
LIBXCB_DIR		:= $(BUILDDIR)/$(LIBXCB)
LIBXCB_LICENSE		:= X11
LIBXCB_LICENSE_FILES	:= \
	file://COPYING;md5=d763b081cb10c223435b01e00dc0aba7

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBXCB_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_prog_BUILD_DOCS=no

#
# autoconf
#
LIBXCB_CONF_TOOL	:= autoconf
LIBXCB_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-static \
	--disable-selective-werror \
	--disable-strict-compilation \
	--disable-devel-docs \
	--enable-composite \
	--enable-damage \
	--enable-dbe \
	--enable-dpms \
	--enable-dri2 \
	--enable-dri3 \
	--enable-ge \
	--enable-glx \
	--enable-present \
	--enable-randr \
	--enable-record \
	--enable-render \
	--enable-resource \
	--enable-screensaver \
	--enable-shape \
	--enable-shm \
	--enable-sync \
	--enable-xevie \
	--enable-xfixes \
	--enable-xfree86-dri \
	--enable-xinerama \
	--enable-xinput \
	--enable-xkb \
	--enable-xprint \
	--disable-selinux \
	--enable-xtest \
	--enable-xv \
	--enable-xvmc \
	--without-doxygen \
	--without-serverside-support

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libxcb.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libxcb)
	@$(call install_fixup, libxcb,PRIORITY,optional)
	@$(call install_fixup, libxcb,SECTION,base)
	@$(call install_fixup, libxcb,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libxcb,DESCRIPTION,missing)

	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-composite)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-damage)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-dpms)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-dri2)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-dri3)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-glx)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-present)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-randr)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-record)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-render)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-res)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-screensaver)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-shape)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-shm)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-sync)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-xevie)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-xf86dri)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-xfixes)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-xinerama)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-xinput)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-xkb)
#	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-xlib)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-xprint)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-xtest)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-xv)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb-xvmc)
	@$(call install_lib, libxcb, 0, 0, 0644, libxcb)

	@$(call install_finish, libxcb)

	@$(call touch)

# vim: syntax=make
