# -*-makefile-*-
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LCMS) += lcms

#
# Paths and names
#
LCMS_VERSION		:= 2.12
LCMS_MD5		:= 8cb583c8447461896320b43ea9a688e0
LCMS			:= lcms2-$(LCMS_VERSION)
LCMS_SUFFIX		:= tar.gz
LCMS_URL		:= $(call ptx/mirror, SF, lcms/$(LCMS).$(LCMS_SUFFIX))
LCMS_SOURCE		:= $(SRCDIR)/$(LCMS).$(LCMS_SUFFIX)
LCMS_DIR		:= $(BUILDDIR)/$(LCMS)
LCMS_LICENSE		:= MIT
LCMS_LICENSE_FILES	:= file://COPYING;md5=ac638b4bc6b67582a11379cfbaeb93dd

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LCMS_CONF_TOOL	:= autoconf
LCMS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--without-jpeg \
	--without-tiff \
	--without-zlib \
	--with-threads

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lcms.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lcms)
	@$(call install_fixup, lcms,PRIORITY,optional)
	@$(call install_fixup, lcms,SECTION,base)
	@$(call install_fixup, lcms,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, lcms,DESCRIPTION,missing)

	@$(call install_lib, lcms, 0, 0, 0644, liblcms2)

ifdef PTXCONF_LCMS_BIN
	@$(call install_copy, lcms, 0, 0, 0755, -, /usr/bin/transicc)
	@$(call install_copy, lcms, 0, 0, 0755, -, /usr/bin/psicc)
	@$(call install_copy, lcms, 0, 0, 0755, -, /usr/bin/linkicc)
endif
	@$(call install_finish, lcms)

	@$(call touch)

# vim: syntax=make
