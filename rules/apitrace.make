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
APITRACE_VERSION	:= 9.0
APITRACE_MD5		:= 83bacfb35f4f339571702099d283f571
APITRACE		:= apitrace-$(APITRACE_VERSION)
APITRACE_SUFFIX		:= tar.gz
APITRACE_URL		:= https://github.com/apitrace/apitrace/archive/$(APITRACE_VERSION).$(APITRACE_SUFFIX)
APITRACE_SOURCE		:= $(SRCDIR)/$(APITRACE).$(APITRACE_SUFFIX)
APITRACE_DIR		:= $(BUILDDIR)/$(APITRACE)
APITRACE_LICENSE	:= MIT AND BSD-3-CLAUSE
APITRACE_LICENSE_FILES	:= file://LICENSE;md5=aeb969185a143c3c25130bc2c3ef9a50 \
			   file://thirdparty/snappy/COPYING;md5=f62f3080324a97b3159a7a7e61812d0c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

APITRACE_CONF_TOOL	:= cmake
APITRACE_CONF_OPT	:=  \
	$(CROSS_CMAKE_USR) \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_LIBDIR=/usr/lib \
	-DENABLE_ASAN=OFF \
	-DENABLE_CLI=ON \
	-DENABLE_EGL=ON \
	-DENABLE_FRAME_POINTER=ON \
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
