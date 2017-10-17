# -*-makefile-*-
#
# Copyright (C) 2017 by Alexander Dahl <ada@thorsis.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RT_APP) += rt-app

#
# Paths and names
#
RT_APP_VERSION	:= 1.0
RT_APP_MD5	:= 1499a9ef69d656e33f39fa1f22154600
RT_APP		:= rt-app-$(RT_APP_VERSION)
RT_APP_SUFFIX	:= tar.gz
RT_APP_URL	:= https://github.com/scheduler-tools/rt-app/archive/v$(RT_APP_VERSION).$(RT_APP_SUFFIX)
RT_APP_SOURCE	:= $(SRCDIR)/$(RT_APP).$(RT_APP_SUFFIX)
RT_APP_DIR	:= $(BUILDDIR)/$(RT_APP)
RT_APP_LICENSE	:= GPL-2.0+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

RT_APP_CONF_TOOL	:= autoconf
RT_APP_CONF_OPT		:= $(CROSS_AUTOCONF_USR) \
	--with-deadline

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rt-app.targetinstall:
	@$(call targetinfo)

	@$(call install_init, rt-app)
	@$(call install_fixup, rt-app,PRIORITY,optional)
	@$(call install_fixup, rt-app,SECTION,base)
	@$(call install_fixup, rt-app,AUTHOR,"Alexander Dahl <ada@thorsis.com>")
	@$(call install_fixup, rt-app,DESCRIPTION,missing)

	@$(call install_copy, rt-app, 0, 0, 0755, -, /usr/bin/rt-app)

	@$(call install_finish, rt-app)

	@$(call touch)

# vim: ft=make ts=8 sw=8
