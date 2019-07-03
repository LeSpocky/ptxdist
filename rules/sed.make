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
SED_VERSION	:= 4.2.2
SED_MD5		:= 7ffe1c7cdc3233e1e0c4b502df253974
SED		:= sed-$(SED_VERSION)
SED_SUFFIX	:= tar.bz2
SED_URL		:= $(call ptx/mirror, GNU, sed/$(SED).$(SED_SUFFIX))
SED_SOURCE	:= $(SRCDIR)/$(SED).$(SED_SUFFIX)
SED_DIR		:= $(BUILDDIR)/$(SED)
SED_LICENSE	:= GPL-3.0-only AND GNU Free Documentation License
SED_LICENSE_FILES := \
	file://COPYING;md5=f27defe1e96c2e1ecd4e0c9be8967949 \
	file://COPYING.DOC;md5=10b9de612d532fdeeb7fe8fcd1435cc6

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SED_PATH	:= PATH=$(CROSS_PATH)
SED_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
SED_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-acl \
	--disable-nls \
	--disable-rpath \
	--without-selinux

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
