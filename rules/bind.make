# -*-makefile-*-
#
# Copyright (C) 2021 by Roland Hieber, Pengutronix <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BIND) += bind

#
# Paths and names
#
BIND_VERSION		:= 9.11.37
BIND_MD5		:= 0a11e9596c46d6728fa3b0989ee75197
BIND			:= bind-$(BIND_VERSION)
BIND_SUFFIX		:= tar.gz
BIND_URL		:= https://ftp.isc.org/isc/bind9/$(BIND_VERSION)/$(BIND).$(BIND_SUFFIX)
BIND_SOURCE		:= $(SRCDIR)/$(BIND).$(BIND_SUFFIX)
BIND_DIR		:= $(BUILDDIR)/$(BIND)
BIND_LICENSE		:= MPL-2.0 AND ISC AND BSD-3-Clause AND BSD-2-Clause \
	AND unknown AND JPNIC AND RSA-MD AND OpenSSL AND Apache-2.0
BIND_LICENSE_FILES	:= \
	file://LICENSE;md5=f27a50d2e878867827842f2c60e30bfc \
	file://COPYRIGHT;md5=89a97ebbf713f7125fe5c02223d3ae95

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BIND_CONF_ENV	:= \
	$(CROSS_ENV) \
	BUILD_CC=$(PTXCONF_SETUP_HOST_CC)

#
# autoconf
#
BIND_CONF_TOOL	:= autoconf

# broken options: --disable-afl
BIND_CONF_OPT	:=  \
	$(CROSS_AUTOCONF_USR) \
	--disable-libbind \
	--enable-buffer-useinline \
	--disable-warn-shadow \
	--disable-warn-error \
	--disable-developer \
	--disable-seccomp \
	--disable-kqueue \
	--disable-epoll \
	--disable-devpoll \
	--disable-threads \
	--disable-native-pkcs11 \
	--disable-openssl-hash \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-backtrace \
	--disable-symtable \
	--$(call ptx/endis, PTXCONF_GLOBAL_IPV6)-ipv6 \
	--disable-tcp-fastopen \
	--enable-getifaddrs \
	--disable-chroot \
	--disable-linux-caps \
	--enable-atomic \
	--disable-fixed-rrset \
	--enable-rpz-nsip \
	--enable-rpz-nsdname \
	--disable-filter-aaaa \
	--disable-dnstap \
	--disable-querytrace \
	--enable-full-report \
	--without-python \
	--without-python-install-dir \
	--without-geoip \
	--without-geoip2 \
	--without-gssapi \
	--with-randomdev=/dev/zero \
	--with-locktype=standard \
	--without-libtool \
	--without-openssl \
	--without-pkcs11 \
	--without-ecdsa \
	--without-gost \
	--without-eddsa \
	--without-aes \
	--without-lmdb \
	--without-libxml2 \
	--without-libjson \
	--without-zlib \
	--without-purify \
	--without-gperftools-profiler \
	--without-kame \
	--without-readline \
	--without-protobuf-c \
	--without-libfstrm \
	--without-docbook-xsl \
	--without-idnkit \
	--without-iconv \
	--without-idnlib \
	--without-libidn2 \
	--without-cmocka \
	--without-tuning \
	--without-dlopen \
	--without-dlz-postgres \
	--without-dlz-mysql \
	--without-dlz-bdb \
	--without-dlz-filesystem \
	--without-dlz-ldap \
	--without-dlz-odbc \
	--without-dlz-stub \
	--without-make-clean

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

# only build the static libraries for now
BIND_MAKE_OPT := -C lib

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

# only install the static libraries for now
BIND_INSTALL_OPT := -C lib install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bind.targetinstall:
	@$(call targetinfo)
	# empty, only static libraries are built
	@$(call touch)

# vim: syntax=make
