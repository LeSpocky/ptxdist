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
PACKAGES-$(PTXCONF_LIBBSD) += libbsd

#
# Paths and names
#
LIBBSD_VERSION	:= 0.11.7
LIBBSD_MD5	:= 2c5e63b5bb7771bbe4f572c7788e0bb8
LIBBSD		:= libbsd-$(LIBBSD_VERSION)
LIBBSD_SUFFIX	:= tar.xz
LIBBSD_URL	:= http://libbsd.freedesktop.org/releases/$(LIBBSD).$(LIBBSD_SUFFIX)
LIBBSD_SOURCE	:= $(SRCDIR)/$(LIBBSD).$(LIBBSD_SUFFIX)
LIBBSD_DIR	:= $(BUILDDIR)/$(LIBBSD)
LIBBSD_LICENSE	:= BSD-4-Clause AND BSD-3-Clause AND BSD-2-Clause-NetBSD AND ISC AND MIT AND Beerware AND public_domain
LIBBSD_LICENSE_FILES := \
	file://COPYING;md5=75e85c5a558f86d10fbd5abc567ea5e6

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBBSD_CONF_TOOL := autoconf
LIBBSD_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-shared \
	--disable-static \
	--with-gnu-ld

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libbsd.install:
	@$(call targetinfo)
	@$(call world/install, LIBBSD)
#	# make sure libbsd.so is a linker script before removing the absolute path
	@grep -q '^GROUP(/usr/lib/libbsd.so' $(LIBBSD_PKGDIR)/usr/lib/libbsd.so || \
		ptxd_bailout "$(LIBBSD_PKGDIR)/usr/lib/libbsd.so is not a linker script"
	@sed -i 's;/usr/lib/;;' $(LIBBSD_PKGDIR)/usr/lib/libbsd.so
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libbsd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libbsd)
	@$(call install_fixup, libbsd,PRIORITY,optional)
	@$(call install_fixup, libbsd,SECTION,base)
	@$(call install_fixup, libbsd,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, libbsd,DESCRIPTION,missing)

	@$(call install_lib, libbsd, 0, 0, 0644, libbsd)

	@$(call install_finish, libbsd)

	@$(call touch)

# vim: syntax=make
