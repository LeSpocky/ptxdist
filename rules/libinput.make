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
LIBINPUT_VERSION	:= 1.27.0
LIBINPUT_MD5		:= aa0f5da110bf51715b8899548e7e43c2
LIBINPUT		:= libinput-$(LIBINPUT_VERSION)
LIBINPUT_SUFFIX		:= tar.gz
LIBINPUT_URL		:= https://gitlab.freedesktop.org/libinput/libinput/-/archive/$(LIBINPUT_VERSION)/$(LIBINPUT).$(LIBINPUT_SUFFIX)
LIBINPUT_SOURCE		:= $(SRCDIR)/$(LIBINPUT).$(LIBINPUT_SUFFIX)
LIBINPUT_DIR		:= $(BUILDDIR)/$(LIBINPUT)
LIBINPUT_LICENSE	:= MIT
LIBINPUT_LICENSE_FILES	:= \
	file://COPYING;md5=bab4ac7dc1c10bc0fb037dc76c46ef8a

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
	-Dlibwacom=$(call ptx/truefalse, PTXCONF_LIBINPUT_WACOM) \
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
