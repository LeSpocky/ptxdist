# -*-makefile-*-
#
# Copyright (C) 2021 by Christian Melki
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HWDATA) += hwdata

#
# Paths and names
#
HWDATA_VERSION		:= 0.389
HWDATA_MD5		:= e6d6a05562b9f37039fd947b41da3cc7
HWDATA			:= hwdata-$(HWDATA_VERSION)
HWDATA_SUFFIX		:= tar.gz
HWDATA_URL		:= https://github.com/vcrhonek/hwdata/archive/refs/tags/v$(HWDATA_VERSION).$(HWDATA_SUFFIX)
HWDATA_SOURCE		:= $(SRCDIR)/$(HWDATA).$(HWDATA_SUFFIX)
HWDATA_DIR		:= $(BUILDDIR)/$(HWDATA)
HWDATA_LICENSE		:= GPL-2.0-or-later OR XFree86-1.0
HWDATA_LICENSE_FILES	:= \
	file://LICENSE;md5=1556547711e8246992b999edd9445a57 \
	file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# Package is not really using autoconf, so skip normal cross declaration.
# Only text files are processed. Just prefix setting here.
HWDATA_CONF_TOOL	:= autoconf
HWDATA_CONF_OPT		:= \
	--prefix=/usr

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/hwdata.targetinstall:
	@$(call targetinfo)

	@$(call install_init, hwdata)
	@$(call install_fixup, hwdata,PRIORITY,optional)
	@$(call install_fixup, hwdata,SECTION,base)
	@$(call install_fixup, hwdata,AUTHOR,"Christian Melki <christian.melki@t2data.com>")
	@$(call install_fixup, hwdata,DESCRIPTION,missing)

ifdef PTXCONF_HWDATA_PCI
	@$(call install_copy, hwdata, 0, 0, 0644, \
		$(HWDATA_PKGDIR)/usr/share/hwdata/pci.ids, /usr/share/pci.ids)
endif

ifdef PTXCONF_HWDATA_USB
	@$(call install_copy, hwdata, 0, 0, 0644, \
		$(HWDATA_PKGDIR)/usr/share/hwdata/usb.ids, /usr/share/usb.ids)
endif

ifdef PTXCONF_HWDATA_PNP
	@$(call install_copy, hwdata, 0, 0, 0644, \
		$(HWDATA_PKGDIR)/usr/share/hwdata/pnp.ids, /usr/share/pnp.ids)
endif

ifdef PTXCONF_HWDATA_OUI
	@$(call install_copy, hwdata, 0, 0, 0644, \
		$(HWDATA_PKGDIR)/usr/share/hwdata/oui.txt, /usr/share/oui.txt)
endif

ifdef PTXCONF_HWDATA_IAB
	@$(call install_copy, hwdata, 0, 0, 0644, \
		$(HWDATA_PKGDIR)/usr/share/hwdata/iab.txt, /usr/share/iab.txt)
endif

	@$(call install_finish, hwdata)

	@$(call touch)

# vim: syntax=make
