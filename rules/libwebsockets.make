# -*-makefile-*-
#
# Copyright (C) 2024 by Ian Abbott <abbotti@mev.co.uk>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBWEBSOCKETS) += libwebsockets

#
# Paths and names
#
LIBWEBSOCKETS_VERSION		:= 4.4.1
LIBWEBSOCKETS_MD5		:= 4930ef82adc24b7912a8bb729f4a7df9
LIBWEBSOCKETS			:= libwebsockets-$(LIBWEBSOCKETS_VERSION)
LIBWEBSOCKETS_SUFFIX		:= tar.gz
LIBWEBSOCKETS_URL		:= https://github.com/warmcat/libwebsockets/archive/refs/tags/v$(LIBWEBSOCKETS_VERSION).$(LIBWEBSOCKETS_SUFFIX)
LIBWEBSOCKETS_SOURCE		:= $(SRCDIR)/$(LIBWEBSOCKETS).$(LIBWEBSOCKETS_SUFFIX)
LIBWEBSOCKETS_DIR		:= $(BUILDDIR)/$(LIBWEBSOCKETS)
LIBWEBSOCKETS_LICENSE		:= MIT AND BSD-2-Clause AND BSD-3-Clause
LIBWEBSOCKETS_LICENSE_FILES	:= file://LICENSE;md5=b5d391cc7929bcba238f9ba6805f7574

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
LIBWEBSOCKETS_CONF_TOOL	:= cmake
LIBWEBSOCKETS_CONF_OPT	:=  \
	$(CROSS_CMAKE_USR) \
	-DBUILD_TESTING=OFF \
	-DDISABLE_WERROR=ON \
	-DLWS_CTEST_INTERNET_AVAILABLE=OFF \
	-DLWS_IPV6=$(call ptx/onoff, PTXCONF_GLOBAL_IPV6) \
	-DLWS_LINK_TESTAPPS_DYNAMIC=ON \
	-DLWS_PLAT_ANDROID=OFF \
	-DLWS_PLAT_BAREMETAL=OFF \
	-DLWS_PLAT_FREERTOS=OFF \
	-DLWS_PLAT_OPTEE=OFF \
	-DLWS_ROLE_DBUS=OFF \
	-DLWS_ROLE_H1=ON \
	-DLWS_ROLE_MQTT=OFF \
	-DLWS_ROLE_RAW_FILE=$(call ptx/onoff, PTXCONF_LIBWEBSOCKETS_ROLE_RAW_FILE) \
	-DLWS_ROLE_RAW_PROXY=OFF \
	-DLWS_ROLE_WS=$(call ptx/onoff, PTXCONF_LIBWEBSOCKETS_ROLE_WS) \
	-DLWS_WITHOUT_DAEMONIZE=OFF \
	-DLWS_WITHOUT_EXTENSIONS=OFF \
	-DLWS_WITHOUT_TESTAPPS=ON \
	-DLWS_WITHOUT_TEST_CLIENT=ON \
	-DLWS_WITHOUT_TEST_PING=ON \
	-DLWS_WITHOUT_TEST_SERVER=ON \
	-DLWS_WITHOUT_TEST_SERVER_EXTPOLL=ON \
	-DLWS_WITH_ASAN=OFF \
	-DLWS_WITH_BORINGSSL=OFF \
	-DLWS_WITH_BUNDLED_ZLIB=OFF \
	-DLWS_WITH_CYASSL=OFF \
	-DLWS_WITH_DLO=OFF \
	-DLWS_WITH_EXTERNAL_POLL=ON \
	-DLWS_WITH_GLIB=$(call ptx/onoff, PTXCONF_LIBWEBSOCKETS_GLIB) \
	-DLWS_WITH_GZINFLATE=OFF \
	-DLWS_WITH_HTTP2=$(call ptx/onoff, PTXCONF_LIBWEBSOCKETS_ROLE_H2) \
	-DLWS_WITH_JPEG=OFF \
	-DLWS_WITH_JSONRPC=OFF \
	-DLWS_WITH_LHP=OFF \
	-DLWS_WITH_LIBCAP=ON \
	-DLWS_WITH_LIBEV=$(call ptx/onoff, PTXCONF_LIBWEBSOCKETS_LIBEV) \
	-DLWS_WITH_LIBEVENT=$(call ptx/onoff, PTXCONF_LIBWEBSOCKETS_LIBEVENT) \
	-DLWS_WITH_LIBUV=$(call ptx/onoff, PTXCONF_LIBWEBSOCKETS_LIBUV) \
	-DLWS_WITH_MBEDTLS=OFF \
	-DLWS_WITH_MINIMAL_EXAMPLES=OFF \
	-DLWS_WITH_OTA=OFF \
	-DLWS_WITH_SECURE_STREAMS=OFF \
	-DLWS_WITH_SHARED=ON \
	-DLWS_WITH_SSL=$(call ptx/onoff, PTXCONF_LIBWEBSOCKETS_TLS) \
	-DLWS_WITH_STATIC=OFF \
	-DLWS_WITH_UPNG=OFF \
	-DLWS_WITH_WOL=OFF \
	-DLWS_WITH_WOLFSSL=OFF \
	-DLWS_WITH_ZLIB=ON

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libwebsockets.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libwebsockets)
	@$(call install_fixup, libwebsockets,PRIORITY,optional)
	@$(call install_fixup, libwebsockets,SECTION,base)
	@$(call install_fixup, libwebsockets,AUTHOR,"Ian Abbott <abbotti@mev.co.uk>")
	@$(call install_fixup, libwebsockets,DESCRIPTION,missing)

#	libraries
	@$(call install_lib, libwebsockets, 0, 0, 0644, libwebsockets)

#	plug-in libraries
ifdef PTXCONF_LIBWEBSOCKETS_LIBEV
	@$(call install_lib, libwebsockets, 0, 0, 0644, libwebsockets-evlib_ev)
endif
ifdef PTXCONF_LIBWEBSOCKETS_LIBUV
	@$(call install_lib, libwebsockets, 0, 0, 0644, libwebsockets-evlib_uv)
endif
ifdef PTXCONF_LIBWEBSOCKETS_LIBEVENT
	@$(call install_lib, libwebsockets, 0, 0, 0644, libwebsockets-evlib_event)
endif
ifdef PTXCONF_LIBWEBSOCKETS_GLIB
	@$(call install_lib, libwebsockets, 0, 0, 0644, libwebsockets-evlib_glib)
endif

	@$(call install_finish, libwebsockets)

	@$(call touch)

# vim: syntax=make
