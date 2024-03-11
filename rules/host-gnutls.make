# -*-makefile-*-
#
# Copyright (C) 2024 by Markus Heidelberg <m.heidelberg@cab.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GNUTLS) += host-gnutls

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_GNUTLS_CONF_TOOL	:= autoconf
HOST_GNUTLS_CONF_OPT	:=  \
	$(HOST_AUTOCONF) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-threads=posix \
	--disable-code-coverage \
	--disable-bash-tests \
	--disable-doc \
	--disable-manpages \
	--disable-tools \
	--enable-cxx \
	--disable-dyn-ncrypt \
	--enable-hardware-acceleration \
	--enable-tls13-interop \
	--enable-padlock \
	--enable-strict-der-time \
	--enable-sha1-support \
	--disable-ssl3-support \
	--enable-ssl2-support \
	--enable-dtls-srtp-support \
	--enable-alpn-support \
	--enable-heartbeat-support \
	--enable-srp-authentication \
	--enable-psk-authentication \
	--enable-anon-authentication \
	--enable-dhe \
	--enable-ecdhe \
	--enable-gost \
	--disable-cryptodev \
	--disable-afalg \
	--disable-ktls \
	--enable-ocsp \
	--disable-openssl-compatibility \
	--disable-tests \
	--disable-fuzzer-target \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-nls \
	--disable-rpath \
	--disable-seccomp-tests \
	--enable-cross-guesses=conservative \
	--disable-valgrind-tests \
	--disable-full-test-suite \
	--disable-oldgnutls-interop \
	--disable-gcc-warnings \
	--disable-static \
	--enable-shared \
	--disable-fips140-mode \
	--disable-strict-x509 \
	--enable-non-suiteb-curves \
	--disable-libdane \
	--disable-guile \
	--without-gcov \
	--with-nettle-mini \
	--without-included-libtasn1 \
	--with-included-unistring \
	--without-fips140-key \
	--without-fips140-module-name \
	--without-fips140-module-version \
	--with-pkcs12-iter-count=600000 \
	--without-idn \
	--without-unbound-root-key-file \
	--without-system-priority-file \
	--without-default-priority-string \
	--without-p11-kit \
	--without-tpm2 \
	--without-tpm \
	--without-trousers-lib \
	--without-zlib \
	--without-brotli \
	--without-zstd \
	--with-default-trust-store-file=/etc/ssl/certs/ca-certificates.crt

# vim: syntax=make
