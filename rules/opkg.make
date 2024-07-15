# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel
# Copyright (C) 2014 by Juergen Beisert
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPKG) += opkg

#
# Paths and names
#
OPKG_VERSION	:= 0.7.0
OPKG_MD5	:= 6bf0315a3fd5fd046279d0fd98a39016
OPKG		:= opkg-$(OPKG_VERSION)
OPKG_SUFFIX	:= tar.gz
OPKG_URL	:= http://downloads.yoctoproject.org/releases/opkg/$(OPKG).$(OPKG_SUFFIX)
OPKG_SOURCE	:= $(SRCDIR)/$(OPKG).$(OPKG_SUFFIX)
OPKG_DIR	:= $(BUILDDIR)/$(OPKG)
OPKG_LICENSE	:= GPL-2.0-or-later
OPKG_LICENSE_FILES := file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
OPKG_CONF_TOOL	:= autoconf
OPKG_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-libopkg-api \
	--disable-static \
	--disable-xz \
	--disable-bzip2 \
	--disable-lz4 \
	--disable-zstd \
	--$(call ptx/endis, PTXCONF_OPKG_CURL)-curl \
	--$(call ptx/endis, PTXCONF_OPKG_SHA256)-sha256 \
	--$(call ptx/endis, PTXCONF_OPKG_SSL_CURL)-ssl-curl \
	--$(call ptx/endis, PTXCONF_OPKG_GPG)-gpg \
	--without-static-libopkg \
	--without-libsolv

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/opkg.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  opkg)
	@$(call install_fixup, opkg,PACKAGE,opkg)
	@$(call install_fixup, opkg,PRIORITY,optional)
	@$(call install_fixup, opkg,SECTION,base)
	@$(call install_fixup, opkg,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, opkg,DESCRIPTION,missing)

ifdef PTXCONF_OPKG_GPG
	@$(call install_copy, opkg, 0, 0, 0755, -, /usr/bin/opkg-key)
endif
#	@$(call install_copy, opkg, 0, 0, 0755, -, /usr/bin/update-alternatives)
	@$(call install_copy, opkg, 0, 0, 0755, -, /usr/bin/opkg)

	@$(call install_copy, opkg, 0, 0, 0755, -, /usr/share/opkg/intercept/ldconfig)
	@$(call install_copy, opkg, 0, 0, 0755, -, /usr/share/opkg/intercept/depmod)
	@$(call install_copy, opkg, 0, 0, 0755, -, /usr/share/opkg/intercept/update-modules)

	@$(call install_lib,  opkg, 0, 0, 0644, libopkg)

ifdef PTXCONF_OPKG_OPKG_CONF
	@$(call install_alternative, opkg, 0, 0, 0644, /etc/opkg/opkg.conf)
	@$(call install_replace, opkg, /etc/opkg/opkg.conf, @SRC@, \
		$(PTXCONF_OPKG_OPKG_CONF_URL))
	@$(call install_replace, opkg, /etc/opkg/opkg.conf, @ARCH@, \
		$(PTXDIST_IPKG_ARCH_STRING))
endif

	@$(call install_finish, opkg)

	@$(call touch)

# vim: syntax=make
