# -*-makefile-*-
#
# Copyright (C) 2015 by Juergen Borleis <jbe@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNEWT) += libnewt

#
# Paths and names
#
LIBNEWT_VERSION	:= 0.52.21
LIBNEWT_MD5	:= a0a5fd6b53bb167a65e15996b249ebb5
LIBNEWT		:= newt-$(LIBNEWT_VERSION)
LIBNEWT_SUFFIX	:= tar.gz
LIBNEWT_URL	:= https://releases.pagure.org/newt/$(LIBNEWT).$(LIBNEWT_SUFFIX)
LIBNEWT_SOURCE	:= $(SRCDIR)/$(LIBNEWT).$(LIBNEWT_SUFFIX)
LIBNEWT_DIR	:= $(BUILDDIR)/$(LIBNEWT)
LIBNEWT_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBNEWT_CONF_TOOL	:= autoconf
LIBNEWT_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-nls \
	--without-python \
	--without-tcl \
	--without-gpm-support \
	--without-colorsfile

LIBNEWT_MAKE_OPT	:= sharedlib
LIBNEWT_INSTALL_OPT	:= install-sh

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libnewt.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libnewt)
	@$(call install_fixup, libnewt,PRIORITY,optional)
	@$(call install_fixup, libnewt,SECTION,base)
	@$(call install_fixup, libnewt,AUTHOR,"Juergen Borleis <jbe@pengutronix.de>")
	@$(call install_fixup, libnewt,DESCRIPTION,"Not Eriks Windowing Toolkit")

	@$(call install_lib, libnewt, 0, 0, 0644, libnewt)

	@$(call install_finish, libnewt)

	@$(call touch)

# vim: syntax=make
