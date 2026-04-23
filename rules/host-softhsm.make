# -*-makefile-*-
#
# Copyright (C) 2018 by Juergen Borleis <jbe@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SOFTHSM) += host-softhsm

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_SOFTHSM_CONF_TOOL	:= autoconf
HOST_SOFTHSM_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-non-paged-memory \
	--disable-gost \
	--with-crypto-backend=openssl \
	--with-objectstore-backend-db \
	--without-migrate \
	--with-p11-kit=/share/p11-kit/modules
HOST_SOFTHSM_CPPFLAGS := \
	-DDEBUG_LOG_STDERR=1

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-softhsm.install:
	@$(call targetinfo)
	@$(call world/install, HOST_SOFTHSM)
	@{ \
	echo 'openssl_conf = openssl_init'; \
	echo ''; \
	echo '[openssl_init]'; \
	echo 'providers = provider_sect'; \
	echo ''; \
	echo '[provider_sect]'; \
	echo 'default = default_sect'; \
	echo 'pkcs11 = pkcs11_sect'; \
	echo ''; \
	echo '[default_sect]'; \
	echo 'activate = 1'; \
	echo ''; \
	echo '[pkcs11_sect]'; \
	echo "module = $(PTXDIST_SYSROOT_HOST)/usr/lib/ossl-modules/pkcs11.so"; \
	echo 'activate = 1'; \
	echo 'pkcs11-module-block-operations = digest'; \
	} > $(PTXDIST_SYSROOT_HOST)/usr/ssl/openssl-pkcs11.cnf
	@$(call touch)

# vim: syntax=make
