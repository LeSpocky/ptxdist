# -*-makefile-*-
#
# Copyright (C) 2006, 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2016 by Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBELF) += libelf

#
# Paths and names
#
LIBELF_VERSION	:= 0.190
LIBELF_MD5	:= 79ad698e61a052bea79e77df6a08bc4b
LIBELF		:= elfutils-$(LIBELF_VERSION)
LIBELF_SUFFIX	:= tar.bz2
LIBELF_URL	:= https://sourceware.org/elfutils/ftp/$(LIBELF_VERSION)/$(LIBELF).$(LIBELF_SUFFIX)
LIBELF_SOURCE	:= $(SRCDIR)/$(LIBELF).$(LIBELF_SUFFIX)
LIBELF_DIR	:= $(BUILDDIR)/$(LIBELF)
LIBELF_LICENSE	:= (LGPL-3.0-or-later OR GPL-2.0-or-later) AND GPL-3.0-or-later
LIBELF_LICENSE_FILES := \
	file://src/addr2line.c;startline=1;endline=18;md5=d710f0305026e2699ec622ec521f9d79 \
	file://COPYING;md5=d32239bcb673463ab874e80d47fae504 \
	file://lib/color.c;startline=1;endline=28;md5=b960585bfffbf9f0df5b8f1af733a03b \
	file://COPYING-GPLV2;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
	file://COPYING-LGPLV3;md5=e6a600fd5e1d9cbde2d983680233ad02

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBELF_CONF_TOOL := autoconf
LIBELF_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-deterministic-archives \
	--disable-thread-safety \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-debugpred \
	--disable-gprof \
	--disable-gcov \
	--disable-sanitize-undefined \
	--disable-valgrind \
	--disable-valgrind-annotations \
	--disable-install-elfh \
	--disable-tests-rpath \
	--enable-demangler \
	--enable-textrelcheck \
	--enable-symbol-versioning \
	--disable-nls \
	--disable-rpath \
	--disable-libdebuginfod \
	--disable-debuginfod \
	--with-zlib \
	--without-bzlib \
	--$(call ptx/wwo, PTXCONF_LIBELF_XZ)-lzma \
	--without-zstd \
	--without-biarch

LIBELF_ARCH := $(call remove_quotes,$(PTXCONF_ARCH_STRING))
ifdef PTXCONF_ARCH_ARM64
LIBELF_ARCH := aarch64
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libelf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libelf)
	@$(call install_fixup, libelf,PRIORITY,optional)
	@$(call install_fixup, libelf,SECTION,base)
	@$(call install_fixup, libelf,AUTHOR,"Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>")
	@$(call install_fixup, libelf,DESCRIPTION,missing)

	@$(call install_lib, libelf, 0, 0, 0644, libelf-$(LIBELF_VERSION))

ifdef PTXCONF_LIBELF_LIBDW
	@$(call install_lib, libelf, 0, 0, 0644, libdw-$(LIBELF_VERSION))
endif

ifdef PTXCONF_LIBELF_LIBASM
	@$(call install_lib, libelf, 0, 0, 0644, libasm-$(LIBELF_VERSION))
endif

ifdef PTXCONF_LIBELF_ELFSUTILS
	@$(foreach bin, addr2line ar elfcmp elfcompress elflint findtextrel \
		make-debug-archive nm objdump ranlib readelf size stack strings \
		strip unstrip, \
		$(call install_copy, libelf, 0, 0, 0755, -, \
			/usr/bin/eu-$(bin))$(ptx/nl))
endif

	@$(call install_finish, libelf)

	@$(call touch)

# vim: syntax=make
