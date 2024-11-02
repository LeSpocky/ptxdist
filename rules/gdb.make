# -*-makefile-*-
#
# Copyright (C) 2002-2008 by Pengutronix e.K., Hildesheim, Germany
#               2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
#               2009, 2012 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GDB) += gdb

#
# Paths and names
#
GDB_VERSION	 = $(call ptx/config-version,PTXCONF_GDB,SHARED_GDB)
GDB_MD5		 = $(call ptx/config-md5,PTXCONF_GDB,SHARED_GDB)
GDB		:= gdb-$(GDB_VERSION)
GDB_SUFFIX	:= tar.xz
GDB_SOURCE	:= $(SRCDIR)/$(GDB).$(GDB_SUFFIX)
GDB_DIR		:= $(BUILDDIR)/$(GDB)
GDB_LICENSE	:= GPL-3.0-or-later

GDB_URL := \
	$(call ptx/mirror, GNU, gdb/$(GDB).$(GDB_SUFFIX)) \
	https://sourceware.org/pub/gdb/snapshots/current/$(GDB).$(GDB_SUFFIX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ifdef PTXCONF_ARCH_X86
GDB_WRAPPER_BLACKLIST := \
	TARGET_HARDEN_PIE
endif

GDB_CONF_OPT_HOST	:= \
	--disable-tui \
	--disable-rpath \
	--with-lzma=$(call ptx/yesno, PTXCONF_GDB_DEBUGINFO_SUPPORT) \
	--without-expat \
	--without-mpfr \
	--without-python

ifneq ($(filter 1%,$(GDB_VERSION)),)
# version >= 10
GDB_CONF_OPT_HOST	+= \
	--without-xxhash
endif

GDB_CONF_ENV		:= \
	$(CROSS_ENV) \
	$(CROSS_ENV_FLAGS_FOR_TARGET) \
	host_configargs='$(GDB_CONF_OPT_HOST)'

ifndef PTXCONF_GDB_SHARED
GDB_MAKE_OPT := LDFLAGS=-static
endif

#
# autoconf
#
GDB_CONF_TOOL		:= autoconf
GDB_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--target=$(PTXCONF_GNU_TARGET) \
	--with-build-sysroot=$(SYSROOT) \
	--disable-werror \
	--with-system-zlib \
	$(call ptx/ifdef, PTXCONF_GDB_14_1,--$(call ptx/wwo, PTXCONF_GDB_ZSTD)-zstd,)

GDB_BUILD_OOT := YES

# for gdb subdir configure
GDB_MAKE_ENV		:= \
	with_libgmp_prefix=no \
	with_liblzma_prefix=no

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gdb.install:
	@$(call targetinfo)
	@$(call world/install, GDB)
#	# don't install static libraries to sysroot
	@rm -rf $(GDB_PKGDIR)/usr/lib
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gdb.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gdb)
	@$(call install_fixup, gdb,PRIORITY,optional)
	@$(call install_fixup, gdb,SECTION,base)
	@$(call install_fixup, gdb,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gdb,DESCRIPTION,missing)

	@$(call install_copy, gdb, 0, 0, 0755, -, /usr/bin/gdb)

	@$(call install_finish, gdb)
	@$(call touch)

# vim: syntax=make
