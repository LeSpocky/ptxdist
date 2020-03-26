# -*-makefile-*-
#
# Copyright (C) 2020 by Alexander Dahl <ada@thorsis.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SPAWN_FCGI) += spawn-fcgi

#
# Paths and names
#
SPAWN_FCGI_VERSION	:= 1.6.4
SPAWN_FCGI_MD5		:= a67c098a50cd625fd12adf61b5dd4c32
SPAWN_FCGI		:= spawn-fcgi-$(SPAWN_FCGI_VERSION)
SPAWN_FCGI_SUFFIX	:= tar.xz
SPAWN_FCGI_URL		:= https://download.lighttpd.net/spawn-fcgi/releases-1.6.x/$(SPAWN_FCGI).$(SPAWN_FCGI_SUFFIX)
SPAWN_FCGI_SOURCE	:= $(SRCDIR)/$(SPAWN_FCGI).$(SPAWN_FCGI_SUFFIX)
SPAWN_FCGI_DIR		:= $(BUILDDIR)/$(SPAWN_FCGI)
SPAWN_FCGI_LICENSE	:= BSD-3-Clause
SPAWN_FCGI_LICENSE_FILES := file://COPYING;md5=e4dac5c6ab169aa212feb5028853a579

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SPAWN_FCGI_CONF_TOOL	:= autoconf
SPAWN_FCGI_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_IPV6_OPTION) \
	--enable-extra-warnings

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/spawn-fcgi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, spawn-fcgi)
	@$(call install_fixup, spawn-fcgi,PRIORITY,optional)
	@$(call install_fixup, spawn-fcgi,SECTION,base)
	@$(call install_fixup, spawn-fcgi,AUTHOR,"Alexander Dahl <ada@thorsis.com>")
	@$(call install_fixup, spawn-fcgi,DESCRIPTION,missing)

	@$(call install_copy, spawn-fcgi, 0, 0, 0755, -, /usr/bin/spawn-fcgi)

	@$(call install_finish, spawn-fcgi)

	@$(call touch)

# vim: ft=make noet tw=72 ts=8 sw=8
