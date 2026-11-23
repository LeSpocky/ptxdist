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
MBEDTLS_VERSION		:= 4.1.2
MBEDTLS_SHA256		:= 392215e5e4846df04e2f4c4516079303bd73edde837d8f3e68fb4d4d7ddf0126
MBEDTLS			:= mbedtls-$(MBEDTLS_VERSION)
MBEDTLS_SUFFIX		:= tar.bz2
MBEDTLS_URL		:= https://github.com/Mbed-TLS/mbedtls/releases/download/$(MBEDTLS)/$(MBEDTLS).$(MBEDTLS_SUFFIX)
MBEDTLS_SOURCE		:= $(SRCDIR)/$(MBEDTLS).$(MBEDTLS_SUFFIX)
MBEDTLS_DIR		:= $(BUILDDIR)/$(MBEDTLS)
MBEDTLS_LICENSE		:= Apache-2.0 OR GPL-2.0-or-later
MBEDTLS_LICENSE_FILES	:= file://LICENSE;md5=379d5819937a6c2f1ef1630d341e026d

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
	-DGEN_FILES=OFF \
	-DINSTALL_MBEDTLS_HEADERS=ON \
	-DINSTALL_TF_PSA_CRYPTO_HEADERS=OFF \
	-DLINK_WITH_PTHREAD=ON \
	-DLINK_WITH_TRUSTED_STORAGE=OFF \
	-DMBEDTLS_CONFIG_FILE= \
	-DMBEDTLS_FATAL_WARNINGS=OFF \
	-DMBEDTLS_USER_CONFIG_FILE= \
	-DUSE_SHARED_MBEDTLS_LIBRARY=ON \
	-DUSE_SHARED_TF_PSA_CRYPTO_LIBRARY=ON \
	-DUSE_STATIC_MBEDTLS_LIBRARY=OFF \
	-DUSE_STATIC_TF_PSA_CRYPTO_LIBRARY=OFF

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

	@$(call install_lib, mbedtls, 0, 0, 0644, libtfpsacrypto)
	@$(call install_lib, mbedtls, 0, 0, 0644, libmbedcrypto)
	@$(call install_lib, mbedtls, 0, 0, 0644, libmbedtls)
	@$(call install_lib, mbedtls, 0, 0, 0644, libmbedx509)

	@$(call install_finish, mbedtls)

	@$(call touch)

# vim: syntax=make
