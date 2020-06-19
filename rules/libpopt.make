# -*-makefile-*-
#
# Copyright (C) 2003 by Benedikt Spranger
#               2006, 2009 by Marc Kleine-Budde
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBPOPT) += libpopt

#
# Paths and names
#
LIBPOPT_VERSION	:= 1.16
LIBPOPT_MD5	:= 3743beefa3dd6247a73f8f7a32c14c33
LIBPOPT		:= popt-$(LIBPOPT_VERSION)
LIBPOPT_SUFFIX	:= tar.gz
LIBPOPT_URL	:= \
	http://ftp.rpm.org/mirror/popt/$(LIBPOPT).$(LIBPOPT_SUFFIX) \
	http://distfiles.gentoo.org/distfiles/$(LIBPOPT).$(LIBPOPT_SUFFIX) \
	ftp://anduin.linuxfromscratch.org/BLFS/popt/$(LIBPOPT).$(LIBPOPT_SUFFIX)
LIBPOPT_SOURCE	:= $(SRCDIR)/$(LIBPOPT).$(LIBPOPT_SUFFIX)
LIBPOPT_DIR	:= $(BUILDDIR)/$(LIBPOPT)
LIBPOPT_LICENSE	:= MIT
LIBPOPT_LICENSE_FILES := file://COPYING;md5=cb0613c30af2a8249b8dcc67d3edb06d

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBPOPT_CONF_TOOL	:= autoconf
LIBPOPT_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-build-gcov \
	--$(call ptx/endis, PTXCONF_LIBPOPT_NLS)-nls \
	--disable-rpath

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libpopt.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libpopt)
	@$(call install_fixup, libpopt,PRIORITY,optional)
	@$(call install_fixup, libpopt,SECTION,base)
	@$(call install_fixup, libpopt,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libpopt,DESCRIPTION,missing)

	@$(call install_lib, libpopt, 0, 0, 0644, libpopt)

	@$(call install_finish, libpopt)

	@$(call touch)

# vim: syntax=make
