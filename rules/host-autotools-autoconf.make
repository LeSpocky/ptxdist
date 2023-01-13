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
LAZY_PACKAGES-$(PTXCONF_HOST_AUTOTOOLS_AUTOCONF) += host-autotools-autoconf

#
# Paths and names
#
HOST_AUTOTOOLS_AUTOCONF_VERSION	:= 2.71
HOST_AUTOTOOLS_AUTOCONF_MD5	:= 12cfa1687ffa2606337efe1a64416106
HOST_AUTOTOOLS_AUTOCONF		:= autoconf-$(HOST_AUTOTOOLS_AUTOCONF_VERSION)
HOST_AUTOTOOLS_AUTOCONF_SUFFIX	:= tar.xz
HOST_AUTOTOOLS_AUTOCONF_URL	:= $(call ptx/mirror, GNU, autoconf/$(HOST_AUTOTOOLS_AUTOCONF).$(HOST_AUTOTOOLS_AUTOCONF_SUFFIX))
HOST_AUTOTOOLS_AUTOCONF_SOURCE	:= $(SRCDIR)/$(HOST_AUTOTOOLS_AUTOCONF).$(HOST_AUTOTOOLS_AUTOCONF_SUFFIX)
HOST_AUTOTOOLS_AUTOCONF_DIR	:= $(HOST_BUILDDIR)/$(HOST_AUTOTOOLS_AUTOCONF)
HOST_AUTOTOOLS_AUTOCONF_LICENSE	:= GPL-2.0-only AND GPL-3.0-only AND Autoconf-exception-3.0
HOST_AUTOTOOLS_AUTOCONF_LICENSE_FILES := \
	file://COPYING;md5=cc3f3a7596cb558bbd9eb7fbaa3ef16c \
	file://COPYINGv3;md5=1ebbd3e34237af26da5dc08a4e440464 \
	file://COPYING.EXCEPTION;md5=eb129370fe0bb2068cc4e48ff8d31260

$(STATEDIR)/autogen-tools: $(STATEDIR)/host-autotools-autoconf.install.post

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_AUTOTOOLS_AUTOCONF_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-autotools-autoconf.install.post:
	@$(call targetinfo)
	@sed -i \
		-e "s;'\(/usr/share/autoconf\)';'$(PTXDIST_SYSROOT_HOST)\1';g" \
		-e "s;'\(/usr/bin/auto[^']*\)';'$(PTXDIST_SYSROOT_HOST)\1';g" \
		-e "s;'/[^']*/sysroot-host\(/bin/m4\)';'$(PTXDIST_SYSROOT_HOST)\1';g" \
		$(HOST_AUTOTOOLS_AUTOCONF_PKGDIR)/usr/bin/* \
		$(HOST_AUTOTOOLS_AUTOCONF_PKGDIR)/usr/share/autoconf/autom4te.cfg
	@sed -i \
		-e "s;\(/usr/share/autoconf/\);$(PTXDIST_SYSROOT_HOST)\1;g" \
		$(HOST_AUTOTOOLS_AUTOCONF_PKGDIR)/usr/bin/autoconf
	@$(call world/install.post, HOST_AUTOTOOLS_AUTOCONF)
	@$(call touch)

# vim: syntax=make
