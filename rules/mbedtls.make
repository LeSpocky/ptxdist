# -*-makefile-*-
#
# Copyright (C) 2019 by Bjoern Esser <bes@pengutronix.de>
#               2022 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MBEDTLS) += mbedtls

#
# Paths and names
#
MBEDTLS_VERSION		:= 2.28.0
MBEDTLS_MD5		:= d64054513df877458493dbb28e2935fa
MBEDTLS			:= mbedtls-$(MBEDTLS_VERSION)
MBEDTLS_SUFFIX		:= tar.gz
MBEDTLS_URL		:= https://github.com/Mbed-TLS/mbedtls/archive/refs/tags/v$(MBEDTLS_VERSION).$(MBEDTLS_SUFFIX)
MBEDTLS_SOURCE		:= $(SRCDIR)/$(MBEDTLS).$(MBEDTLS_SUFFIX)
MBEDTLS_DIR		:= $(BUILDDIR)/$(MBEDTLS)
MBEDTLS_LICENSE		:= Apache-2.0
MBEDTLS_LICENSE_FILES	:= file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
MBEDTLS_CONF_TOOL	:= cmake
MBEDTLS_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DENABLE_PROGRAMS=OFF \
	-DENABLE_TESTING=OFF \
	-DENABLE_ZLIB_SUPPORT=ON \
	-DINSTALL_MBEDTLS_HEADERS=ON \
	-DLINK_WITH_PTHREAD=ON \
	-DLINK_WITH_TRUSTED_STORAGE=OFF \
	-DMBEDTLS_FATAL_WARNINGS=OFF \
	-DUNSAFE_BUILD=OFF \
	-DUSE_PKCS11_HELPER_LIBRARY=OFF \
	-DUSE_SHARED_MBEDTLS_LIBRARY=ON \
	-DUSE_STATIC_MBEDTLS_LIBRARY=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mbedtls.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mbedtls)
	@$(call install_fixup, mbedtls,PRIORITY,optional)
	@$(call install_fixup, mbedtls,SECTION,base)
	@$(call install_fixup, mbedtls,AUTHOR,"Bjoern Esser <bes@pengutronix.de>")
	@$(call install_fixup, mbedtls,DESCRIPTION,missing)

	@$(call install_lib, mbedtls, 0, 0, 0644, libmbedcrypto)
	@$(call install_lib, mbedtls, 0, 0, 0644, libmbedtls)
	@$(call install_lib, mbedtls, 0, 0, 0644, libmbedx509)

	@$(call install_finish, mbedtls)

	@$(call touch)

# vim: syntax=make
