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
LIBUV_VERSION	:= 1.34.0
LIBUV_MD5	:= 811ebe06c326e788ac7adf062328f3f1
LIBUV		:= libuv-v$(LIBUV_VERSION)
LIBUV_SUFFIX	:= tar.gz
LIBUV_URL	:= https://dist.libuv.org/dist/v$(LIBUV_VERSION)/$(LIBUV).$(LIBUV_SUFFIX)
LIBUV_SOURCE	:= $(SRCDIR)/$(LIBUV).$(LIBUV_SUFFIX)
LIBUV_DIR	:= $(BUILDDIR)/$(LIBUV)
LIBUV_LICENSE	:= MIT

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
