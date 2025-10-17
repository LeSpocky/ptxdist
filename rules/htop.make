# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HTOP) += htop

#
# Paths and names
#
HTOP_VERSION		:= 3.4.1
HTOP_MD5		:= c3e003d9e265774dd808e934d1780774
HTOP			:= htop-$(HTOP_VERSION)
HTOP_SUFFIX		:= tar.gz
HTOP_URL		:= https://github.com/htop-dev/htop/archive/$(HTOP_VERSION).$(HTOP_SUFFIX)
HTOP_SOURCE		:= $(SRCDIR)/$(HTOP).$(HTOP_SUFFIX)
HTOP_DIR		:= $(BUILDDIR)/$(HTOP)
HTOP_LICENSE		:= GPL-2.0-only
HTOP_LICENSE_FILES	:= \
	file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HTOP_CONF_ENV	:= \
	$(CROSS_ENV) \
	HTOP_NCURSES_CONFIG_SCRIPT=ncurses6-config
#
# autoconf
#
HTOP_CONF_TOOL	:= autoconf
HTOP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-static \
	--disable-pcp \
	--disable-unicode \
	--enable-affinity \
	--disable-unwind \
	--disable-hwloc \
	--disable-openvz \
	--disable-vserver \
	--disable-ancient-vserver \
	--disable-capabilities \
	--disable-delayacct \
	--disable-sensors \
	--disable-werror \
	--disable-debug

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/htop.targetinstall:
	@$(call targetinfo)

	@$(call install_init, htop)
	@$(call install_fixup, htop,PRIORITY,optional)
	@$(call install_fixup, htop,SECTION,base)
	@$(call install_fixup, htop,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, htop,DESCRIPTION,missing)

	@$(call install_copy, htop, 0, 0, 0755, -, /usr/bin/htop)

	@$(call install_finish, htop)

	@$(call touch)

# vim: syntax=make
