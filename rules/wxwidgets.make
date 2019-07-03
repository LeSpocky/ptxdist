# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WXWIDGETS) += wxwidgets

#
# Paths and names
#
WXWIDGETS_VERSION	:= 2.8.10
WXWIDGETS_MD5		:= 88b867bc118a183af56efc67014bdf27
WXWIDGETS		:= wxGTK-$(WXWIDGETS_VERSION)
WXWIDGETS_SUFFIX	:= tar.bz2
WXWIDGETS_URL		:= $(call ptx/mirror, SF, wxwindows/$(WXWIDGETS).$(WXWIDGETS_SUFFIX))
WXWIDGETS_SOURCE	:= $(SRCDIR)/$(WXWIDGETS).$(WXWIDGETS_SUFFIX)
WXWIDGETS_DIR		:= $(BUILDDIR)/$(WXWIDGETS)
WXWIDGETS_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
WXWIDGETS_CONF_TOOL	:= autoconf
WXWIDGETS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--with-gtk \
	--without-odbc \
	--without-gnomeprint \
	--without-gnomevfs \
	--without-libtiff \
	--without-libxpm \

ifdef PTXCONF_WXWIDGETS_LIBPNG
WXWIDGETS_CONF_OPT += --with-libpng
else
WXWIDGETS_CONF_OPT += --without-libpng
endif
ifdef PTXCONF_WXWIDGETS_LIBJPEG
WXWIDGETS_CONF_OPT += --with-libjpeg
else
WXWIDGETS_CONF_OPT += --without-libjpeg
endif
ifdef PTXCONF_WXWIDGETS_SDL
WXWIDGETS_CONF_OPT += --with-sdl --with-sdl-prefix=$(SYSROOT)/usr
else
WXWIDGETS_CONF_OPT += --without-sdl
endif
ifdef PTXCONF_WXWIDGETS_OPENGL
WXWIDGETS_CONF_OPT += --with-opengl
else
WXWIDGETS_CONF_OPT += --without-opengl
endif
ifdef PTXCONF_WXWIDGETS_ZLIB
WXWIDGETS_CONF_OPT += --with-zlib
else
WXWIDGETS_CONF_OPT += --without-zlib
endif
ifdef PTXCONF_WXWIDGETS_EXPAT
WXWIDGETS_CONF_OPT += --with-expat
else
WXWIDGETS_CONF_OPT += --without-expat
endif

WXWIDGETS_MAKE_OPT := all samples

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wxwidgets.targetinstall:
	@$(call targetinfo)

	@$(call install_init, wxwidgets)
	@$(call install_fixup, wxwidgets,PRIORITY,optional)
	@$(call install_fixup, wxwidgets,SECTION,base)
	@$(call install_fixup, wxwidgets,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, wxwidgets,DESCRIPTION,missing)

	@$(call install_lib, wxwidgets, 0, 0, 0644, libwx_base-2.8)
	@$(call install_lib, wxwidgets, 0, 0, 0644, libwx_base_net-2.8)
	@$(call install_lib, wxwidgets, 0, 0, 0644, libwx_base_xml-2.8)
	@$(call install_lib, wxwidgets, 0, 0, 0644, libwx_gtk2_adv-2.8)
	@$(call install_lib, wxwidgets, 0, 0, 0644, libwx_gtk2_aui-2.8)
	@$(call install_lib, wxwidgets, 0, 0, 0644, libwx_gtk2_core-2.8)
	@$(call install_lib, wxwidgets, 0, 0, 0644, libwx_gtk2_gl-2.8)
	@$(call install_lib, wxwidgets, 0, 0, 0644, libwx_gtk2_html-2.8)
	@$(call install_lib, wxwidgets, 0, 0, 0644, libwx_gtk2_qa-2.8)
	@$(call install_lib, wxwidgets, 0, 0, 0644, libwx_gtk2_richtext-2.8)
	@$(call install_lib, wxwidgets, 0, 0, 0644, libwx_gtk2_xrc-2.8)

	@$(call install_finish, wxwidgets)

	@$(call touch)

# vim: syntax=make
