# -*-makefile-*-
#
# Copyright (C) 2023 by Alexander Dahl <ada@thorsis.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BDWGC) += bdwgc

#
# Paths and names
#
BDWGC_VERSION	:= 8.2.4
BDWGC_MD5	:= 8901a6ed29ac35842420054772ea3441
BDWGC		:= gc-$(BDWGC_VERSION)
BDWGC_SUFFIX	:= tar.gz
BDWGC_URL	:= https://github.com/ivmai/bdwgc/releases/download/v$(BDWGC_VERSION)/$(BDWGC).$(BDWGC_SUFFIX)
BDWGC_SOURCE	:= $(SRCDIR)/$(BDWGC).$(BDWGC_SUFFIX)
BDWGC_DIR	:= $(BUILDDIR)/$(BDWGC)
BDWGC_LICENSE	:= Boehm-GC
BDWGC_LICENSE_FILES := \
	file://README.QUICK;startline=1;endline=24;md5=798a33a333c0e8636ddeab552ac6090b \
	file://README.md;startline=526;endline=575;md5=71aaf0a0f29b504d185ff4e9fc1d5858

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BDWGC_CONF_TOOL	:= autoconf
BDWGC_CONF_OPT	:=  \
	$(CROSS_AUTOCONF_USR) \
	--disable-emscripten-asyncify \
	--enable-threads=posix \
	--enable-parallel-mark \
	--enable-thread-local-alloc \
	--enable-threads-discovery \
	--disable-cplusplus \
	--enable-throw-bad-alloc-library \
	--enable-gcj-support \
	--disable-sigrt-signals \
	--disable-gc-debug \
	--enable-java-finalization \
	--enable-atomic-uncollectable \
	--disable-redirect-malloc \
	--enable-disclaim \
	--disable-large-config \
	--disable-gc-assertions \
	--disable-mmap \
	--disable-munmap \
	--enable-dynamic-loading \
	--enable-register-main-static-data \
	--disable-checksums \
	--disable-werror \
	--disable-single-obj-compilation \
	--disable-gcov \
	--disable-docs \
	--enable-handle-fork \
	--without-ecos \
	--with-libatomic-ops=yes

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bdwgc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bdwgc)
	@$(call install_fixup, bdwgc,PRIORITY,optional)
	@$(call install_fixup, bdwgc,SECTION,base)
	@$(call install_fixup, bdwgc,AUTHOR,"Alexander Dahl <ada@thorsis.com>")
	@$(call install_fixup, bdwgc,DESCRIPTION,missing)

	@$(call install_lib, bdwgc, 0, 0, 0644, libcord)
	@$(call install_lib, bdwgc, 0, 0, 0644, libgc)

	@$(call install_finish, bdwgc)

	@$(call touch)

# vim: ft=make noet tw=72 ts=8 sw=8
