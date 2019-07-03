# -*-makefile-*-
#
# Copyright (C) 2010 by Erwin Rol <erwin@erwinrol.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XCB_UTIL) += xcb-util

#
# Paths and names
#
XCB_UTIL_VERSION	:= 0.4.0
XCB_UTIL_MD5		:= 2e97feed81919465a04ccc71e4073313
XCB_UTIL		:= xcb-util-$(XCB_UTIL_VERSION)
XCB_UTIL_SUFFIX		:= tar.bz2
XCB_UTIL_URL		:= http://xcb.freedesktop.org/dist/$(XCB_UTIL).$(XCB_UTIL_SUFFIX)
XCB_UTIL_SOURCE		:= $(SRCDIR)/$(XCB_UTIL).$(XCB_UTIL_SUFFIX)
XCB_UTIL_DIR		:= $(BUILDDIR)/$(XCB_UTIL)
XCB_UTIL_LICENSE	:= X11

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XCB_UTIL_CONF_TOOL	:= autoconf
XCB_UTIL_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-selective-werror \
	--disable-strict-compilation \
	--disable-devel-docs \
	--without-doxygen

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xcb-util.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xcb-util)
	@$(call install_fixup, xcb-util,PRIORITY,optional)
	@$(call install_fixup, xcb-util,SECTION,base)
	@$(call install_fixup, xcb-util,AUTHOR,"Erwin Rol <erwin@erwinrol.com>")
	@$(call install_fixup, xcb-util,DESCRIPTION,missing)

	@$(call install_lib, xcb-util, 0, 0, 0644, libxcb-util)

	@$(call install_finish, xcb-util)

	@$(call touch)


# vim: syntax=make
