# -*-makefile-*-
#
# Copyright (C) 2026 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_KMSCON) += kmscon

#
# Paths and names
#
KMSCON_VERSION		:= 9.3.0
KMSCON_SHA256		:= 72d968a3b057c8b178381c84cb8584b3b5e75c4133cd9728fa3647690b9b146b
KMSCON			:= kmscon-$(KMSCON_VERSION)
KMSCON_SUFFIX		:= tar.gz
KMSCON_URL		:= https://github.com/kmscon/kmscon/archive/refs/tags/v$(KMSCON_VERSION).$(KMSCON_SUFFIX)
KMSCON_SOURCE		:= $(SRCDIR)/$(KMSCON).$(KMSCON_SUFFIX)
KMSCON_DIR		:= $(BUILDDIR)/$(KMSCON)
KMSCON_LICENSE		:= MIT AND LGPL-2.1-or-later AND BSD-2-Clause
ifdef PTXCONF_KMSCON_UNIFONT
KMSCON_LICENSE		+= AND GPL-2.0-or-later
endif
KMSCON_LICENSE_FILES	:= file://COPYING;md5=6d4602d249f8a3401040238e98367d9e

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
KMSCON_CONF_TOOL	:= meson
KMSCON_CONF_OPT		:=  \
	$(CROSS_MESON_USR) \
	-Dwerror=false \
	-Dextra_debug=false \
	-Dtests=false \
	-Dmulti_seat=$(call ptx/endis, PTXCONF_KMSCON_MULTI_SEAT)d \
	-Delogind=disabled \
	-Dvideo_fbdev=disabled \
	-Dvideo_drm2d=enabled \
	-Dvideo_drm3d=$(call ptx/endis, PTXCONF_KMSCON_DRM3D)d \
	-Drenderer_gltex=$(call ptx/endis, PTXCONF_KMSCON_GLTEX)d \
	-Dfont_unifont=$(call ptx/endis, PTXCONF_KMSCON_UNIFONT)d \
	-Dfont_pango=$(call ptx/endis, PTXCONF_KMSCON_PANGO)d \
	-Dsession_dummy=disabled \
	-Dsession_terminal=enabled

KMSCON_MODS-$(PTXCONF_KMSCON_DRM3D) += drm3d
KMSCON_MODS-$(PTXCONF_KMSCON_GLTEX) += gltex
KMSCON_MODS-$(PTXCONF_KMSCON_PANGO) += pango
KMSCON_MODS-$(PTXCONF_KMSCON_UNIFONT) += unifont

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/kmscon.targetinstall:
	@$(call targetinfo)

	@$(call install_init, kmscon)
	@$(call install_fixup, kmscon,PRIORITY,optional)
	@$(call install_fixup, kmscon,SECTION,base)
	@$(call install_fixup, kmscon,AUTHOR,"Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, kmscon,DESCRIPTION,missing)

	@$(call install_copy, kmscon, 0, 0, 0755, -, /usr/bin/kmscon)
	@$(call install_copy, kmscon, 0, 0, 0755, -, /usr/bin/kmscon-launch-gui)
	@$(foreach mod, $(KMSCON_MODS-y), \
		$(call install_copy, kmscon, 0, 0, 0644, -, \
		/usr/lib/kmscon/mod-$(mod).so)$(ptx/nl))
	@$(call install_copy, kmscon, 0, 0, 0755, -, /usr/libexec/kmscon/kmscon)

	@$(call install_finish, kmscon)

	@$(call touch)

# vim: ft=make
