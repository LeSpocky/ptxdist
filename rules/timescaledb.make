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
TIMESCALEDB_VERSION	:= 1.4.2
TIMESCALEDB_MD5		:= d3c1282031bc2c5a314eb217f4a49796
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
	-DPG_BINDIR="/usr/bin" \
	-DPG_INCLUDEDIR="$(PTXDIST_SYSROOT_TARGET)/usr/include" \
	-DPG_INCLUDEDIR_SERVER="$(PTXDIST_SYSROOT_TARGET)/usr/include/postgresql/server" \
	-DPG_LIBDIR="$(PTXDIST_SYSROOT_TARGET)/usr/lib" \
	-DPG_PKGLIBDIR="/usr/lib/postgresql" \
	-DPG_SHAREDIR="/usr/share/postgresql" \
	-DUSE_OPENSSL=0 \
	-DSEND_TELEMETRY_DEFAULT=0 \
	-DAPACHE_ONLY=1 \
	-DGIT_EXECUTABLE=false

# -DAPACHE_ONLY=1   is needed to build a free/libre version of TimescaleDB.

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
