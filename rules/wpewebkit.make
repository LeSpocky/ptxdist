# -*-makefile-*-
#
# Copyright (C) 2018 by Steffen Trumtrar <s.trumtrar@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WPEWEBKIT) += wpewebkit

#
# Paths and names
#
WPEWEBKIT_VERSION	:= 2.34.4
WPEWEBKIT_MD5		:= b0f7dcb18acfa94cfb42fea0fe10fb0d
WPEWEBKIT		:= wpewebkit-$(WPEWEBKIT_VERSION)
WPEWEBKIT_SUFFIX	:= tar.xz
WPEWEBKIT_URL		:= https://wpewebkit.org/releases/$(WPEWEBKIT).$(WPEWEBKIT_SUFFIX)
WPEWEBKIT_SOURCE	:= $(SRCDIR)/$(WPEWEBKIT).$(WPEWEBKIT_SUFFIX)
WPEWEBKIT_DIR		:= $(BUILDDIR)/$(WPEWEBKIT)
WPEWEBKIT_LICENSE	:= BSD-2-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
WPEWEBKIT_CONF_TOOL	:= cmake
WPEWEBKIT_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-G Ninja \
	-DCMAKE_BUILD_TYPE=Release \
	-DANALYZERS=OFF \
	-DDEBUG_FISSION=OFF \
	-DENABLE_ACCESSIBILITY=OFF \
	-DENABLE_BUBBLEWRAP_SANDBOX=OFF \
	-DENABLE_ENCRYPTED_MEDIA=OFF \
	-DENABLE_GTKDOC=OFF\
	-DENABLE_MEDIA_SOURCE=ON \
	-DENABLE_VIDEO=$(call ptx/onoff,PTXCONF_WPEWEBKIT_VIDEO) \
	-DENABLE_WEBDRIVER=$(call ptx/onoff,PTXCONF_WPEWEBKIT_WEBDRIVER) \
	-DENABLE_WEB_AUDIO=$(call ptx/onoff,PTXCONF_WPEWEBKIT_AUDIO) \ \
	-DENABLE_WEB_CRYPTO=ON \
	-DENABLE_WPE_QT_API=$(call ptx/onoff,PTXCONF_WPEWEBKIT_QT) \
	-DENABLE_XSLT=ON \
	-DGCC_OFFLINEASM_SOURCE_MAP=OFF \
	-DPORT=WPE \
	-DSHOULD_INSTALL_JS_SHELL=OFF \
	-DSHOW_BINDINGS_GENERATION_PROGRESS=ON \
	-DUSE_LD_GOLD=OFF \
	-DUSE_APPLE_ICU=OFF \
	-DUSE_LCMS=OFF \
	-DUSE_OPENJPEG=OFF \
	-DUSE_SOUP2=ON \
	-DUSE_SYSTEMD=$(call ptx/onoff,PTXCONF_WPEWEBKIT_JOURNALD) \
	-DUSE_THIN_ARCHIVES=ON \
	-DUSE_WOFF2=OFF \
	-DWTF_CPU_ARM64_CORTEXA53=OFF

WPEWEBKIT_SYSTEM_MALLOC := OFF
ifdef PTXCONF_WPEWEBKIT_QT
ifdef PTXCONF_ARCH_ARM64
WPEWEBKIT_SYSTEM_MALLOC := ON
endif
ifdef PTXCONF_ARCH_X86_64
WPEWEBKIT_SYSTEM_MALLOC := ON
endif
endif

# private options
WPEWEBKIT_CONF_OPT	+= \
	-DENABLE_REMOTE_INSPECTOR=ON \
	-DUSE_SYSTEM_MALLOC=$(WPEWEBKIT_SYSTEM_MALLOC)

ifdef PTXCONF_WPEWEBKIT_ENABLE_LOGGING
WPEWEBKIT_CXXFLAGS	:= -DLOG_DISABLED=0
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wpewebkit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, wpewebkit)
	@$(call install_fixup, wpewebkit,PRIORITY,optional)
	@$(call install_fixup, wpewebkit,SECTION,base)
	@$(call install_fixup, wpewebkit,AUTHOR,"Steffen Trumtrar <s.trumtrar@pengutronix.de>")
	@$(call install_fixup, wpewebkit,DESCRIPTION,missing)

	@$(call install_lib, wpewebkit, 0, 0, 0644, libWPEWebKit-1.0)

	@$(call install_tree, wpewebkit, 0, 0, -, /usr/libexec/wpe-webkit-1.0)
	@$(call install_tree, wpewebkit, 0, 0, -, /usr/lib/wpe-webkit-1.0)

ifdef PTXCONF_WPEWEBKIT_QT
	@$(call install_tree, wpewebkit, 0, 0, -, /usr/lib/qt5/qml/org/wpewebkit)
endif

ifdef PTXCONF_WPEWEBKIT_WEBDRIVER
	@$(call install_copy, wpewebkit, 0, 0, 0755, -, /usr/bin/WPEWebDriver)
endif

	@$(call install_finish, wpewebkit)

	@$(call touch)

# vim: syntax=make
