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
MOBILE_BROADBAND_PROVIDER_INFO_VERSION	:= 20190618
MOBILE_BROADBAND_PROVIDER_INFO_MD5	:= 1ca66a989e6b3d788f69bd299249b74a
MOBILE_BROADBAND_PROVIDER_INFO		:= mobile-broadband-provider-info-$(MOBILE_BROADBAND_PROVIDER_INFO_VERSION)
MOBILE_BROADBAND_PROVIDER_INFO_SUFFIX	:= tar.bz2
MOBILE_BROADBAND_PROVIDER_INFO_URL	:= https://gitlab.gnome.org/GNOME/mobile-broadband-provider-info/-/archive/$(MOBILE_BROADBAND_PROVIDER_INFO_VERSION)/$(MOBILE_BROADBAND_PROVIDER_INFO).$(MOBILE_BROADBAND_PROVIDER_INFO_SUFFIX)
MOBILE_BROADBAND_PROVIDER_INFO_SOURCE	:= $(SRCDIR)/$(MOBILE_BROADBAND_PROVIDER_INFO).$(MOBILE_BROADBAND_PROVIDER_INFO_SUFFIX)
MOBILE_BROADBAND_PROVIDER_INFO_DIR	:= $(BUILDDIR)/$(MOBILE_BROADBAND_PROVIDER_INFO)
MOBILE_BROADBAND_PROVIDER_INFO_LICENSE	:= public_domain

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
