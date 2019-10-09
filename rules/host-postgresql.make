# -*-makefile-*-
#
# Copyright (C) 2019 by Bjoern Esser <bes@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_POSTGRESQL) += host-postgresql

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#HOST_POSTGRESQL_CONF_ENV	:= $(HOST_ENV)

#
# autoconf
#
HOST_POSTGRESQL_CONF_TOOL	:= autoconf
HOST_POSTGRESQL_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--enable-integer-datetimes \
	--disable-nls \
	--disable-rpath \
	--enable-spinlocks \
	--enable-atomics \
	--enable-strong-random \
	--disable-debug \
	--disable-profiling \
	--disable-coverage \
	--disable-dtrace \
	--disable-tap-tests \
	--disable-depend \
	--disable-cassert \
	--enable-thread-safety \
	--enable-largefile \
	--disable-float4-byval \
	--disable-float8-byval \
	--without-llvm \
	--without-icu \
	--without-tcl \
	--without-perl \
	--without-python \
	--without-gssapi \
	--without-pam \
	--without-bsd-auth \
	--without-ldap \
	--without-bonjour \
	--without-openssl \
	--without-selinux \
	--without-systemd \
	--without-readline \
	--without-libedit-preferred \
	--without-ossp-uuid \
	--without-libxml \
	--without-libxslt \
	--with-system-tzdata=/usr/share/zoneinfo \
	--without-zlib

#  --enable-tap-tests      enable TAP tests (requires Perl and IPC::Run)
#  --enable-depend         turn on automatic dependency tracking
#  --with-uuid=LIB         build contrib/uuid-ossp using LIB (bsd,e2fs,ossp)
#  --with-ossp-uuid        obsolete spelling of --with-uuid=ossp

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

HOST_POSTGRESQL_MAKE_ENV	:= \
	MAKELEVEL=0

HOST_POSTGRESQL_MAKE_OPT	:= \
	-C src/bin/pg_config

HOST_POSTGRESQL_INSTALL_OPT	:= \
	$(HOST_POSTGRESQL_MAKE_OPT) \
	install

# vim: syntax=make
