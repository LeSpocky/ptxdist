# -*-makefile-*-
#
# Copyright (C) 2017 by Bastian Stender <bst@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MARIADB) += mariadb

#
# Paths and names
#
MARIADB_VERSION	:= 11.4.4
MARIADB_MD5	:= 969bead58d84d1f9fc16c6aa01e751fa
MARIADB		:= mariadb-$(MARIADB_VERSION)
MARIADB_SUFFIX	:= tar.gz
MARIADB_URL	:= https://archive.mariadb.org/$(MARIADB)/source/$(MARIADB).$(MARIADB_SUFFIX)
MARIADB_SOURCE	:= $(SRCDIR)/$(MARIADB).$(MARIADB_SUFFIX)
MARIADB_DIR	:= $(BUILDDIR)/$(MARIADB)
MARIADB_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# MARIADB_PLUGINS_ENABLED-y builds plugin dynamically
# MARIADB_PLUGINS_ENABLE- disables plugin
MARIADB_PLUGINS_ENABLE- += ARCHIVE
MARIADB_PLUGINS_ENABLE- += AUDIT_NULL
MARIADB_PLUGINS_ENABLE- += AUTH_0X0100
MARIADB_PLUGINS_ENABLE- += AUTH_ED25519
MARIADB_PLUGINS_ENABLE- += AUTH_GSSAPI
MARIADB_PLUGINS_ENABLE- += AUTH_PAM
MARIADB_PLUGINS_ENABLE- += AUTH_PAM_V1
MARIADB_PLUGINS_ENABLE- += AUTH_TEST_PLUGIN
MARIADB_PLUGINS_ENABLE- += BLACKHOLE
MARIADB_PLUGINS_ENABLE- += CONNECT
MARIADB_PLUGINS_ENABLE- += DAEMON_EXAMPLE
MARIADB_PLUGINS_ENABLE- += DEBUG_KEY_MANAGEMENT
MARIADB_PLUGINS_ENABLE- += DIALOG_EXAMPLES
MARIADB_PLUGINS_ENABLE- += DISKS
MARIADB_PLUGINS_ENABLE- += EXAMPLE
MARIADB_PLUGINS_ENABLE- += EXAMPLE_KEY_MANAGEMENT
MARIADB_PLUGINS_ENABLE- += FEDERATED
MARIADB_PLUGINS_ENABLE- += FEDERATEDX
MARIADB_PLUGINS_ENABLE- += FEEDBACK
MARIADB_PLUGINS_ENABLE- += FILE_KEY_MANAGEMENT
MARIADB_PLUGINS_ENABLE- += FTEXAMPLE
MARIADB_PLUGINS_ENABLE- += FUNC_TEST
MARIADB_PLUGINS_ENABLE- += HANDLERSOCKET
# enable default engine
MARIADB_PLUGINS_ENABLE-y += INNOBASE
MARIADB_PLUGINS_ENABLE- += LOCALES
MARIADB_PLUGINS_ENABLE- += METADATA_LOCK_INFO
MARIADB_PLUGINS_ENABLE- += MROONGA
MARIADB_PLUGINS_ENABLE- += PARTITION
MARIADB_PLUGINS_ENABLE- += PASSWORD_REUSE_CHECK
MARIADB_PLUGINS_ENABLE- += PERFSCHEMA
MARIADB_PLUGINS_ENABLE- += QA_AUTH_CLIENT
MARIADB_PLUGINS_ENABLE- += QA_AUTH_INTERFACE
MARIADB_PLUGINS_ENABLE- += QA_AUTH_SERVER
MARIADB_PLUGINS_ENABLE- += QUERY_CACHE_INFO
MARIADB_PLUGINS_ENABLE- += QUERY_RESPONSE_TIME
MARIADB_PLUGINS_ENABLE- += ROCKSDB
MARIADB_PLUGINS_ENABLE- += S3
MARIADB_PLUGINS_ENABLE- += SEQUENCE
MARIADB_PLUGINS_ENABLE- += SERVER_AUDIT
MARIADB_PLUGINS_ENABLE- += SIMPLE_PASSWORD_CHECK
MARIADB_PLUGINS_ENABLE- += SPHINX
MARIADB_PLUGINS_ENABLE- += SPIDER
MARIADB_PLUGINS_ENABLE- += SQL_ERRLOG
MARIADB_PLUGINS_ENABLE- += TEST_SQL_DISCOVERY
MARIADB_PLUGINS_ENABLE- += TEST_SQL_SERVICE
MARIADB_PLUGINS_ENABLE- += TEST_VERSIONING
MARIADB_PLUGINS_ENABLE- += THREAD_POOL_INFO
MARIADB_PLUGINS_ENABLE- += TYPE_MYSQL_JSON
MARIADB_PLUGINS_ENABLE- += TYPE_MYSQL_TIMESTAMP
MARIADB_PLUGINS_ENABLE- += TYPE_TEST
MARIADB_PLUGINS_ENABLE- += USER_VARIABLES

