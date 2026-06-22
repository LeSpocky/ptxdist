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
LIBNET_VERSION	:= 1.3
LIBNET_SHA256	:= ad1e2dd9b500c58ee462acd839d0a0ea9a2b9248a1287840bc601e774fb6b28f
LIBNET		:= libnet-$(LIBNET_VERSION)
LIBNET_SUFFIX	:= tar.gz
LIBNET_URL	:= https://github.com/libnet/libnet/releases/download/v$(LIBNET_VERSION)/$(LIBNET).$(LIBNET_SUFFIX)
LIBNET_SOURCE	:= $(SRCDIR)/$(LIBNET).$(LIBNET_SUFFIX)
LIBNET_DIR	:= $(BUILDDIR)/$(LIBNET)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBNET_CONF_TOOL	:= autoconf
LIBNET_CONF_ENV		:= \
	$(CROSS_ENV) \
	libnet_cv_have_packet_socket=yes

LIBNET_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-doxygen-doc \
	--disable-doxygen-dot \
	--disable-doxygen-man \
	--disable-doxygen-rtf \
	--disable-doxygen-xml \
	--disable-doxygen-chm \
	--disable-doxygen-chi \
	--disable-doxygen-html \
	--disable-doxygen-ps \
	--disable-doxygen-pdf \
	--disable-samples \
	--disable-tests \
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
