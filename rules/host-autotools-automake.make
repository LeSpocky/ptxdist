# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
LAZY_PACKAGES-$(PTXCONF_HOST_AUTOTOOLS_AUTOMAKE) += host-autotools-automake

#
# Paths and names
#
HOST_AUTOTOOLS_AUTOMAKE_VERSION	:= 1.17
HOST_AUTOTOOLS_AUTOMAKE_MD5	:= 7ab3a02318fee6f5bd42adfc369abf10
HOST_AUTOTOOLS_AUTOMAKE		:= automake-$(HOST_AUTOTOOLS_AUTOMAKE_VERSION)
HOST_AUTOTOOLS_AUTOMAKE_SUFFIX	:= tar.xz
HOST_AUTOTOOLS_AUTOMAKE_URL	:= $(call ptx/mirror, GNU, automake/$(HOST_AUTOTOOLS_AUTOMAKE).$(HOST_AUTOTOOLS_AUTOMAKE_SUFFIX))
HOST_AUTOTOOLS_AUTOMAKE_SOURCE	:= $(SRCDIR)/$(HOST_AUTOTOOLS_AUTOMAKE).$(HOST_AUTOTOOLS_AUTOMAKE_SUFFIX)
HOST_AUTOTOOLS_AUTOMAKE_DIR	:= $(HOST_BUILDDIR)/$(HOST_AUTOTOOLS_AUTOMAKE)
HOST_AUTOTOOLS_AUTOMAKE_LICENSE	:= GPL-2.0-or-later
HOST_AUTOTOOLS_AUTOMAKE_LICENSE_FILES := \
	file://COPYING;md5=751419260aa954499f7abaabaa882bbe \
	file://README;startline=55;endline=68;md5=135ebef57a6b61b79dbb841f404a4881

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_AUTOTOOLS_AUTOMAKE_CONF_TOOL	:= autoconf

# create man pages during install to avoid parallel building race
HOST_AUTOTOOLS_AUTOMAKE_MAKE_OPT	:= MANS=

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-autotools-automake.install.post:
	@$(call targetinfo)
	@sed -i \
		-e "s;'\(/usr/share/automake-[^']*\)';'$(PTXDIST_SYSROOT_HOST)\1';g" \
		-e "s;'\(/usr/share/aclocal[^']*\)';'$(PTXDIST_SYSROOT_HOST)\1';g" \
		-e "s;'\(/usr/bin/m4\)';'$(PTXDIST_SYSROOT_HOST)\1';g" \
		$(HOST_AUTOTOOLS_AUTOMAKE_PKGDIR)/usr/bin/* \
		$(HOST_AUTOTOOLS_AUTOMAKE_PKGDIR)/usr/share/automake-*/Automake/Config.pm
	@$(call world/install.post, HOST_AUTOTOOLS_AUTOMAKE)
	@$(call touch)

# vim: syntax=make
