# -*-makefile-*-
#
# Copyright (C) 2007 by Ladislav Michl
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ZIP) += zip

#
# Paths and names
# (zip is packaged a bit unusual way, that's why two version variables exist)
#
ZIP_VERSION	:= 3.0
ZIP_MD5		:= 7b74551e63f8ee6aab6fbc86676c0d37
ZIP_AVERSION	:= 30
ZIP_ARCHIVE	:= zip$(ZIP_AVERSION).tar.gz
ZIP		:= zip$(ZIP_AVERSION)
ZIP_URL		:= $(call ptx/mirror, SF, infozip/$(ZIP_ARCHIVE))
ZIP_SOURCE	:= $(SRCDIR)/$(ZIP_ARCHIVE)
ZIP_DIR		:= $(BUILDDIR)/$(ZIP)
ZIP_LICENSE	:= Info-ZIP
ZIP_LICENSE_FILES	:= file://LICENSE;md5=04d43c5d70b496c032308106e26ae17d

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ZIP_PATH	:= PATH=$(CROSS_PATH)
ZIP_MAKE_OPT	:= \
	$(CROSS_ENV_CC) \
	$(CROSS_ENV_CPP) \
	$(CROSS_ENV_AS) \
	IZ_BZIP2=missing \
	-f unix/Makefile generic

ZIP_INSTALL_OPT	:= \
	prefix=$(ZIP_PKGDIR)/usr \
	-f unix/Makefile install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/zip.targetinstall:
	@$(call targetinfo)

	@$(call install_init, zip)
	@$(call install_fixup, zip,PRIORITY,optional)
	@$(call install_fixup, zip,SECTION,base)
	@$(call install_fixup, zip,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, zip,DESCRIPTION,missing)

ifdef PTXCONF_ZIP_ZIP
	@$(call install_copy, zip, 0, 0, 0755, -, /usr/bin/zip)
endif
ifdef PTXCONF_ZIP_ZIPCLOAK
	@$(call install_copy, zip, 0, 0, 0755, -, /usr/bin/zipcloak)
endif
ifdef PTXCONF_ZIP_ZIPNOTE
	@$(call install_copy, zip, 0, 0, 0755, -, /usr/bin/zipnote)
endif
ifdef PTXCONF_ZIP_ZIPSPLIT
	@$(call install_copy, zip, 0, 0, 0755, -, /usr/bin/zipsplit)
endif

	@$(call install_finish, zip)

	@$(call touch)

# vim: syntax=make
