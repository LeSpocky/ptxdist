# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME, we only need the source tree, do we still need the package ?


#
# We provide this package
#
PACKAGES-$(PTXCONF_MESALIB) += mesalib

#
# Paths and names
#
MESALIB_VERSION	:= 19.0.1
MESALIB_MD5	:= 19636bb3da35c21f43040d31e575d5ce
MESALIB		:= mesa-$(MESALIB_VERSION)
MESALIB_SUFFIX	:= tar.xz
MESALIB_URL	:= \
	ftp://ftp.freedesktop.org/pub/mesa/$(MESALIB_VERSION)/$(MESALIB).$(MESALIB_SUFFIX) \
	ftp://ftp.freedesktop.org/pub/mesa/$(MESALIB).$(MESALIB_SUFFIX)
MESALIB_SOURCE	:= $(SRCDIR)/$(MESALIB).$(MESALIB_SUFFIX)
MESALIB_DIR	:= $(BUILDDIR)/Mesa-$(MESALIB_VERSION)
MESALIB_LICENSE	:= MIT
MESALIB_LICENSE_FILES := \
	file://docs/license.html;md5=725f991a1cc322aa7a0cd3a2016621c4

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ifdef PTXCONF_ARCH_X86
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_I915)		+= i915
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_I965)		+= i965
endif
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_NOUVEAU_VIEUX)+= nouveau
MESALIB_DRI_DRIVERS-$(PTXCONF_MESALIB_DRI_R200)		+= r200

MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_KMSRO)	+= kmsro
ifndef PTXCONF_ARCH_ARM # broken: https://bugs.freedesktop.org/show_bug.cgi?id=72064
ifndef PTXCONF_ARCH_X86 # needs llvm
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_R300)	+= r300
endif
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_R600)	+= r600
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_RADEONSI)	+= radeonsi
endif
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_NOUVEAU)	+= nouveau
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_FREEDRENO)+= freedreno
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_ETNAVIV)	+= etnaviv
ifdef PTXCONF_ARCH_ARM
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_V3D)	+= v3d
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_VC4)	+= vc4
endif
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_SWRAST)	+= swrast

MESALIB_DRI_LIBS-y = \
	$(subst nouveau,nouveau_vieux,$(MESALIB_DRI_DRIVERS-y))

MESALIB_DRI_GALLIUM_LIBS-y = \
	$(subst kmsro,imx-drm pl111 hx8357d,$(subst freedreno,kgsl,$(MESALIB_GALLIUM_DRIVERS-y)))

MESALIB_LIBS-y				:= libglapi
MESALIB_LIBS-$(PTXCONF_MESALIB_GLX)	+= libGL
MESALIB_LIBS-$(PTXCONF_MESALIB_GLES1)	+= libGLESv1_CM
MESALIB_LIBS-$(PTXCONF_MESALIB_GLES2)	+= libGLESv2
MESALIB_LIBS-$(PTXCONF_MESALIB_EGL)	+= libEGL
MESALIB_LIBS-$(PTXCONF_MESALIB_GBM)	+= libgbm

MESALIBS_EGL_PLATFORMS-y				:= surfaceless
MESALIBS_EGL_PLATFORMS-$(PTXCONF_MESALIB_EGL_X11)	+= x11
MESALIBS_EGL_PLATFORMS-$(PTXCONF_MESALIB_EGL_DRM)	+= drm
MESALIBS_EGL_PLATFORMS-$(PTXCONF_MESALIB_EGL_WAYLAND)	+= wayland

