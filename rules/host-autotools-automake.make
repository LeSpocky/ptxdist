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
HOST_AUTOTOOLS_AUTOMAKE_VERSION	:= 1.20
HOST_AUTOTOOLS_AUTOMAKE_SHA256	:= f6f34dad4cbe395715762b0710f7c511e39bd5cf777e6b95818ccbecf7714248
HOST_AUTOTOOLS_AUTOMAKE		:= automake-$(HOST_AUTOTOOLS_AUTOMAKE_VERSION)
HOST_AUTOTOOLS_AUTOMAKE_SUFFIX	:= tar.xz
HOST_AUTOTOOLS_AUTOMAKE_URL	:= $(call ptx/mirror, GNU, automake/$(HOST_AUTOTOOLS_AUTOMAKE).$(HOST_AUTOTOOLS_AUTOMAKE_SUFFIX))
HOST_AUTOTOOLS_AUTOMAKE_SOURCE	:= $(SRCDIR)/$(HOST_AUTOTOOLS_AUTOMAKE).$(HOST_AUTOTOOLS_AUTOMAKE_SUFFIX)
HOST_AUTOTOOLS_AUTOMAKE_DIR	:= $(HOST_BUILDDIR)/$(HOST_AUTOTOOLS_AUTOMAKE)
HOST_AUTOTOOLS_AUTOMAKE_LICENSE	:= GPL-3.0-or-later
HOST_AUTOTOOLS_AUTOMAKE_LICENSE_FILES := \
	file://COPYING;md5=1ebbd3e34237af26da5dc08a4e440464 \
	file://README;startline=64;endline=78;md5=f8357717975b9ff7a889acf552c38405

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
