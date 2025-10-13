# -*-makefile-*-
#
# Copyright (C) 2011 by Juergen Beisert <jbe@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_EVTEST) += evtest

#
# Paths and names
#
EVTEST_VERSION	:= 1.36
EVTEST_MD5	:= ebd8a804185bfcf19ed20b4789f7e9fc
EVTEST		:= evtest-$(EVTEST_VERSION)
EVTEST_SUFFIX	:= tar.bz2
EVTEST_URL	:= https://gitlab.freedesktop.org/libevdev/evtest/-/archive/evtest-$(EVTEST_VERSION)/evtest-$(EVTEST).$(EVTEST_SUFFIX)
EVTEST_SOURCE	:= $(SRCDIR)/$(EVTEST).$(EVTEST_SUFFIX)
EVTEST_DIR	:= $(BUILDDIR)/$(EVTEST)
EVTEST_LICENSE	:= GPL-2.0-or-later
EVTEST_LICENSE_FILES := \
	file://COPYING;md5=751419260aa954499f7abaabaa882bbe \
	file://evtest.c;startline=18;endline=36;md5=f38f0b28798dbf9b0cc59de32ef71a28

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

EVTEST_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_path_XSLTPROC= \
	ac_cv_path_XMLTO= \
	ac_cv_path_ASCIIDOC=

#
# autoconf
#
EVTEST_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/evtest.targetinstall:
	@$(call targetinfo)

	@$(call install_init, evtest)
	@$(call install_fixup, evtest,PRIORITY,optional)
	@$(call install_fixup, evtest,SECTION,base)
	@$(call install_fixup, evtest,AUTHOR,"Juergen Beisert <jbe@pengutronix.de>")
	@$(call install_fixup, evtest,DESCRIPTION,missing)

	@$(call install_copy, evtest, 0, 0, 0755, -, /usr/bin/evtest)

	@$(call install_finish, evtest)

	@$(call touch)

# vim: syntax=make
