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
	--enable-http \
	--disable-ftp \
	--disable-file \
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
	--disable-mqtt \
	--disable-manual \
	--enable-libcurl-option \
	--disable-libgcc \
	--enable-ipv6 \
	--enable-openssl-auto-load-config \
	--disable-versioned-symbols \
	--disable-threaded-resolver \
	--enable-pthreads \
	--disable-verbose \
	--disable-sspi \
	--disable-crypto-auth \
	--disable-ntlm \
	--disable-ntlm-wb \
	--disable-tls-srp \
	--enable-unix-sockets \
	--disable-cookies \
	--enable-socketpair \
	--disable-http-auth \
	--disable-doh \
	--disable-mime \
	--enable-dateparse \
	--disable-netrc \
	--enable-progress-meter \
	--disable-dnsshuffle \
	--enable-get-easy-options \
	--disable-alt-svc \
	--enable-hsts \
	--without-schannel \
	--without-secure-transport \
	--without-amissl \
	--with-openssl=$(PTXDIST_SYSROOT_HOST) \
	--without-gnutls \
	--without-mbedtls \
	--without-wolfssl \
	--without-bearssl \
	--without-rustls \
	--without-nss \
	--without-hyper \
	--without-zlib \
	--without-brotli \
	--without-zstd \
	--without-gssapi \
	--with-default-ssl-backend=openssl \
	--with-random=/dev/urandom \
	--without-ca-fallback \
	--without-libpsl \
	--without-libgsasl \
	--without-libssh2 \
	--without-libssh \
	--without-wolfssh \
	--without-librtmp \
	--without-winidn \
	--without-libidn2 \
	--without-nghttp2 \
	--without-ngtcp2 \
	--without-nghttp3 \
	--without-quiche \
	--without-zsh-functions-dir \
	--without-fish-functions-dir

$(STATEDIR)/host-libcurl.install:
	@$(call targetinfo)
	@$(call world/install, HOST_LIBCURL)
	@rm -v $(HOST_LIBCURL_PKGDIR)/usr/bin/curl
	@$(call touch)

# vim: syntax=make
