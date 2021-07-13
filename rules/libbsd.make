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
LIBBSD_VERSION	:= 0.11.3
LIBBSD_MD5	:= 5ce1707688d8bb75d365fadfce962b2c
LIBBSD		:= libbsd-$(LIBBSD_VERSION)
LIBBSD_SUFFIX	:= tar.xz
LIBBSD_URL	:= http://libbsd.freedesktop.org/releases/$(LIBBSD).$(LIBBSD_SUFFIX)
LIBBSD_SOURCE	:= $(SRCDIR)/$(LIBBSD).$(LIBBSD_SUFFIX)
LIBBSD_DIR	:= $(BUILDDIR)/$(LIBBSD)
LIBBSD_LICENSE	:= BSD-4-Clause AND BSD-3-Clause AND BSD-2-Clause-NetBSD AND ISC AND MIT AND Beerware AND public_domain
LIBBSD_LICENSE_FILES := \
	file://COPYING;md5=adf6172075bcc5837e33a8a688eb7e22

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
