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
IGT_GPU_TOOLS_VERSION	:= 1.29
IGT_GPU_TOOLS_MD5	:= a38956517259338638cc2e17e3e8720a
IGT_GPU_TOOLS		:= igt-gpu-tools-$(IGT_GPU_TOOLS_VERSION)
IGT_GPU_TOOLS_SUFFIX	:= tar.xz
IGT_GPU_TOOLS_URL	:= $(call ptx/mirror, XORG, individual/app/$(IGT_GPU_TOOLS).$(IGT_GPU_TOOLS_SUFFIX))
IGT_GPU_TOOLS_SOURCE	:= $(SRCDIR)/$(IGT_GPU_TOOLS).$(IGT_GPU_TOOLS_SUFFIX)
IGT_GPU_TOOLS_DIR	:= $(BUILDDIR)/$(IGT_GPU_TOOLS)
IGT_GPU_TOOLS_LICENSE	:= MIT AND ISC
IGT_GPU_TOOLS_LICENSE_FILES := \
	file://COPYING;md5=67bfee4df38fa6ecbe3a675c552d4c08

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# On x86 systems, libigt resolves igt_half_to_float and igt_float_to_half as
# indirect functions at runtime by checking CPU features with igt_x86_features.
# The igt_x86_features function is implemented is a different object and the
# call uses the PLT itself. If lazy binding is disabled, this causes a segfault
# while resolving the symbols for libigt on x64 systems. Disable BINDNOW on X86
# systems to prevent the segfaults.
ifdef PTXCONF_ARCH_X86
IGT_GPU_TOOLS_WRAPPER_BLACKLIST := \
	TARGET_HARDEN_BINDNOW
endif

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
	-Dsphinx=disabled \
	-Dsrcdir=$(notdir $(IGT_GPU_TOOLS_DIR)) \
	-Dtestplan=disabled \
	-Dtests=$(call ptx/endis,PTXCONF_IGT_GPU_TOOLS_TESTS)d \
	-Duse_rpath=false \
	-Dvalgrind=disabled \
	-Dversion_hash=NO-GIT \
	-Dxe_driver=disabled

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

	@$(call install_lib, igt-gpu-tools, 0, 0, 0644, libigt)

	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/amd_hdmi_compliance)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/dpcd_reg)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/gputop)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/lsgpu)

ifdef PTXCONF_IGT_GPU_TOOLS_INTEL
	@$(call install_lib, igt-gpu-tools, 0, 0, 0644, libi915_perf)

	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/i915-perf-configs)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/i915-perf-control)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/i915-perf-reader)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/i915-perf-recorder)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_audio_dump)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_backlight)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_bios_dumper)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_display_crc)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_display_poller)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_dp_compliance)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_dump_decode)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_error_decode)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_firmware_decode)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_forcewaked)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_framebuffer_dump)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_gem_info)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel-gfx-fw-info)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_gpu_abrt)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_gpu_frequency)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_gpu_time)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_gpu_top)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_gtt)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_guc_logger)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_gvtg_test)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_infoframes)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_l3_parity)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_lid)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_opregion_decode)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_panel_fitter)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_perf_counters)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_pm_rpm)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_reg)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_reg_checker)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_residency)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_stepping)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_vbt_decode)
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/intel_watermark)

	@$(call install_tree, igt-gpu-tools, 0, 0, -, /usr/share/igt-gpu-tools/registers)
endif

ifdef PTXCONF_IGT_GPU_TOOLS_FREEDRENO
	@$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/msm_dp_compliance)
endif

ifdef PTXCONF_IGT_GPU_TOOLS_TESTS
	$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/code_cov_capture)
	$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/code_cov_gather_on_build)
	$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/code_cov_gather_on_test)
	$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/code_cov_gen_report)
ifdef PTXCONF_IGT_GPU_TOOLS_TESTS_PERL
	$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/code_cov_parse_info)
endif

	@$(call install_tree, igt-gpu-tools, 0, 0, -, /usr/libexec/igt-gpu-tools)
	@$(call install_glob, igt-gpu-tools, 0, 0, -, /usr/share/igt-gpu-tools, *.png,)
endif

ifdef PTXCONF_IGT_GPU_TOOLS_TEST_RUNNER
	$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/igt_comms_decoder)
	$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/igt_results)
	$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/igt_resume)
	$(call install_copy, igt-gpu-tools, 0, 0, 0755, -, /usr/bin/igt_runner)
endif

	@$(call install_finish, igt-gpu-tools)

	@$(call touch)

# vim: syntax=make
