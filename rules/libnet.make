# -*-makefile-*-
#
# Copyright (C) 2003 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNET) += libnet

#
# Paths and names
#
LIBNET_VERSION	:= 1.1.6
LIBNET_MD5	:= 710296fe424a49344e5fcc0d09e53317
LIBNET		:= libnet-$(LIBNET_VERSION)
LIBNET_SUFFIX	:= tar.gz
LIBNET_URL	:= $(call ptx/mirror, SF, libnet-dev/$(LIBNET).$(LIBNET_SUFFIX))
LIBNET_SOURCE	:= $(SRCDIR)/$(LIBNET).$(LIBNET_SUFFIX)
LIBNET_DIR	:= $(BUILDDIR)/$(LIBNET)
LIBNET_LICENSE	:= BSD-2-Clause AND BSD-3-Clause AND BSD-4-Clause AND MIT-CMU
LIBNET_LICENSE_FILES := file://doc/COPYING;md5=fb43d5727b2d3d1238545f75ce456ec3

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBNET_CONF_TOOL	:= autoconf
LIBNET_CONF_ENV		:= \
	$(CROSS_ENV) \
	libnet_cv_have_packet_socket=yes

LIBNET_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-samples \
	--with-link-layer=linux

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libnet.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libnet)
	@$(call install_fixup, libnet,PRIORITY,optional)
	@$(call install_fixup, libnet,SECTION,base)
	@$(call install_fixup, libnet,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libnet,DESCRIPTION,missing)

	@$(call install_lib, libnet, 0, 0, 0644, libnet)

	@$(call install_finish, libnet)

	@$(call touch)

# vim: syntax=make
