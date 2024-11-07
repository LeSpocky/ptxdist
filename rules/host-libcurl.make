# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBCURL) += host-libcurl

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LIBCURL_CONF_TOOL	:= autoconf
HOST_LIBCURL_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	\
	--enable-optimize \
	--disable-warnings \
	--disable-werror \
	--disable-curldebug \
	--enable-symbol-hiding \
	--disable-ares \
	--enable-rt \
	--disable-ech \
	--disable-code-coverage \
	--disable-unity \
	--disable-test-bundles \
	--enable-http \
	--disable-ftp \
	--disable-file \
	--disable-ipfs \
	--disable-ldap \
	--disable-ldaps \
	--disable-rtsp \
	--enable-proxy \
	--disable-dict \
	--disable-telnet \
	--disable-tftp \
	--disable-pop3 \
	--disable-imap \
	--disable-smb \
	--disable-smtp \
	--disable-gopher \
	--disable-docs \
	--disable-mqtt \
	--disable-manual \
	--enable-libcurl-option \
	--disable-libgcc \
	--enable-ipv6 \
	--enable-openssl-auto-load-config \
	--disable-versioned-symbols \
	--disable-windows-unicode \
	--disable-threaded-resolver \
	--enable-pthreads \
	--disable-verbose \
	--disable-sspi \
	--enable-basic-auth \
	--disable-bearer-auth \
	--disable-digest-auth \
	--disable-kerberos-auth \
	--disable-negotiate-auth \
	--disable-aws \
	--disable-ntlm \
	--disable-tls-srp \
	--enable-unix-sockets \
	--disable-cookies \
	--enable-socketpair \
	--disable-http-auth \
	--disable-doh \
	--disable-mime \
	--enable-bindlocal \
	--disable-form-api \
	--enable-dateparse \
	--disable-netrc \
	--enable-progress-meter \
	--enable-sha512-256 \
	--disable-dnsshuffle \
	--enable-get-easy-options \
	--disable-alt-svc \
	--disable-headers-api \
	--enable-hsts \
	--disable-websockets \
	--without-schannel \
	--without-secure-transport \
	--without-amissl \
	--with-ssl \
	--with-openssl=$(PTXDIST_SYSROOT_HOST) \
	--without-gnutls \
	--without-mbedtls \
	--without-wolfssl \
	--without-bearssl \
	--without-rustls \
	--without-hyper \
	--without-zlib \
	--without-brotli \
	--without-zstd \
	--without-gssapi \
	--with-default-ssl-backend=openssl \
	--without-ca-fallback \
	--without-libpsl \
	--without-libgsasl \
	--without-libssh2 \
	--without-libssh \
	--without-wolfssh \
	--without-librtmp \
	--without-winidn \
	--without-apple-idn \
	--without-libidn2 \
	--without-nghttp2 \
	--without-ngtcp2 \
	--without-nghttp3 \
	--without-quiche \
	--without-msh3 \
	--without-zsh-functions-dir \
	--without-fish-functions-dir

$(STATEDIR)/host-libcurl.install:
	@$(call targetinfo)
	@$(call world/install, HOST_LIBCURL)
	@rm -v $(HOST_LIBCURL_PKGDIR)/usr/bin/curl
	@$(call touch)

# vim: syntax=make
