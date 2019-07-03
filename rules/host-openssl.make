# -*-makefile-*-
#
# Copyright (C) 2011 by George McCollister <george.mccollister@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#

#
HOST_PACKAGES-$(PTXCONF_HOST_OPENSSL) += host-openssl

#
# Paths and names
#
HOST_OPENSSL		= $(OPENSSL)
HOST_OPENSSL_DIR	= $(HOST_BUILDDIR)/$(HOST_OPENSSL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_OPENSSL_CONF_ENV	:= $(HOST_ENV)

#
# autoconf
#
# no ':=' here
HOST_OPENSSL_CONF_OPT = \
	--prefix=/ \
	--libdir=/lib \
	shared

HOST_OPENSSL_INSTALL_OPT := \
	install_sw \
	install_ssldirs

#
# Follow the directions in INSTALL section 1a.
# Configure OpenSSL for your operation system automatically
#
# I see no reason to follow the instructions for manual configuration
# on the host, to do that we need to specify an architecture type.
#
$(STATEDIR)/host-openssl.prepare:
	@$(call targetinfo)
	cd $(HOST_OPENSSL_DIR) && \
		$(HOST_OPENSSL_PATH) $(HOST_OPENSSL_CONF_ENV) \
		./config $(HOST_OPENSSL_CONF_OPT)
	@$(call touch)

# vim: syntax=make
