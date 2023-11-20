# -*-makefile-*-
#
# Copyright (C) 2015 by Markus Pargmann <mpa@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NBD) += nbd

#
# Paths and names
#
NBD_VERSION	:= 3.25
NBD_MD5		:= fc885361c00ac4de2c45d651c48bd937
NBD		:= nbd-$(NBD_VERSION)
NBD_SUFFIX	:= tar.xz
NBD_URL		:= https://github.com/NetworkBlockDevice/nbd/releases/download/$(NBD)/$(NBD).$(NBD_SUFFIX)
NBD_SOURCE	:= $(SRCDIR)/$(NBD).$(NBD_SUFFIX)
NBD_DIR		:= $(BUILDDIR)/$(NBD)
NBD_LICENSE	:= GPL-2.0-only
NBD_LICENSE_FILES := \
	file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263

#
# autoconf
#
NBD_CONF_TOOL	:= autoconf
NBD_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_GLOBAL_LARGE_FILE)-lfs \
	--disable-syslog \
	--disable-debug \
	--disable-gznbd \
	--disable-manpages \
	--without-gnutls \
	--with-libnl

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nbd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nbd)
	@$(call install_fixup, nbd,PRIORITY,optional)
	@$(call install_fixup, nbd,SECTION,base)
	@$(call install_fixup, nbd,AUTHOR,"Markus Pargmann <mpa@pengutronix.de>")
	@$(call install_fixup, nbd,DESCRIPTION,missing)

	@$(call install_copy, nbd, 0, 0, 0755, -, /usr/sbin/nbd-client)
	@$(call install_copy, nbd, 0, 0, 0755, -, /usr/bin/nbd-server)

	@$(call install_finish, nbd)

	@$(call touch)

# vim: syntax=make
