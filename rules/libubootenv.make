# -*-makefile-*-
#
# Copyright (C) 2025 by Alexander Dahl <ada@thorsis.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBUBOOTENV) += libubootenv

#
# Paths and names
#
LIBUBOOTENV_VERSION	:= 0.3.6
LIBUBOOTENV_MD5		:= 7d6b623e8da435cf36e7fcd419a03e43
LIBUBOOTENV		:= libubootenv-$(LIBUBOOTENV_VERSION)
LIBUBOOTENV_SUFFIX	:= tar.gz
LIBUBOOTENV_URL		:= https://github.com/sbabic/libubootenv/archive/refs/tags/v$(LIBUBOOTENV_VERSION).$(LIBUBOOTENV_SUFFIX)
LIBUBOOTENV_SOURCE	:= $(SRCDIR)/$(LIBUBOOTENV).$(LIBUBOOTENV_SUFFIX)
LIBUBOOTENV_DIR		:= $(BUILDDIR)/$(LIBUBOOTENV)
LIBUBOOTENV_LICENSE	:= MIT AND CC0-1.0 AND LGPL-2.1-or-later
LIBUBOOTENV_LICENSE_FILES := \
	file://LICENSES/MIT.txt;md5=838c366f69b72c5df05c96dff79b35f2 \
	file://LICENSES/CC0-1.0.txt;md5=0ceb3372c9595f0a8067e55da801e4a1 \
	file://LICENSES/LGPL-2.1-or-later.txt;md5=4fbd65380cdd255951079008b364516c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBUBOOTENV_CONF_TOOL	:= cmake
LIBUBOOTENV_CONF_OPT	:=  \
	$(CROSS_CMAKE_USR) \
	-DBUILD_DOC=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libubootenv.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libubootenv)
	@$(call install_fixup, libubootenv,PRIORITY,optional)
	@$(call install_fixup, libubootenv,SECTION,base)
	@$(call install_fixup, libubootenv,AUTHOR,"Alexander Dahl <ada@thorsis.com>")
	@$(call install_fixup, libubootenv,DESCRIPTION,missing)

	@$(call install_lib, libubootenv, 0, 0, 0644, libubootenv)

	@$(call install_finish, libubootenv)

	@$(call touch)

# vim: ft=make noet tw=72 ts=8 sw=8