MESALIB_CONF_TOOL	:= meson
MESALIB_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dasm=false \
	-Dbuild-tests=false \
	-Dd3d-drivers-path=/usr/lib/d3d \
	-Ddri-drivers=$(subst $(space),$(comma),$(MESALIB_DRI_DRIVERS-y)) \
	-Ddri-drivers-path=/usr/lib/dri \
	-Ddri-search-path=/usr/lib/dri \
	-Ddri3=false \
	-Degl=$(call ptx/truefalse, PTXCONF_MESALIB_EGL) \
	-Dgallium-drivers=$(subst $(space),$(comma),$(MESALIB_GALLIUM_DRIVERS-y)) \
	-Dgallium-extra-hud=$(call ptx/truefalse, PTXCONF_MESALIB_EXTENDED_HUD) \
	-Dgallium-nine=false \
	-Dgallium-omx=disabled \
	-Dgallium-opencl=disabled \
	-Dgallium-va=false \
	-Dgallium-vdpau=false \
	-Dgallium-xa=false \
	-Dgallium-xvmc=false \
	-Dgbm=$(call ptx/truefalse, PTXCONF_MESALIB_GBM) \
	-Dgles1=$(call ptx/truefalse, PTXCONF_MESALIB_GLES1) \
	-Dgles2=$(call ptx/truefalse, PTXCONF_MESALIB_GLES2) \
	-Dglvnd=false \
	-Dglx=$(call ptx/ifdef, PTXCONF_MESALIB_GLX, dri, disabled) \
	-Dglx-direct=false \
	-Dglx-read-only-text=false \
	-Dlibunwind=false \
	-Dllvm=false \
	-Dlmsensors=$(call ptx/truefalse, PTXCONF_MESALIB_LMSENSORS) \
	-Domx-libs-path=/usr/lib/dri \
	-Dopengl=$(call ptx/truefalse, PTXCONF_MESALIB_OPENGL) \
	-Dosmesa=none \
	-Dosmesa-bits=8 \
	-Dplatforms=$(subst $(space),$(comma),$(MESALIBS_EGL_PLATFORMS-y)) \
	-Dpower8=false \
	-Dselinux=false \
	-Dshader-cache=false \
	-Dshared-glapi=true \
	-Dshared-llvm=false \
	-Dswr-arches=[] \
	-Dtools=[] \
	-Dva-libs-path=/usr/lib/dri \
	-Dvalgrind=false \
	-Dvdpau-libs-path=/usr/lib/vdpau \
	-Dvulkan-drivers=[] \
	-Dvulkan-icd-dir=/etc/vulkan/icd.d \
	-Dxlib-lease=false \
	-Dxvmc-libs-path=/usr/lib

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/mesalib.compile:
	@$(call targetinfo)
	cp $(PTXCONF_SYSROOT_HOST)/bin/mesa/glsl_compiler $(MESALIB_DIR)/src/compiler/
	@$(call world/compile, MESALIB)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mesalib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mesalib)
	@$(call install_fixup, mesalib,PRIORITY,optional)
	@$(call install_fixup, mesalib,SECTION,base)
	@$(call install_fixup, mesalib,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, mesalib,DESCRIPTION,missing)

	@$(foreach lib, $(MESALIB_DRI_LIBS-y), \
		$(call install_copy, mesalib, 0, 0, 0644, -, \
		/usr/lib/dri/$(lib)_dri.so)$(ptx/nl))

ifneq ($(strip $(MESALIB_DRI_GALLIUM_LIBS-y)),)
	@$(call install_copy, mesalib, 0, 0, 0644, \
		$(MESALIB_PKGDIR)/usr/lib/dri/$(firstword $(MESALIB_DRI_GALLIUM_LIBS-y))_dri.so, \
		/usr/lib/dri/gallium_dri.so)

	@$(foreach lib, $(MESALIB_DRI_GALLIUM_LIBS-y), \
		$(call install_link, mesalib, gallium_dri.so, \
		/usr/lib/dri/$(lib)_dri.so)$(ptx/nl))
endif

	@$(foreach lib, $(MESALIB_LIBS-y), \
		$(call install_lib, mesalib, 0, 0, 0644, $(lib))$(ptx/nl))

	@$(call install_finish, mesalib)

	@$(call touch)


# vim: syntax=make
