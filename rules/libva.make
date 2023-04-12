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
PACKAGES-$(PTXCONF_LIBVA) += libva

#
# Paths and names
#
LIBVA_VERSION	:= 2.18.0
LIBVA_MD5	:= b597a43395daebf65f23872b67bcd794
LIBVA		:= libva-$(LIBVA_VERSION)
LIBVA_SUFFIX	:= tar.bz2
LIBVA_URL	:= https://github.com/intel/libva/releases/download/$(LIBVA_VERSION)/$(LIBVA).$(LIBVA_SUFFIX)
LIBVA_SOURCE	:= $(SRCDIR)/$(LIBVA).$(LIBVA_SUFFIX)
LIBVA_DIR	:= $(BUILDDIR)/$(LIBVA)
LIBVA_LICENSE	:= MIT
LIBVA_LICENSE_FILES := \
	file://COPYING;md5=2e48940f94acb0af582e5ef03537800f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBVA_ENABLE-y				:= drm
LIBVA_ENABLE-$(PTXCONF_LIBVA_X11)	+= x11
LIBVA_ENABLE-$(PTXCONF_LIBVA_WAYLAND)	+= wayland

LIBVA_CONF_TOOL	:= meson
LIBVA_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Ddisable_drm=false \
	-Ddriverdir='' \
	-Denable_docs=false \
	-Dwith_glx=no \
	-Dwith_wayland=$(call ptx/yesno, PTXCONF_LIBVA_WAYLAND) \
	-Dwith_x11=$(call ptx/yesno, PTXCONF_LIBVA_X11)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libva.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libva)
	@$(call install_fixup, libva,PRIORITY,optional)
	@$(call install_fixup, libva,SECTION,base)
	@$(call install_fixup, libva,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libva,DESCRIPTION,missing)

	@$(call install_lib, libva, 0, 0, 0644, libva)

	@$(foreach api, $(LIBVA_ENABLE-y), \
		$(call install_lib, libva, 0, 0, 0644, libva-$(api))$(ptx/nl))

	@$(call install_finish, libva)

	@$(call touch)

# vim: syntax=make
