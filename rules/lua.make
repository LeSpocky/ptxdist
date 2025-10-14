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
LUA_VERSION	:= 5.4.8
LUA_MD5		:= 81cf5265b8634967d8a7480d238168ce
LUA		:= lua-$(LUA_VERSION)
LUA_SUFFIX	:= tar.gz
LUA_URL		:= http://www.lua.org/ftp/$(LUA).$(LUA_SUFFIX)
LUA_SOURCE	:= $(SRCDIR)/$(LUA).$(LUA_SUFFIX)
LUA_DIR		:= $(BUILDDIR)/$(LUA)
LUA_LICENSE	:= MIT
LUA_LICENSE_FILES := file://src/lua.h;startline=499;endline=520;md5=618f134673964dd3d19cc334898f645a

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
