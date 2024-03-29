# -*-makefile-*-
#
# Copyright (C) 2020 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MOBILE_BROADBAND_PROVIDER_INFO) += mobile-broadband-provider-info

#
# Paths and names
#
MOBILE_BROADBAND_PROVIDER_INFO_VERSION		:= 20220725
MOBILE_BROADBAND_PROVIDER_INFO_MD5		:= f283369e5b1d46a77bded8f7754ad3c3
MOBILE_BROADBAND_PROVIDER_INFO			:= mobile-broadband-provider-info-$(MOBILE_BROADBAND_PROVIDER_INFO_VERSION)
MOBILE_BROADBAND_PROVIDER_INFO_SUFFIX		:= tar.xz
MOBILE_BROADBAND_PROVIDER_INFO_URL		:= $(call ptx/mirror, GNOME, mobile-broadband-provider-info/$(MOBILE_BROADBAND_PROVIDER_INFO_VERSION)/$(MOBILE_BROADBAND_PROVIDER_INFO).$(MOBILE_BROADBAND_PROVIDER_INFO_SUFFIX))
MOBILE_BROADBAND_PROVIDER_INFO_SOURCE		:= $(SRCDIR)/$(MOBILE_BROADBAND_PROVIDER_INFO).$(MOBILE_BROADBAND_PROVIDER_INFO_SUFFIX)
MOBILE_BROADBAND_PROVIDER_INFO_DIR		:= $(BUILDDIR)/$(MOBILE_BROADBAND_PROVIDER_INFO)
MOBILE_BROADBAND_PROVIDER_INFO_LICENSE		:= public_domain
MOBILE_BROADBAND_PROVIDER_INFO_LICENSE_FILES	:= \
	file://COPYING;md5=87964579b2a8ece4bc6744d2dc9a8b04

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
MOBILE_BROADBAND_PROVIDER_INFO_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mobile-broadband-provider-info.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mobile-broadband-provider-info)
	@$(call install_fixup, mobile-broadband-provider-info,PRIORITY,optional)
	@$(call install_fixup, mobile-broadband-provider-info,SECTION,base)
	@$(call install_fixup, mobile-broadband-provider-info,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, mobile-broadband-provider-info,DESCRIPTION,missing)

	@$(call install_copy, mobile-broadband-provider-info, 0, 0, 0644, -, \
		/usr/share/mobile-broadband-provider-info/serviceproviders.xml)

	@$(call install_finish, mobile-broadband-provider-info)

	@$(call touch)

# vim: syntax=make
