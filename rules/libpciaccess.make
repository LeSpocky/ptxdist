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
LIBPCIACCESS_VERSION	:= 0.19
LIBPCIACCESS_SHA256	:= 3c55aa86c82e54a4e3109786f0463530d53b36b6d1cfd14616454f985dd2aa43
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
