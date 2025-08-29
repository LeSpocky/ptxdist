# -*-makefile-*-
#
# Copyright (C) 2012 by Jan Luebbe <jlu@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GNUTLS) += gnutls

#
# Paths and names
#
GNUTLS_VERSION		:= 3.8.10
GNUTLS_MD5		:= 803c6f5c9cbe55c64fbb46690d329a77
GNUTLS			:= gnutls-$(GNUTLS_VERSION)
GNUTLS_SUFFIX		:= tar.xz
GNUTLS_URL		:= https://www.gnupg.org/ftp/gcrypt/gnutls/v3.8/$(GNUTLS).$(GNUTLS_SUFFIX)
GNUTLS_SOURCE		:= $(SRCDIR)/$(GNUTLS).$(GNUTLS_SUFFIX)
GNUTLS_DIR		:= $(BUILDDIR)/$(GNUTLS)
GNUTLS_LICENSE		:= LGPL-3.0-or-later
GNUTLS_LICENSE_FILES	:= \
	file://COPYING.LESSERv2;md5=4bf661c1e3793e55c8d1051bc5e0ae21 \
	file://README.md;startline=181;endline=206;md5=a3b6ee773c4031524191773c86fc17df

ifdef PTXCONF_GNUTLS_OPENSSL
GNUTLS_LICENSE 		+= AND GPL-3.0-or-later
GNUTLS_LICENSE_FILES	+= \
	file://extra/gnutls_openssl.c;startline=1;endline=19;md5=b8b99cb92b0fbb522912f20e3359913c \
	file://COPYING;md5=1ebbd3e34237af26da5dc08a4e440464
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ifdef PTXCONF_KERNEL_HEADER
GNUTLS_CPPFLAGS	:= \
	-isystem $(KERNEL_HEADERS_INCLUDE_DIR)
endif

#
# autoconf
#
GNUTLS_CONF_TOOL	:= autoconf
GNUTLS_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
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
	--$(call ptx/endis, PTXCONF_GNUTLS_CRYPTODEV)-cryptodev \
	--$(call ptx/endis, PTXCONF_GNUTLS_AFALG)-afalg \
	--$(call ptx/endis, PTXCONF_GNUTLS_KTLS)-ktls \
	--enable-ocsp \
	--$(call ptx/endis, PTXCONF_GNUTLS_OPENSSL)-openssl-compatibility \
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
	--disable-dsa \
	--disable-libdane \
	--$(call ptx/endis, PTXDIST_Y2038)-year2038 \
	--without-gcov \
	--with-nettle-mini \
	--without-included-libtasn1 \
	--with-included-unistring \
	--without-fips140-key \
	--without-idn \
	--without-p11-kit \
	--without-tpm2 \
	--without-tpm \
	--without-trousers-lib \
	--without-zlib \
	--without-brotli \
	--without-zstd \
	--without-leancrypto \
	--with-default-trust-store-file=/etc/ssl/certs/ca-certificates.crt

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gnutls.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gnutls)
	@$(call install_fixup, gnutls,PRIORITY,optional)
	@$(call install_fixup, gnutls,SECTION,base)
	@$(call install_fixup, gnutls,AUTHOR,"Jan Luebbe <jlu@pengutronix.de>")
	@$(call install_fixup, gnutls,DESCRIPTION,missing)

	@$(call install_lib, gnutls, 0, 0, 0644, libgnutls)
ifdef PTXCONF_GNUTLS_CXX
	@$(call install_lib, gnutls, 0, 0, 0644, libgnutlsxx)
endif

ifdef PTXCONF_GNUTLS_OPENSSL
	@$(call install_lib, gnutls, 0, 0, 0644, libgnutls-openssl)
endif

	@$(call install_finish, gnutls)

	@$(call touch)

# vim: syntax=make
