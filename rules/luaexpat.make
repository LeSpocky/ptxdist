# -*-makefile-*-
#
# Copyright (C) 2013 by Joerg Platte <joerg.platte@googlemail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LUAEXPAT) += luaexpat

#
# Paths and names
#
LUAEXPAT_VERSION	:= 1.3.0
LUAEXPAT_SHA256		:= 9906b1ec81ba141f4cd03e2c8f6c633b15e40b3d341c52a1ef97243e521cdce1 d060397960d87b2c89cf490f330508b7def1a0677bdc120531c571609fc57dc3
LUAEXPAT		:= luaexpat-$(LUAEXPAT_VERSION)
LUAEXPAT_SUFFIX		:= tar.gz
LUAEXPAT_URL		:= https://github.com/lunarmodules/luaexpat/archive/refs/tags/$(LUAEXPAT_VERSION).$(LUAEXPAT_SUFFIX)
LUAEXPAT_SOURCE		:= $(SRCDIR)/$(LUAEXPAT).$(LUAEXPAT_SUFFIX)
LUAEXPAT_DIR		:= $(BUILDDIR)/$(LUAEXPAT)
LUAEXPAT_LICENSE	:= MIT
LUAEXPAT_LICENSE_FILES	:= file://doc/us/license.html;md5=9e100888b4a39ac08c37fb127fefc458

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LUAEXPAT_CONF_TOOL := NO

LUAEXPAT_LUA_VERSION	= $(basename $(LUA_VERSION))
LUAEXPAT_MAKE_ENV	= \
	$(CROSS_ENV) \
	LUA_V=$(LUAEXPAT_LUA_VERSION) \
	LUA_INC= \
	EXPAT_INC=

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/luaexpat.targetinstall:
	@$(call targetinfo)

	@$(call install_init, luaexpat)
	@$(call install_fixup, luaexpat,PRIORITY,optional)
	@$(call install_fixup, luaexpat,SECTION,base)
	@$(call install_fixup, luaexpat,AUTHOR,"Joerg Platte <joerg.platte@googlemail.com>")
	@$(call install_fixup, luaexpat,DESCRIPTION,missing)

	@$(call install_copy, luaexpat, 0, 0, 0644, -, \
		/usr/share/lua/$(LUAEXPAT_LUA_VERSION)/lxp/lom.lua)
	@$(call install_lib, luaexpat, 0, 0, 0644, \
		lua/$(LUAEXPAT_LUA_VERSION)/lxp)
	@$(call install_finish, luaexpat)

	@$(call touch)

# vim: syntax=make
