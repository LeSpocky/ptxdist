# -*-makefile-*-
#
# Copyright (C) 2015 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_POSTGRESQL) += postgresql

#
# Paths and names
#
POSTGRESQL_VERSION	:= 11.5
POSTGRESQL_MD5		:= 580da94f6d85046ff2a228785ab2cc89
POSTGRESQL		:= postgresql-$(POSTGRESQL_VERSION)
POSTGRESQL_SUFFIX	:= tar.bz2
POSTGRESQL_URL		:= https://ftp.postgresql.org/pub/source/v$(POSTGRESQL_VERSION)/$(POSTGRESQL).$(POSTGRESQL_SUFFIX)
POSTGRESQL_SOURCE	:= $(SRCDIR)/$(POSTGRESQL).$(POSTGRESQL_SUFFIX)
POSTGRESQL_DIR		:= $(BUILDDIR)/$(POSTGRESQL)
POSTGRESQL_LICENSE	:= PostgreSQL

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

POSTGRESQL_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_file__dev_urandom=yes

#
# autoconf
#
POSTGRESQL_CONF_TOOL	:= autoconf
POSTGRESQL_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
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
	--$(call ptx/wwo,POSTGRESQL_SYSTEMD)-systemd \
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

POSTGRESQL_MAKE_ENV	:= \
	MAKELEVEL=0

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/postgresql.targetinstall:
	@$(call targetinfo)

	@$(call install_init, postgresql)
	@$(call install_fixup, postgresql,PRIORITY,optional)
	@$(call install_fixup, postgresql,SECTION,base)
	@$(call install_fixup, postgresql,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, postgresql,DESCRIPTION,missing)

#	# Libraries
	@$(call install_lib, postgresql, 0, 0, 0644, libpq)
	@$(call install_lib, postgresql, 0, 0, 0644, libecpg)
	@$(call install_lib, postgresql, 0, 0, 0644, libecpg_compat)
	@$(call install_lib, postgresql, 0, 0, 0644, libpgtypes)

#	# Binaries
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/postgres)
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/pg_receivewal)
	@$(call install_link, postgresql, postgres, /usr/bin/postmaster)
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/reindexdb)
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/pg_isready)
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/pg_dump)
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/vacuumdb)
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/pg_ctl)
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/dropuser)
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/createdb)
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/createuser)
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/initdb)
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/pg_restore)
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/clusterdb)
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/pg_recvlogical)
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/pg_resetwal)
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/dropdb)
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/ecpg)
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/pg_dumpall)
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/pg_basebackup)
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/psql)
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/pg_controldata)
	@$(call install_copy, postgresql, 0, 0, 0755, -, /usr/bin/pg_config)

#	# This can be further optimized
	@$(call install_tree, postgresql, 0, 0, -, /usr/lib/postgresql)
	@$(call install_tree, postgresql, 0, 0, -, /usr/share/postgresql)

	@$(call install_finish, postgresql)

	@$(call touch)

# vim: syntax=make
