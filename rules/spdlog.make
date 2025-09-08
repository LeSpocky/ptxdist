# -*-makefile-*-
#
# Copyright (C) 2025 by Lars Pedersen <lapeddk@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SPDLOG) += spdlog

#
# Paths and names
#
SPDLOG_VERSION		:= 1.15.3
SPDLOG_MD5		:= fffda902bb4a04ce814ddd5328d95e8a
SPDLOG			:= spdlog-$(SPDLOG_VERSION)
SPDLOG_SUFFIX		:= tar.gz
SPDLOG_URL		:= https://github.com/gabime/spdlog/archive/refs/tags/v$(SPDLOG_VERSION).$(SPDLOG_SUFFIX)
SPDLOG_SOURCE		:= $(SRCDIR)/$(SPDLOG).$(SPDLOG_SUFFIX)
SPDLOG_DIR		:= $(BUILDDIR)/$(SPDLOG)
SPDLOG_LICENSE		:= MIT
SPDLOG_LICENSE_FILES	:= file://LICENSE;md5=9573510928429ad0cbe5ba4de77546e9

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
SPDLOG_CONF_TOOL	:= cmake
SPDLOG_CONF_OPT	:=  \
	$(CROSS_CMAKE_USR) \
	-DSPDLOG_BUILD_ALL:BOOL=OFF \
	-DSPDLOG_BUILD_BENCH:BOOL=OFF \
	-DSPDLOG_BUILD_EXAMPLE:BOOL=OFF \
	-DSPDLOG_BUILD_EXAMPLE_HO:BOOL=OFF \
	-DSPDLOG_BUILD_PIC:BOOL=ON \
	-DSPDLOG_BUILD_SHARED:BOOL=ON \
	-DSPDLOG_BUILD_TESTS:BOOL=OFF \
	-DSPDLOG_BUILD_TESTS_HO:BOOL=OFF \
	-DSPDLOG_BUILD_WARNINGS:BOOL=OFF \
	-DSPDLOG_CLOCK_COARSE:BOOL=OFF \
	-DSPDLOG_DISABLE_DEFAULT_LOGGER:BOOL=OFF \
	-DSPDLOG_ENABLE_PCH:BOOL=OFF \
	-DSPDLOG_FMT_EXTERNAL:BOOL=ON \
	-DSPDLOG_FMT_EXTERNAL_HO:BOOL=OFF \
	-DSPDLOG_FWRITE_UNLOCKED:BOOL=ON \
	-DSPDLOG_INSTALL:BOOL=ON \
	-DSPDLOG_NO_ATOMIC_LEVELS:BOOL=OFF \
	-DSPDLOG_NO_EXCEPTIONS:BOOL=OFF \
	-DSPDLOG_NO_THREAD_ID:BOOL=OFF \
	-DSPDLOG_NO_TLS:BOOL=OFF \
	-DSPDLOG_PREVENT_CHILD_FD:BOOL=OFF \
	-DSPDLOG_SANITIZE_ADDRESS:BOOL=OFF \
	-DSPDLOG_SANITIZE_THREAD:BOOL=OFF \
	-DSPDLOG_SYSTEM_INCLUDES:BOOL=OFF \
	-DSPDLOG_TIDY:BOOL=OFF \
	-DSPDLOG_USE_STD_FORMAT:BOOL=OFF \
	-DSPDLOG_WCHAR_CONSOLE:BOOL=OFF \
	-DSPDLOG_WCHAR_FILENAMES:BOOL=OFF \
	-DSPDLOG_WCHAR_SUPPORT:BOOL=OFF


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/spdlog.targetinstall:
	@$(call targetinfo)

	@$(call install_init, spdlog)
	@$(call install_fixup, spdlog,PRIORITY,optional)
	@$(call install_fixup, spdlog,SECTION,base)
	@$(call install_fixup, spdlog,AUTHOR,"Lars Pedersen <lapeddk@gmail.com>")
	@$(call install_fixup, spdlog,DESCRIPTION,missing)

	@$(call install_lib, spdlog, 0, 0, 0644, libspdlog)

	@$(call install_finish, spdlog)

	@$(call touch)

# vim: ft=make
