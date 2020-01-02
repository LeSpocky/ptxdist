# -*-makefile-*-
#
# Copyright (C) 2019 by Alexander Dahl <ada@thorsis.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CMOCKA) += cmocka

#
# Paths and names
#
CMOCKA_VERSION		:= 1.1.5
CMOCKA_MD5		:= 91f95cd5db88b9b120d191b18d367193
CMOCKA			:= cmocka-$(CMOCKA_VERSION)
CMOCKA_SUFFIX		:= tar.xz
CMOCKA_URL		:= https://cmocka.org/files/$(basename $(CMOCKA_VERSION))/$(CMOCKA).$(CMOCKA_SUFFIX)
CMOCKA_SOURCE		:= $(SRCDIR)/$(CMOCKA).$(CMOCKA_SUFFIX)
CMOCKA_DIR		:= $(BUILDDIR)/$(CMOCKA)
CMOCKA_LICENSE		:= Apache-2.0
CMOCKA_LICENSE_FILES	:= file://COPYING;md5=3b83ef96387f14655fc854ddc3c6bd57

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CMOCKA_CONF_TOOL	:= cmake
CMOCKA_CONF_OPT		:= \
	$(CROSS_CMAKE_USR) \
	-DBUILD_TESTING=OFF \
	-DPICKY_DEVELOPER:BOOL=OFF \
	-DUNIT_TESTING:BOOL=OFF \
	-DWITH_CMOCKERY_SUPPORT:BOOL=OFF \
	-DWITH_EXAMPLES:BOOL=OFF \
	-DWITH_STATIC_LIB=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cmocka.targetinstall:
	@$(call targetinfo)

	@$(call install_init, cmocka)
	@$(call install_fixup, cmocka,PRIORITY,optional)
	@$(call install_fixup, cmocka,SECTION,base)
	@$(call install_fixup, cmocka,AUTHOR,"Alexander Dahl <ada@thorsis.com>")
	@$(call install_fixup, cmocka,DESCRIPTION,missing)

	@$(call install_lib, cmocka, 0, 0, 0644, libcmocka)

	@$(call install_finish, cmocka)

	@$(call touch)

# vim: ft=make noet tw=72 ts=8 sw=8
