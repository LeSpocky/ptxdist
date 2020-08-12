# -*-makefile-*-
#
# Copyright (C) 2019 by Florian Faber <faber@faberman.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ZSTD) += zstd

#
# Paths and names
#
ZSTD_VERSION	:= 1.4.4
ZSTD_MD5	:= 532aa7b3a873e144bbbedd9c0ea87694
ZSTD		:= zstd-$(ZSTD_VERSION)
ZSTD_SUFFIX	:= tar.gz
ZSTD_URL	:= https://github.com/facebook/zstd/archive/v$(ZSTD_VERSION).$(ZSTD_SUFFIX)
ZSTD_SOURCE	:= $(SRCDIR)/$(ZSTD).$(ZSTD_SUFFIX)
ZSTD_DIR	:= $(BUILDDIR)/$(ZSTD)
ZSTD_SUBDIR	:= build/cmake
ZSTD_LICENSE	:= BSD-3-clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ZSTD_CONF_TOOL	:= cmake
ZSTD_BUILD_DIR	:= $(ZSTD_DIR)-build
ZSTD_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-B$(ZSTD_BUILD_DIR) \
	-DZSTD_LEGACY_SUPPORT=OFF \
	-DZSTD_MULTITHREAD_SUPPORT=ON \
	-DZSTD_BUILD_PROGRAMS=ON \
	-DZSTD_BUILD_CONTRIB=OFF \
	-DZSTD_BUILD_TESTS=OFF \
	-DZSTD_USE_STATIC_RUNTIME=OFF \
	-DZSTD_PROGRAMS_LINK_SHARED=ON \
	-DZSTD_BUILD_STATIC=ON \
	-DZSTD_BUILD_SHARED=ON \
	-DZSTD_ZLIB_SUPPORT=OFF \
	-DZSTD_LZMA_SUPPORT=OFF \
	-DZSTD_LZ4_SUPPORT=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/zstd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, zstd)
	@$(call install_fixup, zstd, PRIORITY, optional)
	@$(call install_fixup, zstd, SECTION, base)
	@$(call install_fixup, zstd, AUTHOR, "Florian Faber <faber@faberman.de>")
	@$(call install_fixup, zstd, DESCRIPTION, missing)

	@$(call install_lib, zstd, 0, 0, 0644, libzstd)

ifdef PTXCONF_ZSTD_ZSTD
	@$(call install_copy, zstd, 0, 0, 0755, -, /usr/bin/zstd)
	@$(call install_link, zstd, zstd, /usr/bin/zstdcat)
	@$(call install_link, zstd, zstd, /usr/bin/zstdmt)
	@$(call install_link, zstd, zstd, /usr/bin/unzstd)
endif
ifdef PTXCONF_ZSTD_ZSTDGREP
	@$(call install_copy, zstd, 0, 0, 0755, -, /usr/bin/zstdgrep)
endif
ifdef PTXCONF_ZSTD_ZSTDLESS
	@$(call install_copy, zstd, 0, 0, 0755, -, /usr/bin/zstdless)
endif

	@$(call install_finish, zstd)

	@$(call touch)

# vim: syntax=make