ifneq ($(strip $(MARIADB_PLUGINS_ENABLE-)),)
MARIADB_CONF_OPT_PLUGINS := $(foreach plugin,$(MARIADB_PLUGINS_ENABLE-),$(addprefix -DPLUGIN_,$(addsuffix =NO, $(plugin))))
endif

ifneq ($(strip $(MARIADB_PLUGINS_ENABLED-y)),)
MARIADB_CONF_OPT_PLUGINS += $(foreach plugin,$(MARIADB_PLUGINS_ENABLED-y),$(addprefix -DPLUGIN_,$(addsuffix =DYNAMIC, $(plugin))))
endif

# cmake
#
MARIADB_CONF_TOOL	:= cmake

# Note: several options disappear when they are set to NO/OFF
MARIADB_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DAWS_SDK_EXTERNAL_PROJECT=OFF \
	-DCONC_DEFAULT_SSL_VERIFY_SERVER_CERT=ON \
	-DCONC_WITH_BOOST_CONTEXT=OFF \
	-DCONC_WITH_DOCS=OFF \
	-DCONC_WITH_DYNCOL=OFF \
	-DCONC_WITH_UNIT_TESTS=OFF \
	-DDISABLE_SHARED=OFF \
	-DENABLED_JSON_WRITER_CONSISTENCY_CHECKS=OFF \
	-DENABLED_PROFILING=OFF \
	-DENABLE_GCOV=OFF \
	-DFEATURE_SET=community \
	-DFEATURE_SUMMARY=ON \
	-DIMPORT_EXECUTABLES=$(PTXDIST_SYSROOT_HOST)/usr/share/mariadb/import_executables.cmake \
	-DINSTALL_LAYOUT=RPM \
	-DMYSQL_DATADIR=/var/lib/mysql/data \
	-DMYSQL_MAINTAINER_MODE=OFF \
	$(sort $(MARIADB_CONF_OPT_PLUGINS)) \
	-DSECURITY_HARDENED=ON \
	-DTMPDIR=/tmp \
	-DUPDATE_SUBMODULES=OFF \
	-DUSE_ARIA_FOR_TMP_TABLES=ON \
	-DWITHOUT_PACKED_SORT_KEYS=OFF \
	-DWITHOUT_SERVER=OFF \
	-DWITH_ASAN=OFF \
	-DWITH_DBUG_TRACE=OFF \
	-DWITH_EMBEDDED_SERVER=OFF \
	-DWITH_EXTRA_CHARSETS=all \
	-DWITH_GPROF=OFF \
	-DWITH_INNODB_AHI=OFF \
	-DWITH_INNODB_EXTRA_DEBUG=OFF \
	-DWITH_INNODB_ROOT_GUESS=OFF \
	-DWITH_INNODB_SNAPPY=OFF \
	-DWITH_JEMALLOC=OFF \
	-DWITH_LIBAIO=ON \
	-DWITH_LIBFMT=system \
	-DWITH_LIBWRAP=OFF \
	-DWITH_MSAN=OFF \
	-DWITH_NUMA=OFF \
	-DWITH_PCRE=system \
	-DWITH_PROTECT_STATEMENT_MEMROOT=OFF \
	-DWITH_READLINE=OFF \
	-DWITH_ROCKSDB_BZip2=OFF \
	-DWITH_ROCKSDB_LZ4=OFF \
	-DWITH_SAFEMALLOC=OFF \
	-DWITH_SSL=system \
	-DWITH_STRIPPED_CLIENT=OFF \
	-DWITH_SYSTEMD=$(call ptx/yesno, PTXCONF_MARIADB_SYSTEMD) \
	-DWITH_TSAN=OFF \
	-DWITH_UBSAN=OFF \
	-DWITH_UNIT_TESTS=OFF \
	-DWITH_URING=OFF \
	-DWITH_VALGRIND=OFF \
	-DWITH_WSREP=OFF \
	-DWITH_WSREP_ALL=OFF \
	-DWITH_ZLIB=system \
	\
	-DINSTALL_LIBDIR=lib \
	-DINSTALL_PLUGINDIR=lib/mysql/plugin \
	-DBUILD_CONFIG=mysql_release \
	-DCMAKE_DISABLE_FIND_PACKAGE_BISON=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_BZip2=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Boost=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_CURL=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_GSSAPI=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Git=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_LZ4=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_LZO=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_LibLZMA=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_LibXml2=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_Snappy=ON \
	-DCMAKE_DISABLE_FIND_PACKAGE_URING=ON \
	-DHAVE_SYSTEM_LIBFMT=TRUE \
	-DKRB5_CONFIG=/bin/false \
	-DLIBEDIT_LIBRARY=NOTFOUND \
	-DZSTD_LIBRARIES=NOTFOUND

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mariadb.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mariadb)
	@$(call install_fixup, mariadb, PRIORITY, optional)
	@$(call install_fixup, mariadb, SECTION, base)
	@$(call install_fixup, mariadb, AUTHOR, "Bastian Stender <bst@pengutronix.de>")
	@$(call install_fixup, mariadb, DESCRIPTION, "MariaDB")

