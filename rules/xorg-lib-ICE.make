# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_LIB_ICE) += xorg-lib-ice

#
# Paths and names
#
XORG_LIB_ICE_VERSION	:= 1.1.2
XORG_LIB_ICE_MD5	:= d1ffde0a07709654b20bada3f9abdd16
XORG_LIB_ICE		:= libICE-$(XORG_LIB_ICE_VERSION)
XORG_LIB_ICE_SUFFIX	:= tar.xz
XORG_LIB_ICE_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_ICE).$(XORG_LIB_ICE_SUFFIX))
XORG_LIB_ICE_SOURCE	:= $(SRCDIR)/$(XORG_LIB_ICE).$(XORG_LIB_ICE_SUFFIX)
XORG_LIB_ICE_DIR	:= $(BUILDDIR)/$(XORG_LIB_ICE)
XORG_LIB_ICE_LICENSE	:= MIT-open-group
XORG_LIB_ICE_LICENSE_FILES := \
	file://COPYING;md5=d162b1b3c6fa812da9d804dcf8584a93

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_LIB_ICE_CONF_TOOL	:= autoconf
XORG_LIB_ICE_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-docs \
	--disable-specs \
	$(GLOBAL_LARGE_FILE_OPTION) \
	$(XORG_OPTIONS_TRANS) \
	--$(call ptx/endis, PTXDIST_Y2038)-year2038 \
	$(XORG_OPTIONS_DOCS)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-ice.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-ice)
	@$(call install_fixup, xorg-lib-ice,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-ice,SECTION,base)
	@$(call install_fixup, xorg-lib-ice,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-ice,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-ice, 0, 0, 0644, libICE)

	@$(call install_finish, xorg-lib-ice)

	@$(call touch)

# vim: syntax=make
