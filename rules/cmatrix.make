# -*-makefile-*-
#
# Copyright (C) 2014 by Alexander Aring <aar@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CMATRIX) += cmatrix

#
# Paths and names
#
CMATRIX_VERSION	:= 2.0
CMATRIX_SHA256	:= ad93ba39acd383696ab6a9ebbed1259ecf2d3cf9f49d6b97038c66f80749e99a
CMATRIX		:= cmatrix-$(CMATRIX_VERSION)
CMATRIX_SUFFIX	:= tar.gz
CMATRIX_URL	:= https://github.com/abishekvashok/cmatrix/archive/refs/tags/v$(CMATRIX_VERSION).$(CMATRIX_SUFFIX)
CMATRIX_SOURCE	:= $(SRCDIR)/$(CMATRIX).$(CMATRIX_SUFFIX)
CMATRIX_DIR	:= $(BUILDDIR)/$(CMATRIX)
CMATRIX_LICENSE	:= GPL-3.0-or-later
CMATRIX_LICENSE_FILES := \
	file://COPYING;md5=d32239bcb673463ab874e80d47fae504 \
	file://cmatrix.c;startline=1;endline=22;md5=da55dd8fe2811eeb603e71142face038

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CMATRIX_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_path_CONSOLECHARS= \
	ac_cv_path_SETFONT=/usr/bin/setfont \
	ac_cv_file__usr_lib_kbd_consolefonts=no \
	ac_cv_file__usr_share_consolefonts=yes \
	ac_cv_file__usr_lib_X11_fonts_misc=no \
	ac_cv_file__usr_X11R6_lib_X11_fonts_misc=no

#
# autoconf
#
# Note: --with-fonts must not be passed: configure disables the fonts
# whenever the option is given, regardless of value.
#
CMATRIX_CONF_TOOL := autoconf
CMATRIX_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cmatrix.targetinstall:
	@$(call targetinfo)

	@$(call install_init, cmatrix)
	@$(call install_fixup, cmatrix,PRIORITY,optional)
	@$(call install_fixup, cmatrix,SECTION,base)
	@$(call install_fixup, cmatrix,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, cmatrix,DESCRIPTION,missing)

	@$(call install_copy, cmatrix, 0, 0, 0755, -, /usr/bin/cmatrix)

	@$(call install_copy, cmatrix, 0, 0, 0644, -, /usr/share/consolefonts/matrix.fnt)
	@$(call install_copy, cmatrix, 0, 0, 0644, -, /usr/share/consolefonts/matrix.psf.gz)

	@$(call install_finish, cmatrix)

	@$(call touch)

# vim: syntax=make
