# -*-makefile-*-
#
# Copyright (C) 2026 by Bruno Thomsen <bruno.thomsen@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CP210X_CFG) += cp210x-cfg

#
# Paths and names
#
CP210X_CFG_VERSION		:= 2017-01-05-g424deb715e629
CP210X_CFG_SHA256		:= 0879ca422f07b84d6a3c201379cb242f27475700be3a684fd0473ddf4941e73a
CP210X_CFG			:= cp210x-cfg-$(CP210X_CFG_VERSION)
CP210X_CFG_SUFFIX		:= tar.gz
CP210X_CFG_URL			:= https://github.com/DiUS/cp210x-cfg/archive/${CP210X_CFG_VERSION}.${CP210X_CFG_SUFFIX}
CP210X_CFG_SOURCE		:= $(SRCDIR)/$(CP210X_CFG).$(CP210X_CFG_SUFFIX)
CP210X_CFG_DIR			:= $(BUILDDIR)/$(CP210X_CFG)
CP210X_CFG_LICENSE		:= BSD-3-Clause
CP210X_CFG_LICENSE_FILES	:= \
	file://src/main.c;startline=1;endline=32;md5=d8a77d4d4b9f12f02c9c8356e2468e91

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CP210X_CFG_CONF_TOOL	:= NO
CP210X_CFG_MAKE_ENV	:= $(CROSS_ENV)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cp210x-cfg.install:
	@$(call targetinfo)
	@$(call world/execute, CP210X_CFG, \
		install -v -m755 -t $(CP210X_CFG_PKGDIR)/usr/bin \
			$(CP210X_CFG_DIR)/cp210x-cfg)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cp210x-cfg.targetinstall:
	@$(call targetinfo)

	@$(call install_init, cp210x-cfg)
	@$(call install_fixup, cp210x-cfg,PRIORITY,optional)
	@$(call install_fixup, cp210x-cfg,SECTION,base)
	@$(call install_fixup, cp210x-cfg,AUTHOR,"Bruno Thomsen <bruno.thomsen@gmail.com>")
	@$(call install_fixup, cp210x-cfg,DESCRIPTION,missing)

	@$(call install_copy, cp210x-cfg, 0, 0, 0750, -, /usr/bin/cp210x-cfg)

	@$(call install_finish, cp210x-cfg)

	@$(call touch)

# vim: ft=make
