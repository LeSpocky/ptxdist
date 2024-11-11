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
LIBLTDL_VERSION	:= 2.5.3
LIBLTDL_MD5	:= 42abe5bed6cc8207f0868968d89d77cf
LIBLTDL		:= libtool-$(LIBLTDL_VERSION)
LIBLTDL_SUFFIX	:= tar.gz
LIBLTDL_URL	:= $(call ptx/mirror, GNU, libtool/$(LIBLTDL).$(LIBLTDL_SUFFIX))
LIBLTDL_SOURCE	:= $(SRCDIR)/$(LIBLTDL).$(LIBLTDL_SUFFIX)
LIBLTDL_DIR	:= $(BUILDDIR)/$(LIBLTDL)
# License for libltdl only
LIBLTDL_LICENSE	:= LGPL-2.0-or-later
LIBLTDL_LICENSE_FILES := \
	file://libltdl/COPYING.LIB;md5=4fbd65380cdd255951079008b364516c

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
