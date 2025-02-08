# -*-makefile-*-
#
# Copyright (C) 2009 by Wolfram Sang
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PV) += pv

#
# Paths and names
#
PV_VERSION		:= 1.9.31
PV_MD5			:= 9ea909b3dade3f3fba407a03c01a9bcf
PV			:= pv-$(PV_VERSION)
PV_SUFFIX		:= tar.gz
PV_URL			:= https://www.ivarch.com/programs/sources/$(PV).$(PV_SUFFIX)
PV_SOURCE		:= $(SRCDIR)/$(PV).$(PV_SUFFIX)
PV_DIR			:= $(BUILDDIR)/$(PV)
PV_LICENSE		:= GPL-3.0-or-later
PV_LICENSE_FILES	:= \
	file://docs/COPYING;md5=1ebbd3e34237af26da5dc08a4e440464 \
	file://README.md;startline=54;endline=70;md5=eb1be9d96c222fb839ee3fc200867c64

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PV_MAKE_OPT	:= $(CROSS_ENV_LD)

#
# autoconf
#
PV_CONF_TOOL	:= autoconf
PV_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls \
	--disable-splice \
	--disable-ipc \
	--$(call ptx/endis, PTXCONF_GLOBAL_LARGE_FILE)-largefile \
	--enable-debugging \
	--without-ncurses

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pv.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pv)
	@$(call install_fixup, pv,PRIORITY,optional)
	@$(call install_fixup, pv,SECTION,base)
	@$(call install_fixup, pv,AUTHOR,"Wolfram Sang <w.sang@pengutronix.de>")
	@$(call install_fixup, pv,DESCRIPTION,missing)

	@$(call install_copy, pv, 0, 0, 0755, -, /usr/bin/pv)

	@$(call install_finish, pv)

	@$(call touch)

# vim: syntax=make
