# -*-makefile-*-
#
# Copyright (C) 2018 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBUV) += libuv

#
# Paths and names
#
LIBUV_VERSION	:= 1.47.0
LIBUV_MD5	:= 968592dcd4e0f962720eb669a6352463
LIBUV		:= libuv-v$(LIBUV_VERSION)
LIBUV_SUFFIX	:= tar.gz
LIBUV_URL	:= https://dist.libuv.org/dist/v$(LIBUV_VERSION)/$(LIBUV).$(LIBUV_SUFFIX)
LIBUV_SOURCE	:= $(SRCDIR)/$(LIBUV).$(LIBUV_SUFFIX)
LIBUV_DIR	:= $(BUILDDIR)/$(LIBUV)
LIBUV_LICENSE	:= MIT AND ISC
LIBUV_LICENSE_FILES := \
	file://LICENSE;md5=74b6f2f7818a4e3a80d03556f71b129b \
	file://src/inet.c;startline=2;endline=15;md5=0bb6e8601910c7ad7c437a53b138601b


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBUV_CONF_TOOL	:= autoconf
LIBUV_CONF_OPT	:= \
        $(CROSS_AUTOCONF_USR) \
        $(GLOBAL_LARGE_FILE_OPTION)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libuv.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libuv)
	@$(call install_fixup, libuv,PRIORITY,optional)
	@$(call install_fixup, libuv,SECTION,base)
	@$(call install_fixup, libuv,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libuv,DESCRIPTION,missing)

	@$(call install_lib, libuv, 0, 0, 0644, libuv)

	@$(call install_finish, libuv)

	@$(call touch)

# vim: syntax=make
