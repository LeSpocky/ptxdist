# -*-makefile-*-
#
# Copyright (C) 2008 by Erwin Rol
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LUA) += lua

#
# Paths and names
#
LUA_VERSION	:= 5.5.1
LUA_SHA256	:= 1c4b4068d67061f2a2231ad2b5422e77acea1487ea9890f6320af614f4373dce
LUA		:= lua-$(LUA_VERSION)
LUA_SUFFIX	:= tar.gz
LUA_URL		:= https://www.lua.org/ftp/$(LUA).$(LUA_SUFFIX)
LUA_SOURCE	:= $(SRCDIR)/$(LUA).$(LUA_SUFFIX)
LUA_DIR		:= $(BUILDDIR)/$(LUA)
LUA_LICENSE	:= MIT
LUA_LICENSE_FILES := file://src/lua.h;startline=523;endline=544;md5=bd40ca17653e280d236bbec3871ff5a7

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LUA_CONF_TOOL      := NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

LUA_MAKE_ENV       := $(CROSS_ENV)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lua.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lua)
	@$(call install_fixup, lua,PRIORITY,optional)
	@$(call install_fixup, lua,SECTION,base)
	@$(call install_fixup, lua,AUTHOR,"Erwin Rol <erwin@erwinrol.com>")
	@$(call install_fixup, lua,DESCRIPTION,missing)

ifdef PTXCONF_LUA_INSTALL_LUA
	@$(call install_copy, lua, 0, 0, 0755, -, /usr/bin/lua)
endif
ifdef PTXCONF_LUA_INSTALL_LUAC
	@$(call install_copy, lua, 0, 0, 0755, -, /usr/bin/luac)
endif
ifdef PTXCONF_LUA_INSTALL_LIBLUA
	@$(call install_lib, lua, 0, 0, 0644, liblua)
endif
	@$(call install_finish, lua)

	@$(call touch)

# vim: syntax=make
