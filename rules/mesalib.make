# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MESALIB) += mesalib

#
# Paths and names
#
MESALIB_VERSION	:= 20.3.3
MESALIB_MD5	:= c4c81cbd8a93f87104d3f1209948b238
MESALIB		:= mesa-$(MESALIB_VERSION)
MESALIB_SUFFIX	:= tar.xz
MESALIB_URL	:= \
	https://mesa.freedesktop.org/archive/$(MESALIB).$(MESALIB_SUFFIX)
MESALIB_SOURCE	:= $(SRCDIR)/$(MESALIB).$(MESALIB_SUFFIX)
MESALIB_DIR	:= $(BUILDDIR)/Mesa-$(MESALIB_VERSION)
MESALIB_LICENSE	:= MIT
MESALIB_LICENSE_FILES := \
	file://docs/license.rst;md5=9aa1bc48c9826ad9fdb16661f6930496

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
ifdef PTXCONF_ARCH_ARM_NEON
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_V3D)	+= v3d
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_VC4)	+= vc4
endif
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_SWRAST)	+= swrast
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_PANFROST)	+= panfrost
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_LIMA)	+= lima
ifdef PTXCONF_ARCH_X86
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_IRIS)	+= iris
endif
MESALIB_GALLIUM_DRIVERS-$(PTXCONF_MESALIB_DRI_ZINK)	+= zink

MESALIB_DRI_LIBS-y = \
	$(subst nouveau,nouveau_vieux,$(MESALIB_DRI_DRIVERS-y))

MESALIB_DRI_GALLIUM_LIBS-y = \
	$(subst kmsro, \
		armada-drm \
		exynos \
		hx8357d \
		ili9225 \
		ili9341 \
		imx-drm \
		ingenic-drm \
		mcde \
		meson \
		mi0283qt \
		mxsfb-drm \
		pl111 \
		repaper \
		rockchip \
		st7586 \
		st7735r \
		stm \
		sun4i-drm \
	,$(subst freedreno,kgsl,$(MESALIB_GALLIUM_DRIVERS-y)))

ifdef PTXCONF_ARCH_X86
MESALIB_VULKAN_DRIVERS-$(PTXCONF_MESALIB_VULKAN_AMD)		+= amd
MESALIB_VULKAN_DRIVERS-$(PTXCONF_MESALIB_VULKAN_INTEL)		+= intel
endif
ifdef PTXCONF_ARCH_ARM
MESALIB_VULKAN_DRIVERS-$(PTXCONF_MESALIB_VULKAN_BROADCOM)	+= broadcom
MESALIB_VULKAN_DRIVERS-$(PTXCONF_MESALIB_VULKAN_FREEDRENO)	+= freedreno
endif
MESALIB_VULKAN_DRIVERS-$(PTXCONF_MESALIB_VULKAN_SWRAST)		+= swrast

MESALIB_VULKAN_LIBS-y = $(subst amd,radeon,$(subst swrast,lvp,$(MESALIB_VULKAN_DRIVERS-y)))

MESALIB_LIBS-y				:= libglapi
MESALIB_LIBS-$(PTXCONF_MESALIB_GLX)	+= libGL
MESALIB_LIBS-$(PTXCONF_MESALIB_GLES1)	+= libGLESv1_CM
MESALIB_LIBS-$(PTXCONF_MESALIB_GLES2)	+= libGLESv2
MESALIB_LIBS-$(PTXCONF_MESALIB_EGL)	+= libEGL
MESALIB_LIBS-$(PTXCONF_MESALIB_GBM)	+= libgbm

MESALIBS_EGL_PLATFORMS-$(PTXCONF_MESALIB_EGL_X11)	+= x11
MESALIBS_EGL_PLATFORMS-$(PTXCONF_MESALIB_EGL_WAYLAND)	+= wayland

