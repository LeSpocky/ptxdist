# -*-makefile-*-
#
# Copyright (C) 2006, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CAIRO) += cairo

#
# Paths and names
#
CAIRO_VERSION	:= 1.18.0
CAIRO_MD5	:= 3f0685fbadc530606f965b9645bb51d9
CAIRO		:= cairo-$(CAIRO_VERSION)
CAIRO_SUFFIX	:= tar.xz
CAIRO_URL	:= http://cairographics.org/releases/cairo-$(CAIRO_VERSION).$(CAIRO_SUFFIX)
CAIRO_SOURCE	:= $(SRCDIR)/$(CAIRO).$(CAIRO_SUFFIX)
CAIRO_DIR	:= $(BUILDDIR)/$(CAIRO)
CAIRO_LICENSE	:= LGPL-2.1-only OR MPL-1.1
CAIRO_LICENSE_FILES := \
	file://COPYING;md5=e73e999e0c72b5ac9012424fa157ad77 \
	file://COPYING-LGPL-2.1;md5=c9bb0ee6dbe833915b94063d594c4bfc \
	file://COPYING-MPL-1.1;md5=bfe1f75d606912a4111c90743d6c7325

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CAIRO_MESON_CROSS_FILE := $(PTXDIST_GEN_CONFIG_DIR)/cairo-cross-file.meson

#
# meson
#
CAIRO_CONF_TOOL	:= meson
CAIRO_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Ddwrite=disabled \
	-Dfontconfig=$(call ptx/endis, PTXCONF_CAIRO_FREETYPE)d \
	-Dfreetype=$(call ptx/endis, PTXCONF_CAIRO_FREETYPE)d \
	-Dglib=$(call ptx/endis, PTXCONF_CAIRO_GOBJECT)d \
	-Dgtk2-utils=disabled \
	-Dgtk_doc=false \
	-Dpng=$(call ptx/endis, PTXCONF_CAIRO_PNG)d \
	-Dquartz=disabled \
	-Dspectre=disabled \
	-Dsymbol-lookup=disabled \
	-Dtee=disabled \
	-Dtests=disabled \
	-Dxcb=$(call ptx/endis, PTXCONF_CAIRO_XCB)d \
	-Dxlib=$(call ptx/endis, PTXCONF_CAIRO_XLIB)d \
	-Dxlib-xcb=disabled \
	-Dzlib=$(call ptx/endis, PTXCONF_CAIRO_ZLIB)d \
	\
	--cross-file $(CAIRO_MESON_CROSS_FILE)

$(STATEDIR)/cairo.prepare:
	@$(call targetinfo)
	@sed -e "/needs_exe_wrapper/a ipc_rmid_deferred_release = 'true'" \
		< $(PTXDIST_MESON_CROSS_FILE) \
		> $(CAIRO_MESON_CROSS_FILE)
	@$(call world/prepare, CAIRO)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cairo.targetinstall:
	@$(call targetinfo)

	@$(call install_init, cairo)
	@$(call install_fixup, cairo,PRIORITY,optional)
	@$(call install_fixup, cairo,SECTION,base)
	@$(call install_fixup, cairo,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, cairo,DESCRIPTION,missing)

	@$(call install_lib, cairo, 0, 0, 0644, libcairo)
ifdef PTXCONF_CAIRO_GOBJECT
	@$(call install_lib, cairo, 0, 0, 0644, libcairo-gobject)
endif

	@$(call install_finish, cairo)

	@$(call touch)

# vim: syntax=make
