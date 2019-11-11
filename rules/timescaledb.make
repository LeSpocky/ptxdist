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
PACKAGES-$(PTXCONF_TIMESCALEDB) += timescaledb

#
# Paths and names
#
TIMESCALEDB_VERSION	:= 1.5.0
TIMESCALEDB_MD5		:= d48403460f6ee4e3a8f9ba51a5a95899
TIMESCALEDB		:= timescaledb-$(TIMESCALEDB_VERSION)
TIMESCALEDB_SUFFIX	:= tar.gz
TIMESCALEDB_URL		:= https://github.com/timescale/timescaledb/archive/$(TIMESCALEDB_VERSION).$(TIMESCALEDB_SUFFIX)
TIMESCALEDB_SOURCE	:= $(SRCDIR)/$(TIMESCALEDB).$(TIMESCALEDB_SUFFIX)
TIMESCALEDB_DIR		:= $(BUILDDIR)/$(TIMESCALEDB)
TIMESCALEDB_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
TIMESCALEDB_CONF_TOOL	:= cmake
TIMESCALEDB_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DCMAKE_PROGRAM_PATH="$(PTXDIST_SYSROOT_HOST)" \
	-DGIT_EXECUTABLE=false \
	-DPG_BINDIR="/usr/bin" \
	-DPG_INCLUDEDIR="$(PTXDIST_SYSROOT_TARGET)/usr/include" \
	-DPG_INCLUDEDIR_SERVER="$(PTXDIST_SYSROOT_TARGET)/usr/include/postgresql/server" \
	-DPG_LIBDIR="$(PTXDIST_SYSROOT_TARGET)/usr/lib" \
	-DPG_PKGLIBDIR="/usr/lib/postgresql" \
	-DPG_SHAREDIR="/usr/share/postgresql" \
	-DAPACHE_ONLY=1 \
	-DREGRESS_CHECKS=0 \
	-DSEND_TELEMETRY_DEFAULT=0 \
	-DUSE_OPENSSL=0

# -DAPACHE_ONLY=1             is needed to build a free/libre version
#                             of TimescaleDB.
# -DREGRESS_CHECKS=0          disables isolation regress checks,
#                             which need pg_regress.
# -DSEND_TELEMETRY_DEFAULT=0  disables calling home.
# -DUSE_OPENSSL=0             disables OpenSSL.

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/timescaledb.targetinstall:
	@$(call targetinfo)

	@$(call install_init, timescaledb)
	@$(call install_fixup, timescaledb,PRIORITY,optional)
	@$(call install_fixup, timescaledb,SECTION,base)
	@$(call install_fixup, timescaledb,AUTHOR,"Bjoern Esser <bes@pengutronix.de>")
	@$(call install_fixup, timescaledb,DESCRIPTION,missing)

	@$(call install_tree, timescaledb, 0, 0, -, /usr/lib/postgresql)
	@$(call install_tree, timescaledb, 0, 0, -, /usr/share/postgresql)

	@$(call install_finish, timescaledb)

	@$(call touch)

# vim: syntax=make
