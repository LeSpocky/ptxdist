# -*-makefile-*-
#
# Copyright (C) 2006-2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBLTDL) += libltdl

#
# Paths and names
#
LIBLTDL_VERSION	:= 2.6.2
LIBLTDL_SHA256	:= 24adb3aa9ae035c70faba344af57d73215eb89281045af6c7ccd307751f8b0bf
LIBLTDL		:= libtool-$(LIBLTDL_VERSION)
LIBLTDL_SUFFIX	:= tar.gz
LIBLTDL_URL	:= $(call ptx/mirror, GNU, libtool/$(LIBLTDL).$(LIBLTDL_SUFFIX))
LIBLTDL_SOURCE	:= $(SRCDIR)/$(LIBLTDL).$(LIBLTDL_SUFFIX)
LIBLTDL_DIR	:= $(BUILDDIR)/$(LIBLTDL)
# License for libltdl only
LIBLTDL_LICENSE	:= LGPL-2.0-or-later
LIBLTDL_LICENSE_FILES := \
	file://libltdl/COPYING.LIB;md5=4bf661c1e3793e55c8d1051bc5e0ae21

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBLTDL_CONF_ENV := $(CROSS_ENV) HELP2MAN=:

#
# autoconf
#
LIBLTDL_CONF_TOOL := autoconf
LIBLTDL_CONF_OPT := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libltdl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libltdl)
	@$(call install_fixup, libltdl,PRIORITY,optional)
	@$(call install_fixup, libltdl,SECTION,base)
	@$(call install_fixup, libltdl,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libltdl,DESCRIPTION,missing)

	@$(call install_lib, libltdl, 0, 0, 0644, libltdl)

	@$(call install_finish, libltdl)

	@$(call touch)

# vim: syntax=make
