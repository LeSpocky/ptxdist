# -*-makefile-*-
#
# Copyright (C) 2007 by KOAN sas, by Marco Cavallini <m.cavallini@koansoftware.com>
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SED) += sed

#
# Paths and names
#
SED_VERSION	:= 4.8
SED_MD5		:= 4b9b442ae2527ac316d2915facc41622
SED		:= sed-$(SED_VERSION)
SED_SUFFIX	:= tar.gz
SED_URL		:= $(call ptx/mirror, GNU, sed/$(SED).$(SED_SUFFIX))
SED_SOURCE	:= $(SRCDIR)/$(SED).$(SED_SUFFIX)
SED_DIR		:= $(BUILDDIR)/$(SED)
SED_LICENSE	:= GPL-3.0-only
SED_LICENSE_FILES := \
	file://COPYING;md5=c678957b0c8e964aa6c70fd77641a71e

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
SED_CONF_TOOL	:= autoconf
SED_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-acl \
	--disable-nls \
	--disable-rpath \
	--without-selinux \
	--enable-threads=posix \
	--disable-assert

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sed.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sed)
	@$(call install_fixup, sed,PRIORITY,optional)
	@$(call install_fixup, sed,SECTION,base)
	@$(call install_fixup, sed,AUTHOR,"Marco Cavallini <m.cavallini@koansoftware.com>")
	@$(call install_fixup, sed,DESCRIPTION,missing)

	@$(call install_copy, sed, 0, 0, 0755, -, /usr/bin/sed)

	@$(call install_finish, sed)

	@$(call touch)

# vim: syntax=make
