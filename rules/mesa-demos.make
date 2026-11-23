# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MESA_DEMOS) += mesa-demos

#
# Paths and names
#
MESA_DEMOS_VERSION	:= 9.0.0
MESA_DEMOS_SHA256	:= 3046a3d26a7b051af7ebdd257a5f23bfeb160cad6ed952329cdff1e9f1ed496b
MESA_DEMOS		:= mesa-demos-$(MESA_DEMOS_VERSION)
MESA_DEMOS_SUFFIX	:= tar.xz
MESA_DEMOS_URL		:= https://archive.mesa3d.org/demos/$(MESA_DEMOS).$(MESA_DEMOS_SUFFIX)
MESA_DEMOS_SOURCE	:= $(SRCDIR)/$(MESA_DEMOS).$(MESA_DEMOS_SUFFIX)
MESA_DEMOS_DIR		:= $(BUILDDIR)/$(MESA_DEMOS)
MESA_DEMOS_LICENSE	:= MIT AND HPND AND public_domain
MESA_DEMOS_LICENSE_FILES := \
	file://meson.build;startline=1;endline=19;md5=9eae7bd52d37dcb8c051da83f7477fb0 \
	file://src/xdemos/glxinfo.c;startline=1;endline=20;md5=528e51cb8d683b1271806b7dce9b28d3 \
	file://src/xdemos/offset.c;startline=1;endline=22;md5=4c341ae36bce909d84e28fbe50c4f516

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
MESA_DEMOS_CONF_TOOL	:= meson
MESA_DEMOS_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Degl=$(call ptx/endis, PTXCONF_MESA_DEMOS_EGL)d \
	-Dgles1=disabled \
	-Dgles2=$(call ptx/endis, PTXCONF_MESA_DEMOS_GLES2)d \
	-Dglut=disabled \
	-Dlibdrm=disabled \
	-Dosmesa=disabled \
	-Dvulkan=disabled \
	-Dwayland=$(call ptx/endis, PTXCONF_MESA_DEMOS_WAYLAND)d \
	-Dwith-glut= \
	-Dwith-system-data-files=false \
	-Dx11=$(call ptx/endis, PTXCONF_MESA_DEMOS_X11)d

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLSYNC)		+= glsync
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLTHREADS)		+= glthreads
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXCONTEXTS)	+= glxcontexts
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXDEMO)		+= glxdemo
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXGEARS)		+= glxgears
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXGEARS_FBCONFIG)	+= glxgears_fbconfig
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXGEARS_PIXMAP)	+= glxgears_pixmap
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXHEADS)		+= glxheads
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXINFO)		+= glxinfo
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXPBDEMO)		+= glxpbdemo
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXPIXMAP)		+= glxpixmap
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXSNOOP)		+= glxsnoop
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_GLXSWAPCONTROL)	+= glxswapcontrol
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_MANYWIN)		+= manywin
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_MULTICTX)		+= multictx
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_OFFSET)		+= offset
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_OVERLAY)		+= overlay
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_PBDEMO)		+= pbdemo
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_PBINFO)		+= pbinfo
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_SHAPE)		+= shape
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_SHAREDTEX)		+= sharedtex
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_SHAREDTEX_MT)	+= sharedtex_mt
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_TEXTURE_FROM_PIXMAP)+= texture_from_pixmap
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_WINCOPY)		+= wincopy
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_XFONT)		+= xfont
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_XROTFONTDEMO)	+= xrotfontdemo
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_ES2_INFO)		+= es2_info
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_ES2GEARS_WAYLAND)	+= es2gears_wayland
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_ES2GEARS_X11)	+= es2gears_x11
MESA_DEMOS_BIN-$(PTXCONF_MESA_DEMOS_ES2TRI)		+= es2tri

$(STATEDIR)/mesa-demos.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mesa-demos)
	@$(call install_fixup, mesa-demos,PRIORITY,optional)
	@$(call install_fixup, mesa-demos,SECTION,base)
	@$(call install_fixup, mesa-demos,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, mesa-demos,DESCRIPTION,missing)

	@$(foreach bin, $(MESA_DEMOS_BIN-y), \
		$(call install_copy, mesa-demos, 0, 0, 0755, -, \
			/usr/bin/$(bin))$(ptx/nl))

	@$(call install_finish, mesa-demos)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

#$(STATEDIR)/mesa-demos.clean:
#	@$(call targetinfo)
#	@$(call clean_pkg, MESA_DEMOS)

# vim: syntax=make
