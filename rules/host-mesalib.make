# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_MESALIB) += host-mesalib

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_MESALIB_CONF_TOOL	:= meson
HOST_MESALIB_CONF_OPT	:= \
	$(HOST_MESON_OPT) \
	-Dandroid-stub=false \
	-Dbuild-aco-tests=false \
	-Dbuild-tests=false \
	-Dd3d-drivers-path=/usr/lib/d3d \
	-Ddri-drivers= \
	-Ddri-drivers-path=/usr/lib/dri \
	-Ddri-search-path=/usr/lib/dri \
	-Ddri3=disabled \
	-Degl=disabled \
	-Degl-lib-suffix= \
	-Dfreedreno-kgsl=false \
	-Dgallium-drivers= \
	-Dgallium-extra-hud=false \
	-Dgallium-nine=false \
	-Dgallium-omx=disabled \
	-Dgallium-opencl=disabled \
	-Dgallium-va=disabled \
	-Dgallium-vdpau=disabled \
	-Dgallium-xa=disabled \
	-Dgallium-xvmc=disabled \
	-Dgbm=disabled \
	-Dgles-lib-suffix= \
	-Dgles1=disabled \
	-Dgles2=disabled \
	-Dglvnd=false \
	-Dglx=disabled \
	-Dglx-direct=false \
	-Dglx-read-only-text=false \
	-Dinstall-intel-gpu-tests=false \
	-Dlibunwind=disabled \
	-Dllvm=disabled \
	-Dlmsensors=disabled \
	-Domx-libs-path=/usr/lib/dri \
	-Dopencl-spirv=false \
	-Dopengl=true \
	-Dosmesa=none \
	-Dosmesa-bits=8 \
	-Dplatform-sdk-version=25 \
	-Dplatforms= \
	-Dpower8=disabled \
	-Dprefer-iris=true \
	-Dselinux=false \
	-Dshader-cache-default=true \
	-Dshader-cache=disabled \
	-Dshared-glapi=enabled \
	-Dshared-llvm=disabled \
	-Dshared-swr=true \
	-Dstatic-libclc=[] \
	-Dswr-arches=[] \
	-Dtools=glsl \
	-Dva-libs-path=/usr/lib/dri \
	-Dvalgrind=disabled \
	-Dvdpau-libs-path=/usr/lib/vdpau \
	-Dvulkan-device-select-layer=false \
	-Dvulkan-drivers=[] \
	-Dvulkan-icd-dir=/etc/vulkan/icd.d \
	-Dvulkan-overlay-layer=false \
	-Dxlib-lease=disabled \
	-Dxvmc-libs-path=/usr/lib \
	-Dzstd=disabled

HOST_MESALIB_MAKE_OPT	:= \
	src/compiler/glsl/glsl_compiler

$(STATEDIR)/host-mesalib.install:
	@$(call targetinfo)
	install -D -m755 $(HOST_MESALIB_DIR)-build/src/compiler/glsl/glsl_compiler $(HOST_MESALIB_PKGDIR)/bin/mesa/glsl_compiler
	@$(call touch)

# vim: syntax=make
