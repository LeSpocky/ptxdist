# -*-makefile-*-
#
# Copyright (C) 2005 by Sascha Hauer
#               2007-2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TSLIB) += tslib

#
# Paths and names
#
TSLIB_VERSION	:= 1.1
TSLIB_MD5	:= 6ee9bf26c18f06cfc0ceb278bb927589
TSLIB		:= tslib-$(TSLIB_VERSION)
TSLIB_SUFFIX	:= tar.bz2
TSLIB_URL	:= https://github.com/kergoth/tslib/releases/download/1.1/$(TSLIB).$(TSLIB_SUFFIX)
TSLIB_SOURCE	:= $(SRCDIR)/$(TSLIB).$(TSLIB_SUFFIX)
TSLIB_DIR	:= $(BUILDDIR)/$(TSLIB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
TSLIB_CONF_TOOL	:autoconf
TSLIB_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--enable-shared \
	--enable-linear \
	--enable-dejitter \
	--enable-linear-h2200 \
	--enable-variance \
	--enable-pthres \
	--disable-debug


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tslib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, tslib)
	@$(call install_fixup, tslib,PRIORITY,optional)
	@$(call install_fixup, tslib,SECTION,base)
	@$(call install_fixup, tslib,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, tslib,DESCRIPTION,missing)

	@$(call install_alternative, tslib, 0, 0, 0644, \
		/etc/ts.conf)

	@$(call install_lib, tslib, 0, 0, 0644, libts-1.0)

ifdef PTXCONF_TSLIB_TS_CALIBRATE
	@$(call install_copy, tslib, 0, 0, 0755, -, /usr/bin/ts_calibrate)
endif
ifdef PTXCONF_TSLIB_TS_TEST
	@$(call install_copy, tslib, 0, 0, 0755, -, /usr/bin/ts_test)
endif

	@cd $(TSLIB_PKGDIR) && for plugin in `find usr/lib/ts -name "*.so"`; do \
		$(call install_copy, tslib, 0, 0, 0644, -, /$$plugin); \
	done

	@$(call install_finish, tslib)

	@$(call touch)

# vim: syntax=make
