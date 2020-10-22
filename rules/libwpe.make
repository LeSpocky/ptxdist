# -*-makefile-*-
#
# Copyright (C) 2018 by Steffen Trumtrar <s.trumtrar@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBWPE) += libwpe

#
# Paths and names
#
LIBWPE_VERSION		:= 1.8.0
LIBWPE_LIBRARY_VERSION	:= 1.0
LIBWPE_MD5		:= 328ea59dd8dee9107a49353536d00844
LIBWPE			:= libwpe-$(LIBWPE_VERSION)
LIBWPE_SUFFIX		:= tar.xz
LIBWPE_URL		:= https://wpewebkit.org/releases/$(LIBWPE).$(LIBWPE_SUFFIX)
LIBWPE_SOURCE		:= $(SRCDIR)/$(LIBWPE).$(LIBWPE_SUFFIX)
LIBWPE_DIR		:= $(BUILDDIR)/$(LIBWPE)
LIBWPE_LICENSE		:= BSD-2-Clause
LIBWPE_LICENSE_FILES	:= file://COPYING;md5=371a616eb4903c6cb79e9893a5f615cc

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
LIBWPE_CONF_TOOL	:= cmake
LIBWPE_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-G Ninja \
	-DBUILD_DOCS=OFF \
	-DWPE_BACKEND= \

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libwpe.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libwpe)
	@$(call install_fixup, libwpe,PRIORITY,optional)
	@$(call install_fixup, libwpe,SECTION,base)
	@$(call install_fixup, libwpe,AUTHOR,"Steffen Trumtrar <s.trumtrar@pengutronix.de>")
	@$(call install_fixup, libwpe,DESCRIPTION,missing)

	@$(call install_lib, libwpe, 0, 0, 0644, libwpe-$(LIBWPE_LIBRARY_VERSION))

	@$(call install_finish, libwpe)

	@$(call touch)

# vim: syntax=make
