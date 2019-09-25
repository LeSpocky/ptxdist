# -*-makefile-*-
#
# Copyright (C) 2019 by Bjoern Esser <bes@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_LIB_XFONT2) += xorg-lib-xfont2

#
# Paths and names
#
XORG_LIB_XFONT2_VERSION	:= 2.0.4
XORG_LIB_XFONT2_MD5	:= 00516bed7ec1453d56974560379fff2f
XORG_LIB_XFONT2		:= libXfont2-$(XORG_LIB_XFONT2_VERSION)
XORG_LIB_XFONT2_SUFFIX	:= tar.bz2
XORG_LIB_XFONT2_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_XFONT2).$(XORG_LIB_XFONT2_SUFFIX))
XORG_LIB_XFONT2_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XFONT2).$(XORG_LIB_XFONT2_SUFFIX)
XORG_LIB_XFONT2_DIR	:= $(BUILDDIR)/$(XORG_LIB_XFONT2)
XORG_LIB_XFONT2_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XFONT2_CONF_ENV	:= \
	$(CROSS_ENV)\
	ac_cv_func_reallocarray=no \
	ac_cv_func_strlcat=no \
	ac_cv_func_strlcpy=no \
	ac_cv_search_strlcat=no

#
# autoconf
#
XORG_LIB_XFONT2_CONF_TOOL	:= autoconf
XORG_LIB_XFONT2_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-devel-docs \
	--disable-strict-compilation \
	--$(call ptx/endis, PTXCONF_XORG_LIB_XFONT2_FREETYPE)-freetype \
	--$(call ptx/endis, PTXCONF_XORG_LIB_XFONT2_BUILTIN_FONTS)-builtins \
	--$(call ptx/endis, PTXCONF_XORG_LIB_XFONT2_PCF_FONTS)-pcfformat \
	--$(call ptx/endis, PTXCONF_XORG_LIB_XFONT2_BDF_FONTS)-bdfformat \
	--$(call ptx/endis, PTXCONF_XORG_LIB_XFONT2_SNF_FONTS)-snfformat \
	--$(call ptx/endis, PTXCONF_XORG_LIB_XFONT2_FONTSERVER)-fc \
	$(XORG_OPTIONS_TRANS) \
	--without-xmlto \
	--without-fop \
	--without-bzip2

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xfont2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xfont2)
	@$(call install_fixup, xorg-lib-xfont2,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xfont2,SECTION,base)
	@$(call install_fixup, xorg-lib-xfont2,AUTHOR,"Bjoern Esser <bes@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xfont2,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-xfont2, 0, 0, 0644, libXfont2)

	@$(call install_finish, xorg-lib-xfont2)

	@$(call touch)

# vim: syntax=make