#	# server stuff
	@$(call install_copy, mariadb, 0, 0, 0755, -, /usr/sbin/mariadbd)
	@$(call install_link, mariadb, mariadbd, /usr/sbin/mysqld)

	@$(call install_tree, mariadb, 0, 0, -, /usr/lib/mysql/plugin)

ifdef PTXCONF_MARIADB_SYSTEMD
	@$(call install_alternative, mariadb, 0, 0, 0644, /usr/lib/systemd/system/mariadb.service)
	@$(call install_link, mariadb, ../mariadb.service, \
		/usr/lib/systemd/system/multi-user.target.wants/mariadb.service)

	@$(call install_alternative, mariadb, 0, 0, 0644, /usr/lib/systemd/system/mariadb-init.service)
	@$(call install_link, mariadb, ../mariadb-init.service, \
		/usr/lib/systemd/system/multi-user.target.wants/mariadb-init.service)
endif
	@$(call install_alternative, mariadb, 0, 0, 0644, /etc/mariadb/my.cnf)

#	# TODO: do we need more languages?
	@$(call install_copy, mariadb, 0, 0, 0644, -, /usr/share/mariadb/english/errmsg.sys)

#	# TODO: do we need more charsets?
	@$(call install_copy, mariadb, 0, 0, 0644, -, /usr/share/mariadb/charsets/latin1.xml)

#	# client stuff
	@$(call install_copy, mariadb, 0, 0, 0755, -, /usr/bin/mariadb)
	@$(call install_link, mariadb, mariadb, /usr/bin/mysql)
	@$(call install_copy, mariadb, 0, 0, 0755, -, /usr/bin/mariadb-admin)
	@$(call install_link, mariadb, mariadb-admin, /usr/bin/mysqladmin)
	@$(call install_copy, mariadb, 0, 0, 0755, -, /usr/bin/mariadb-upgrade)
	@$(call install_link, mariadb, mariadb-upgrade, /usr/bin/mysql_upgrade)
	@$(call install_copy, mariadb, 0, 0, 0755, -, /usr/bin/mariadb-check)
	@$(call install_link, mariadb, mariadb-check, /usr/bin/mysqlcheck)
	@$(call install_copy, mariadb, 0, 0, 0755, -, /usr/bin/mariadb-dump)
	@$(call install_link, mariadb, mariadb-dump, /usr/bin/mysqldump)

#	# bootstrap script + dependencies
	@$(call install_copy, mariadb, 0, 0, 0755, -, /usr/bin/mariadb-install-db)
	@$(call install_link, mariadb, mariadb-install-db, /usr/bin/mysql_install_db)
	@$(call install_copy, mariadb, 0, 0, 0755, -, /usr/bin/my_print_defaults)
	@$(call install_copy, mariadb, 0, 0, 0755, -, /usr/bin/resolveip)

#	# bootstrap data required for mysql_install_db
	@$(call install_copy, mariadb, 0, 0, 0644, -, /usr/share/mariadb/fill_help_tables.sql)
	@$(call install_copy, mariadb, 0, 0, 0644, -, /usr/share/mariadb/maria_add_gis_sp.sql)
	@$(call install_copy, mariadb, 0, 0, 0644, -, /usr/share/mariadb/maria_add_gis_sp_bootstrap.sql)
	@$(call install_copy, mariadb, 0, 0, 0644, -, /usr/share/mariadb/mariadb_performance_tables.sql)
	@$(call install_copy, mariadb, 0, 0, 0644, -, /usr/share/mariadb/mariadb_sys_schema.sql)
	@$(call install_copy, mariadb, 0, 0, 0644, -, /usr/share/mariadb/mariadb_system_tables.sql)
	@$(call install_copy, mariadb, 0, 0, 0644, -, /usr/share/mariadb/mariadb_system_tables_data.sql)
	@$(call install_copy, mariadb, 0, 0, 0644, -, /usr/share/mariadb/mariadb_test_data_timezone.sql)
	@$(call install_copy, mariadb, 0, 0, 0644, -, /usr/share/mariadb/mariadb_test_db.sql)

	@$(call install_lib, mariadb, 0, 0, 0644, libmariadb)

#	# create a working directory which is writeable
	@$(call install_copy, mariadb, mysql, mysql, 0755, /var/lib/mysql)

	@$(call install_finish, mariadb)

	@$(call touch)

# vim: syntax=make
