# -*-makefile-*-
#
# Copyright (C) 2018 by Thomas Haemmerle <thomas.haemmerle@wolfvision.net>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBUSBGX) += libusbgx

#
# Paths and names
#
LIBUSBGX_VERSION	:= 0.2.0
LIBUSBGX_MD5		:= a8ea2234c6355ac8ad2ca86c453297bd
LIBUSBGX		:= libusbgx-$(LIBUSBGX_VERSION)
LIBUSBGX_SUFFIX		:= zip
LIBUSBGX_URL		:= \
	https://github.com/libusbgx/libusbgx/archive/libusbgx-v$(LIBUSBGX_VERSION).zip
LIBUSBGX_SOURCE	:= \
	$(SRCDIR)/$(LIBUSBGX).$(LIBUSBGX_SUFFIX)
LIBUSBGX_DIR		:= $(BUILDDIR)/$(LIBUSBGX)
LIBUSBGX_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBUSBGX_CONF_ENV	:= $(CROSS_ENV)

#
# autoconf
#
LIBUSBGX_CONF_TOOL	:= autoconf
LIBUSBGX_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--without-libconfig \
	--enable-examples \
	--disable-gadget-schemes

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libusbgx.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libusbgx)
	@$(call install_fixup, libusbgx, PRIORITY, optional)
	@$(call install_fixup, libusbgx, SECTION, base)
	@$(call install_fixup, libusbgx, AUTHOR, "Thomas Haemmerle <thomas.haemmerle@wolfvision.net>")
	@$(call install_fixup, libusbgx, DESCRIPTION, missing)

	@$(call install_lib, libusbgx, 0, 0, 0644, libusbgx)
	@$(call install_tree, libusbgx, 0, 0, -, /usr/bin)

	@$(call install_finish, libusbgx)

	@$(call touch)

# vim: syntax=make
