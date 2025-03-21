# -*-makefile-*-
#
# Copyright (C) 2014 by Alexander Aring <aar@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NETCAT) += netcat

#
# Paths and names
#
NETCAT_VERSION	:= 1.228
NETCAT_MD5	:= c30dd048bd65f619f6ed1c9b69255b29
NETCAT		:= netcat-openbsd-$(NETCAT_VERSION)
NETCAT_SUFFIX	:= tar.gz
NETCAT_TARBALL	:= netcat-openbsd_$(NETCAT_VERSION).orig.$(NETCAT_SUFFIX)
NETCAT_URL	:= https://snapshot.debian.org/archive/debian/20250106T033111Z/pool/main/n/netcat-openbsd/$(NETCAT_TARBALL)
NETCAT_SOURCE	:= $(SRCDIR)/$(NETCAT).$(NETCAT_SUFFIX)
NETCAT_DIR	:= $(BUILDDIR)/$(NETCAT)
NETCAT_LICENSE	:= BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NETCAT_CONF_TOOL := NO
NETCAT_MAKE_ENV  := $(CROSS_ENV)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/netcat.install:
	@$(call targetinfo)
	install -D -m 755 "$(NETCAT_DIR)/nc" "$(NETCAT_PKGDIR)/usr/bin/nc"
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/netcat.targetinstall:
	@$(call targetinfo)

	@$(call install_init, netcat)
	@$(call install_fixup, netcat,PRIORITY,optional)
	@$(call install_fixup, netcat,SECTION,base)
	@$(call install_fixup, netcat,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, netcat,DESCRIPTION,missing)

	@$(call install_copy, netcat, 0, 0, 0755, -, /usr/bin/nc)
	@$(call install_link, netcat, nc, /usr/bin/netcat)

	@$(call install_finish, netcat)

	@$(call touch)

# vim: syntax=make
