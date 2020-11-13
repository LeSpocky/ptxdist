# -*-makefile-*-
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#                       Pengutronix <info@pengutronix.de>, Germany
# Copyright (C) 2005 by Ladislav Michl <ladis@linux-mips.org>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LRZSZ) += lrzsz

#
# Paths and names
#
LRZSZ_VERSION	:= 0.12.20
LRZSZ_MD5	:= b5ce6a74abc9b9eb2af94dffdfd372a4
LRZSZ		:= lrzsz-$(LRZSZ_VERSION)
LRZSZ_SUFFIX	:= tar.gz
LRZSZ_URL	:= http://www.ohse.de/uwe/releases/$(LRZSZ).$(LRZSZ_SUFFIX)
LRZSZ_SOURCE	:= $(SRCDIR)/$(LRZSZ).$(LRZSZ_SUFFIX)
LRZSZ_DIR	:= $(BUILDDIR)/$(LRZSZ)


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LRZSZ_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_lib_nsl_gethostbyname=no

#
# autoconf
#
LRZSZ_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls \
	--without-included-gettext \
	--without-catgets

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lrzsz.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lrzsz)
	@$(call install_fixup, lrzsz,PRIORITY,optional)
	@$(call install_fixup, lrzsz,SECTION,base)
	@$(call install_fixup, lrzsz,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, lrzsz,DESCRIPTION,missing)

	@$(call install_copy, lrzsz, 0, 0, 0755, -, /usr/bin/lrz)
	@$(call install_copy, lrzsz, 0, 0, 0755, -, /usr/bin/lsz)

	@$(call install_finish, lrzsz)

	@$(call touch)

# vim: syntax=make
