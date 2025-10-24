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
NETCAT_VERSION	:= 1.234
NETCAT_MD5	:= c3906f02d5a070afd8ac23ec983fc746
NETCAT		:= netcat-openbsd-$(NETCAT_VERSION)
NETCAT_SUFFIX	:= tar.gz
NETCAT_TARBALL	:= netcat-openbsd_$(NETCAT_VERSION).orig.$(NETCAT_SUFFIX)
NETCAT_URL	:= https://snapshot.debian.org/archive/debian/20251024T083547Z/pool/main/n/netcat-openbsd/$(NETCAT_TARBALL)
NETCAT_SOURCE	:= $(SRCDIR)/$(NETCAT).$(NETCAT_SUFFIX)
NETCAT_DIR	:= $(BUILDDIR)/$(NETCAT)
NETCAT_LICENSE	:= BSD-3-Clause
NETCAT_LICENSE_FILES := \
	file://netcat.c;startline=2;endline=28;md5=ca6c43ecf716610359891a6a6e1df406

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
