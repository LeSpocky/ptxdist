# -*-makefile-*-
#
# Copyright (C) 2023 by Clemens Gruber <clemens.gruber@pqgruber.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MINISIGN) += minisign

#
# Paths and names
#
MINISIGN_VERSION	:= 0.11
MINISIGN_MD5		:= 1565d40ec75b9602e84379c9f1e96371
MINISIGN		:= minisign-$(MINISIGN_VERSION)
MINISIGN_SUFFIX		:= tar.gz
MINISIGN_URL		:= https://github.com/jedisct1/minisign/archive/refs/tags/$(MINISIGN_VERSION).$(MINISIGN_SUFFIX)
MINISIGN_SOURCE		:= $(SRCDIR)/$(MINISIGN).$(MINISIGN_SUFFIX)
MINISIGN_DIR		:= $(BUILDDIR)/$(MINISIGN)
MINISIGN_LICENSE	:= ISC
MINISIGN_LICENSE_FILES	:= file://LICENSE;md5=ae8e10a2c8237f13943f14fa3ffe437a

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
MINISIGN_CONF_TOOL	:= cmake
MINISIGN_CONF_OPT	:= \
	$(CROSS_CMAKE_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/minisign.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  minisign)
	@$(call install_fixup, minisign,PRIORITY,optional)
	@$(call install_fixup, minisign,SECTION,base)
	@$(call install_fixup, minisign,AUTHOR,"Clemens Gruber <clemens.gruber@pqgruber.com>")
	@$(call install_fixup, minisign,DESCRIPTION,missing)

	@$(call install_copy, minisign, 0, 0, 0755, -, /usr/bin/minisign)

	@$(call install_finish, minisign)

	@$(call touch)

# vim: syntax=make
