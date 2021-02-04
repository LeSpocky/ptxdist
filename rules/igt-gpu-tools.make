# -*-makefile-*-
#
# Copyright (C) 2016 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IGT_GPU_TOOLS) += igt-gpu-tools

#
# Paths and names
#
IGT_GPU_TOOLS_VERSION	:= 1.25
IGT_GPU_TOOLS_MD5	:= 4c148d3be97607859168ed70b15e8b2f
IGT_GPU_TOOLS		:= igt-gpu-tools-$(IGT_GPU_TOOLS_VERSION)
IGT_GPU_TOOLS_SUFFIX	:= tar.xz
IGT_GPU_TOOLS_URL	:= $(call ptx/mirror, XORG, individual/app/$(IGT_GPU_TOOLS).$(IGT_GPU_TOOLS_SUFFIX))
IGT_GPU_TOOLS_SOURCE	:= $(SRCDIR)/$(IGT_GPU_TOOLS).$(IGT_GPU_TOOLS_SUFFIX)
IGT_GPU_TOOLS_DIR	:= $(BUILDDIR)/$(IGT_GPU_TOOLS)
IGT_GPU_TOOLS_LICENSE	:= MIT AND ISC

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# For some reason, intel_gpu_frequency and other segfault immediately if
# built with -Wl,-z,now.
IGT_GPU_TOOLS_WRAPPER_BLACKLIST := \
	TARGET_HARDEN_BINDNOW

IGT_GPU_TOOLS_LIBDRM-y					:=
ifdef PTXCONF_ARCH_X86
IGT_GPU_TOOLS_LIBDRM-$(PTXCONF_IGT_GPU_TOOLS_INTEL)	+= intel
endif
IGT_GPU_TOOLS_LIBDRM-$(PTXCONF_IGT_GPU_TOOLS_AMDGPU)	+= amdgpu
IGT_GPU_TOOLS_LIBDRM-$(PTXCONF_IGT_GPU_TOOLS_NOUVEAU)	+= nouveau

IGT_GPU_TOOLS_CONF_TOOL	:= meson
IGT_GPU_TOOLS_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dchamelium=disabled \
	-Ddocs=disabled \
	-Dlibdrm_drivers=$(subst $(space),$(comma),$(IGT_GPU_TOOLS_LIBDRM-y)) \
	-Dlibunwind=enabled \
	-Dman=disabled \
	-Doping=disabled \
	-Doverlay=disabled \
	-Doverlay_backends=auto \
	-Drunner=$(call ptx/endis,PTXCONF_IGT_GPU_TOOLS_TEST_RUNNER)d \
	-Dtests=$(call ptx/endis,PTXCONF_IGT_GPU_TOOLS_TESTS)d \
	-Duse_rpath=false \
	-Dvalgrind=disabled

ifdef PTXCONF_KERNEL_HEADER
IGT_GPU_TOOLS_CPPFLAGS	:= \
	-isystem $(KERNEL_HEADERS_INCLUDE_DIR)
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/igt-gpu-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, igt-gpu-tools)
	@$(call install_fixup, igt-gpu-tools,PRIORITY,optional)
	@$(call install_fixup, igt-gpu-tools,SECTION,base)
	@$(call install_fixup, igt-gpu-tools,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, igt-gpu-tools,DESCRIPTION,missing)

	@$(call install_tree, igt-gpu-tools, 0, 0, -, /usr/lib)
	@$(call install_tree, igt-gpu-tools, 0, 0, -, /usr/bin)
	@$(call install_tree, igt-gpu-tools, 0, 0, -, /usr/share/igt-gpu-tools)
	@$(call install_tree, igt-gpu-tools, 0, 0, -, /usr/libexec/igt-gpu-tools)

	@$(call install_finish, igt-gpu-tools)

	@$(call touch)

# vim: syntax=make
