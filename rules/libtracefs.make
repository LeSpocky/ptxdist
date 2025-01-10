# -*-makefile-*-
#
# Copyright (C) 2024 by Lucas Stach <l.stach@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBTRACEFS) += libtracefs

#
# Paths and names
#
LIBTRACEFS_VERSION	:= 1.8.1
LIBTRACEFS_MD5		:= d16612bef28cb49e898558fe362496cc
LIBTRACEFS		:= libtracefs-$(LIBTRACEFS_VERSION)
LIBTRACEFS_SUFFIX	:= tar.xz
LIBTRACEFS_URL		:= https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git;tag=libtracefs-$(LIBTRACEFS_VERSION)
LIBTRACEFS_SOURCE	:= $(SRCDIR)/$(LIBTRACEFS).$(LIBTRACEFS_SUFFIX)
LIBTRACEFS_DIR		:= $(BUILDDIR)/$(LIBTRACEFS)
LIBTRACEFS_LICENSE	:= LGPL-2.1-only AND GPL-2.0-only
LIBTRACEFS_LICENSE_FILES := \
	file://LICENSES/LGPL-2.1;md5=b370887980db5dd40659b50909238dbd \
	file://LICENSES/GPL-2.0;md5=e6a75371ba4d16749254a51215d13f97

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
LIBTRACEFS_CONF_TOOL	:= meson
LIBTRACEFS_CONF_OPT	:=  \
	$(CROSS_MESON_USR) \
	-Ddoc=false \
	-Dsamples=false \
	-Dutest=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libtracefs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libtracefs)
	@$(call install_fixup, libtracefs,PRIORITY,optional)
	@$(call install_fixup, libtracefs,SECTION,base)
	@$(call install_fixup, libtracefs,AUTHOR,"Lucas Stach <l.stach@pengutronix.de>")
	@$(call install_fixup, libtracefs,DESCRIPTION,missing)

	@$(call install_lib, libtracefs, 0, 0, 0644, libtracefs)

	@$(call install_finish, libtracefs)

	@$(call touch)

# vim: syntax=make