MESALIB_CONF_TOOL	:= meson
MESALIB_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dandroid-stub=false \
	-Dbuild-aco-tests=false \
	-Dbuild-tests=false \
	-Dd3d-drivers-path=/usr/lib/d3d \
	-Ddri-drivers=$(subst $(space),$(comma),$(MESALIB_DRI_DRIVERS-y)) \
	-Ddri-drivers-path=/usr/lib/dri \
	-Ddri-search-path=/usr/lib/dri \
	-Ddri3=$(call ptx/endis, PTXCONF_MESALIB_DRI3)d \
	-Degl=$(call ptx/endis, PTXCONF_MESALIB_EGL)d \
	-Degl-lib-suffix= \
	-Dfreedreno-kgsl=false \
	-Dgallium-drivers=$(subst $(space),$(comma),$(MESALIB_GALLIUM_DRIVERS-y)) \
	-Dgallium-extra-hud=$(call ptx/truefalse, PTXCONF_MESALIB_EXTENDED_HUD) \
	-Dgallium-nine=false \
	-Dgallium-omx=disabled \
	-Dgallium-opencl=disabled \
	-Dgallium-va=disabled \
	-Dgallium-vdpau=disabled \
	-Dgallium-xa=disabled \
	-Dgallium-xvmc=disabled \
	-Dgbm=$(call ptx/endis, PTXCONF_MESALIB_GBM)d \
	-Dgles-lib-suffix= \
	-Dgles1=$(call ptx/endis, PTXCONF_MESALIB_GLES1)d \
	-Dgles2=$(call ptx/endis, PTXCONF_MESALIB_GLES2)d \
	-Dglvnd=false \
	-Dglx=$(call ptx/ifdef, PTXCONF_MESALIB_GLX, dri, disabled) \
	-Dglx-direct=true \
	-Dglx-read-only-text=false \
	-Dinstall-intel-gpu-tests=false \
	-Dlibunwind=disabled \
	-Dllvm=disabled \
	-Dlmsensors=$(call ptx/endis, PTXCONF_MESALIB_LMSENSORS)d \
	-Domx-libs-path=/usr/lib/dri \
	-Dopencl-spirv=false \
	-Dopengl=$(call ptx/truefalse, PTXCONF_MESALIB_OPENGL) \
	-Dosmesa=none \
	-Dosmesa-bits=8 \
	-Dplatform-sdk-version=25 \
	-Dplatforms=$(subst $(space),$(comma),$(MESALIBS_EGL_PLATFORMS-y)) \
	-Dpower8=disabled \
	-Dprefer-iris=true \
	-Dselinux=false \
	-Dshader-cache-default=true \
	-Dshader-cache=$(call ptx/endis, PTXCONF_MESALIB_VULKAN_AMD)d \
	-Dshared-glapi=enabled \
	-Dshared-llvm=disabled \
	-Dshared-swr=true \
	-Dstatic-libclc=[] \
	-Dswr-arches=[] \
	-Dtools=[] \
	-Dva-libs-path=/usr/lib/dri \
	-Dvalgrind=disabled \
	-Dvdpau-libs-path=/usr/lib/vdpau \
	-Dvulkan-device-select-layer=false \
	-Dvulkan-drivers=$(subst $(space),$(comma),$(MESALIB_VULKAN_DRIVERS-y)) \
	-Dvulkan-icd-dir=/etc/vulkan/icd.d \
	-Dvulkan-overlay-layer=false \
	-Dxlib-lease=disabled \
	-Dxvmc-libs-path=/usr/lib \
	-Dzstd=$(call ptx/endis, PTXCONF_MESALIB_ZSTD)d

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/mesalib.compile:
	@$(call targetinfo)
	cp $(PTXDIST_SYSROOT_HOST)/bin/mesa/glsl_compiler $(MESALIB_DIR)/src/compiler/
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

ifneq ($(strip $(MESALIB_VULKAN_LIBS-y)),)
	@$(foreach lib, $(MESALIB_VULKAN_LIBS-y), \
		$(call install_copy, mesalib, 0, 0, 0644, -, \
		/usr/lib/libvulkan_$(lib).so)$(ptx/nl) \
		$(call install_glob, mesalib, 0, 0, -, \
		/etc/vulkan/icd.d, */$(lib)_icd.*.json)$(ptx/nl))
endif

	@$(foreach lib, $(MESALIB_LIBS-y), \
		$(call install_lib, mesalib, 0, 0, 0644, $(lib))$(ptx/nl))

	@$(call install_finish, mesalib)

	@$(call touch)


# vim: syntax=make
