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
	--disable-gost \
	--disable-non-paged-memory \
	--disable-visibility \
	--with-p11-kit=/share/p11-kit/modules \
	--with-crypto-backend=openssl \
	--without-migrate \
	--with-objectstore-backend-db

HOST_SOFTHSM_CPPFLAGS := \
	-DDEBUG_LOG_STDERR=1

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-softhsm.install:
	@$(call targetinfo)
	@$(call world/install, HOST_SOFTHSM)
	@mkdir -p $(HOST_SOFTHSM_PKGDIR)/usr/ssl
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
	echo "module = @SYSROOT@/usr/lib/ossl-modules/pkcs11.so"; \
	echo 'activate = 1'; \
	echo 'pkcs11-module-block-operations = digest'; \
	} > $(HOST_SOFTHSM_PKGDIR)/usr/ssl/openssl-pkcs11.cnf
	@$(call touch)

$(STATEDIR)/host-softhsm.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_SOFTHSM)
	@sed -i 's;@SYSROOT@;$(PTXDIST_SYSROOT_HOST);' \
		$(PTXDIST_SYSROOT_HOST)/usr/ssl/openssl-pkcs11.cnf
	@$(call touch)

# vim: syntax=make
