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
PACKAGES-$(PTXCONF_LIBINPUT) += libinput

#
# Paths and names
#
LIBINPUT_VERSION	:= 1.16.4
LIBINPUT_MD5		:= 1fdc670e62a08bcebceabd23af3d639a
LIBINPUT		:= libinput-$(LIBINPUT_VERSION)
LIBINPUT_SUFFIX		:= tar.xz
LIBINPUT_URL		:= http://www.freedesktop.org/software/libinput/$(LIBINPUT).$(LIBINPUT_SUFFIX)
LIBINPUT_SOURCE		:= $(SRCDIR)/$(LIBINPUT).$(LIBINPUT_SUFFIX)
LIBINPUT_DIR		:= $(BUILDDIR)/$(LIBINPUT)
LIBINPUT_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBINPUT_CONF_TOOL	:= meson
LIBINPUT_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dcoverity=false \
	-Ddebug-gui=false \
	-Ddocumentation=false \
	-Depoll-dir= \
	-Dinstall-tests=false \
	-Dlibwacom=false \
	-Dtests=false \
	-Dudev-dir=/usr/lib/udev \
	-Dzshcompletiondir=no

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libinput.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libinput)
	@$(call install_fixup, libinput,PRIORITY,optional)
	@$(call install_fixup, libinput,SECTION,base)
	@$(call install_fixup, libinput,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libinput,DESCRIPTION,missing)

	@$(call install_lib, libinput, 0, 0, 0644, libinput)

ifdef PTXCONF_LIBINPUT_QUIRKS
	@$(call install_tree, libinput, 0, 0, -, /usr/share/libinput)
else
	@$(call install_alternative, libinput, 0, 0, 0644, \
		/usr/share/libinput/99-ptxdist-dummy.quirks)
endif

ifdef PTXCONF_LIBINPUT_TOOL
	@$(call install_copy, libinput, 0, 0, 0755, -, /usr/bin/libinput)
	@$(call install_tree, libinput, 0, 0, -, /usr/libexec/libinput)
endif

	@$(call install_finish, libinput)

	@$(call touch)

# vim: syntax=make
