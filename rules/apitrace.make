# -*-makefile-*-
#
# Copyright (C) 2020 by Michael Tretter <m.tretter@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_APITRACE) += apitrace

#
# Paths and names
#
APITRACE_VERSION	:= 13.0
APITRACE_MD5		:= 6adbb46c84361511d4954875ff045e28
APITRACE		:= apitrace-$(APITRACE_VERSION)
APITRACE_SUFFIX		:= tar.gz
APITRACE_URL		:= https://github.com/apitrace/apitrace/archive/$(APITRACE_VERSION).$(APITRACE_SUFFIX)
APITRACE_SOURCE		:= $(SRCDIR)/$(APITRACE).$(APITRACE_SUFFIX)
APITRACE_DIR		:= $(BUILDDIR)/$(APITRACE)
APITRACE_LICENSE	:= MIT AND BSD-3-Clause
APITRACE_LICENSE_FILES	:= \
	file://LICENSE;md5=aeb969185a143c3c25130bc2c3ef9a50

APITRACE_BACKTRACE_VERSION	:= 2022-09-22-g8602fda64e78
APITRACE_BACKTRACE_MD5		:= e69451fcbc31d5c96439e1abc8b3129d
APITRACE_BACKTRACE		:= apitrace-backtrace-$(APITRACE_BACKTRACE_VERSION)
APITRACE_BACKTRACE_SUFFIX	:= tar.gz
APITRACE_BACKTRACE_URL		:= https://github.com/ianlancetaylor/libbacktrace/archive/$(APITRACE_BACKTRACE_VERSION).$(APITRACE_BACKTRACE_SUFFIX)
APITRACE_BACKTRACE_SOURCE	:= $(SRCDIR)/$(APITRACE_BACKTRACE).$(APITRACE_BACKTRACE_SUFFIX)
APITRACE_BACKTRACE_DIR		:= $(APITRACE_DIR)/thirdparty/libbacktrace
APITRACE_LICENSE_FILES		+= \
	file://thirdparty/libbacktrace/LICENSE;md5=24b5b3feec63c4be0975e1fea5100440

APITRACE_SNAPPY_VERSION		:= 2022-09-26-g2b63814b15a2
APITRACE_SNAPPY_MD5		:= 5177d6bef0eccc7c78e9e27b9d5b761c
APITRACE_SNAPPY			:= apitrace-snappy-$(APITRACE_SNAPPY_VERSION)
APITRACE_SNAPPY_SUFFIX		:= tar.gz
APITRACE_SNAPPY_URL		:= https://github.com/google/snappy/archive/$(APITRACE_SNAPPY_VERSION).$(APITRACE_SNAPPY_SUFFIX)
APITRACE_SNAPPY_SOURCE		:= $(SRCDIR)/$(APITRACE_SNAPPY).$(APITRACE_SNAPPY_SUFFIX)
APITRACE_SNAPPY_DIR		:= $(APITRACE_DIR)/thirdparty/snappy
APITRACE_LICENSE_FILES		+= \
	file://thirdparty/snappy/COPYING;md5=f62f3080324a97b3159a7a7e61812d0c

APITRACE_PARTS			+= APITRACE_BACKTRACE APITRACE_SNAPPY

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

APITRACE_CONF_TOOL	:= cmake
APITRACE_CONF_OPT	:=  \
	$(CROSS_CMAKE_USR) \
	-G Ninja \
	-DWRAPPER_INSTALL_DIR=/usr/lib/apitrace/wrappers \
	-DBUILD_TESTING=OFF \
	-DENABLE_ASAN=OFF \
	-DENABLE_CLI=ON \
	-DENABLE_EGL=ON \
	-DENABLE_FRAME_POINTER=ON \
	-DENABLE_GLTRIM_TESTS=OFF \
	-DENABLE_GUI=OFF \
	-DENABLE_SSE42=OFF \
	-DENABLE_STATIC_EXE=OFF \
	-DENABLE_STATIC_LIBGCC=OFF \
	-DENABLE_STATIC_LIBSTDCXX=OFF \
	-DENABLE_STATIC_SNAPPY=SNAPPY \
	-DENABLE_TESTS=OFF \
	-DENABLE_WAFFLE=OFF \
	-DENABLE_X11=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/apitrace.targetinstall:
	@$(call targetinfo)

	@$(call install_init, apitrace)
	@$(call install_fixup, apitrace,PRIORITY,optional)
	@$(call install_fixup, apitrace,SECTION,base)
	@$(call install_fixup, apitrace,AUTHOR,"Michael Tretter <m.tretter@pengutronix.de>")
	@$(call install_fixup, apitrace,DESCRIPTION,missing)

	@$(call install_copy, apitrace, 0, 0, 0755, -, /usr/bin/apitrace)

	@$(call install_lib, apitrace, 0, 0, 0644, apitrace/wrappers/egltrace)

	@$(call install_finish, apitrace)

	@$(call touch)

# vim: syntax=make
