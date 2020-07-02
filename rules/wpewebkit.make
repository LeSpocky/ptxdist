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
WPEWEBKIT_VERSION	:= 2.28.2
WPEWEBKIT_MD5		:= c1f17d4b031e9462692443e3c089789c
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
	-DDEBUG_FISSION=OFF \
	-DENABLE_ACCELERATED_2D_CANVAS=ON \
	-DENABLE_ACCESSIBILITY=OFF \
	-DENABLE_BUBBLEWRAP_SANDBOX=OFF \
	-DENABLE_ENCRYPTED_MEDIA=OFF \
	-DENABLE_GTKDOC=OFF\
	-DENABLE_MEDIA_SOURCE=ON \
	-DENABLE_SHAREABLE_RESOURCE=ON \
	-DENABLE_VIDEO=ON \
	-DENABLE_WEBDRIVER=ON \
	-DENABLE_WEB_AUDIO=ON \
	-DENABLE_WEB_CRYPTO=ON \
	-DENABLE_WPE_QT_API=$(call ptx/onoff,PTXCONF_WPEWEBKIT_QT) \
	-DENABLE_XSLT=ON \
	-DPORT=WPE \
	-DSHOULD_INSTALL_JS_SHELL=OFF \
	-DSHOW_BINDINGS_GENERATION_PROGRESS=ON \
	-DUSE_LD_GOLD=OFF \
	-DUSE_OPENJPEG=OFF \
	-DUSE_THIN_ARCHIVES=ON \
	-DUSE_WOFF2=OFF \
	-DWTF_CPU_ARM64_CORTEXA53=OFF

# private options
WPEWEBKIT_CONF_OPT	+= \
	-DENABLE_REMOTE_INSPECTOR=ON

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

	@$(call install_finish, wpewebkit)

	@$(call touch)

# vim: syntax=make
