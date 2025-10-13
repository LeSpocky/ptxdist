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
OPKG_VERSION	:= 0.9.0
OPKG_MD5	:= 3a100d77beaedd4820599d91bc53e302
OPKG		:= opkg-$(OPKG_VERSION)
OPKG_SUFFIX	:= tar.gz
OPKG_URL	:= https://git.yoctoproject.org/opkg/snapshot/$(OPKG).$(OPKG_SUFFIX)
OPKG_SOURCE	:= $(SRCDIR)/$(OPKG).$(OPKG_SUFFIX)
OPKG_DIR	:= $(BUILDDIR)/$(OPKG)
OPKG_LICENSE	:= GPL-2.0-or-later
OPKG_LICENSE_FILES := file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OPKG_CONF_TOOL	:= cmake
OPKG_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DSTATIC_LIBOPKG=OFF \
	-DUSE_ACL=OFF \
	-DUSE_SOLVER_INTERNAL=OFF \
	-DUSE_SOLVER_LIBSOLV=ON \
	-DUSE_XATTR=OFF \
	-DWITH_BZIP2=OFF \
	-DWITH_CURL=$(call ptx/onoff, PTXCONF_OPKG_CURL) \
	-DWITH_GPGME=$(call ptx/onoff, PTXCONF_OPKG_GPG) \
	-DWITH_LIBOPKG_API=OFF \
	-DWITH_LZ4=OFF \
	-DWITH_SHA256=$(call ptx/onoff, PTXCONF_OPKG_SHA256) \
	-DWITH_SSLCURL=$(call ptx/onoff, PTXCONF_OPKG_SSL_CURL) \
	-DWITH_XZ=OFF \
	-DWITH_ZSTD=OFF

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
