# -*-makefile-*-
#
# Copyright (C) 2008 by Juergen Beisert <jbe@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBPCIACCESS) += libpciaccess

#
# Paths and names
#
LIBPCIACCESS_VERSION	:= 0.18.1
LIBPCIACCESS_MD5	:= 57c7efbeceedefde006123a77a7bc825
LIBPCIACCESS		:= libpciaccess-$(LIBPCIACCESS_VERSION)
LIBPCIACCESS_SUFFIX	:= tar.xz
LIBPCIACCESS_URL	:= $(call ptx/mirror, XORG, individual/lib/$(LIBPCIACCESS).$(LIBPCIACCESS_SUFFIX))
LIBPCIACCESS_SOURCE	:= $(SRCDIR)/$(LIBPCIACCESS).$(LIBPCIACCESS_SUFFIX)
LIBPCIACCESS_DIR	:= $(BUILDDIR)/$(LIBPCIACCESS)
LIBPCIACCESS_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
LIBPCIACCESS_CONF_TOOL	:= meson
LIBPCIACCESS_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dlinux-rom-fallback=false \
	-Dpci-ids=/usr/share \
	-Dzlib=disabled

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libpciaccess.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libpciaccess)
	@$(call install_fixup, libpciaccess,PRIORITY,optional)
	@$(call install_fixup, libpciaccess,SECTION,base)
	@$(call install_fixup, libpciaccess,AUTHOR,"Juergen Beisert <j.beisert@pengutronix.de>")
	@$(call install_fixup, libpciaccess,DESCRIPTION,missing)

	@$(call install_lib, libpciaccess, 0, 0, 0644, libpciaccess)

	@$(call install_finish, libpciaccess)

	@$(call touch)

# vim: syntax=make
