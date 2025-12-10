# -*-makefile-*-
#
# Copyright (C) 2002-2009 by Pengutronix e.K., Hildesheim, Germany
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_KERNEL) += kernel

#
# Paths and names
#
KERNEL			:= linux-$(KERNEL_VERSION)
KERNEL_MD5		:= $(call ptx/config-md5, PTXCONF_KERNEL)
ifneq ($(KERNEL_NEEDS_GIT_URL),y)
KERNEL_SUFFIX		:= tar.xz
KERNEL_URL		:= $(call kernel-url, KERNEL)
else
KERNEL_SUFFIX		:= tar.gz
KERNEL_URL		:= https://git.kernel.org/torvalds/t/$(KERNEL).$(KERNEL_SUFFIX)
endif
KERNEL_DIR		:= $(BUILDDIR)/$(KERNEL)
KERNEL_BUILD_DIR	:= $(KERNEL_DIR)-build
KERNEL_CONFIG		:= $(call ptx/in-platformconfigdir, $(call remove_quotes, $(PTXCONF_KERNEL_CONFIG)))
KERNEL_DTS_PATH		:= $(call remove_quotes,$(PTXCONF_KERNEL_DTS_PATH))
KERNEL_DTS		:= $(call remove_quotes,$(PTXCONF_KERNEL_DTS))
KERNEL_DTSO_PATH	:= $(call remove_quotes,$(PTXCONF_KERNEL_DTSO_PATH))
KERNEL_DTSO		:= $(call remove_quotes,$(PTXCONF_KERNEL_DTSO))
KERNEL_DTB_FILES	:= $(addsuffix .dtb,$(basename $(notdir $(KERNEL_DTS))))
KERNEL_DTBO_FILES	:= $(addsuffix .dtbo,$(basename $(notdir $(KERNEL_DTSO))))
KERNEL_DTBO_DIR		:= /boot/overlays
KERNEL_LICENSE		:= GPL-2.0-only
KERNEL_SOURCE		:= $(SRCDIR)/$(KERNEL).$(KERNEL_SUFFIX)
KERNEL_DEVPKG		:= NO
KERNEL_BUILD_OOT	:= KEEP
KERNEL_CVE_PRODUCT	:= linux:linux_kernel

# track changes to devices-trees in the BSP
$(call world/dts-cfghash-file, KERNEL)

# in case we migrate some old syntax
ifneq ($(filter /%,$(KERNEL_DTS)),)
$(call ptx/error, the device trees in PTXCONF_KERNEL_DTS must be specified without an)
$(call ptx/error, absolute path. Use PTXCONF_KERNEL_DTS_PATH to provide a list of direcories)
$(call ptx/error, that will be searched.)
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# use CONFIG_CC_STACKPROTECTOR if available. The rest makes no sense for the kernel
KERNEL_WRAPPER_BLACKLIST := \
	$(PTXDIST_LOWLEVEL_WRAPPER_BLACKLIST)

# Note: for some reason, the error is not visible without the dummy '$(shell :)'
# when running 'ptxdist -j -q go'.
define kernel/deprecated
$(if $(strip \
$(filter $(STATEDIR)/%, \
$(filter-out $(STATEDIR)/kernel.%,$@)) \
),$(shell :)$(error $(notdir $@): \
	use KERNEL_MODULE_OPT instead of $(1) for kernel module packages))
endef

# check for old kernel modules rules
KERNEL_MAKEVARS = $(call kernel/deprecated, KERNEL_MAKEVARS)

# like kernel-opts but with different CROSS_COMPILE=
KERNEL_BASE_OPT		= \
	$(call kernel-opts, KERNEL,$(KERNEL_CROSS_COMPILE)) \
	$(call remove_quotes,$(PTXCONF_KERNEL_EXTRA_MAKEVARS))

# Intermediate option. This will be used by kernel module packages.
KERNEL_MODULE_OPT	= \
	-C $(KERNEL_DIR) \
	O=$(KERNEL_BUILD_DIR) \
	$(KERNEL_BASE_OPT)

KERNEL_SHARED_OPT	= \
	$(KERNEL_MODULE_OPT) \
	PAHOLE=false

ifndef PTXCONF_KERNEL_GCC_PLUGINS
# no gcc plugins; avoid config changes depending on the host compiler
KERNEL_SHARED_OPT	+= \
	HOSTCXX="$(HOSTCXX) -DGENERATOR_FILE" \
	HOSTCC="$(HOSTCC) -DGENERATOR_FILE"
KERNEL_CONF_ENV		:= \
	PTXDIST_NO_GCC_PLUGINS=1
KERNEL_MAKE_ENV		:= \
	PTXDIST_NO_GCC_PLUGINS=1
endif

ifneq ($(PTXCONF_KERNEL_CODE_SIGNING)$(PTXCONF_KERNEL_MODULES_SIGN),)
KERNEL_MAKE_ENV		+= \
	$(CODE_SIGNING_ENV)
endif

KERNEL_CONF_TOOL	:= kconfig
KERNEL_CONF_OPT		= \
	$(KERNEL_SHARED_OPT)

ifdef PTXCONF_KERNEL_CONFIG_BASE_VERSION
# force using KERNEL_VERSION in the kernelconfig
KERNEL_CONF_OPT		+= \
	KERNELVERSION=$(KERNEL_VERSION)
endif

#
# support the different kernel image formats
#
KERNEL_IMAGE		:= $(call remove_quotes, $(PTXCONF_KERNEL_IMAGE))

# these are sane defaults
KERNEL_IMAGE_PATH_y	:= $(KERNEL_BUILD_DIR)/arch/$(GENERIC_KERNEL_ARCH)/boot/$(KERNEL_IMAGE)

# vmlinux and vmlinuz are special
KERNEL_IMAGE_PATH_$(PTXCONF_KERNEL_IMAGE_VMLINUX) := $(KERNEL_BUILD_DIR)/vmlinux
KERNEL_IMAGE_PATH_$(PTXCONF_KERNEL_IMAGE_VMLINUZ) := $(KERNEL_BUILD_DIR)/vmlinuz
# avr32 is also special
KERNEL_IMAGE_PATH_$(PTXCONF_ARCH_AVR32) := $(KERNEL_BUILD_DIR)/arch/$(GENERIC_KERNEL_ARCH)/boot/images/$(KERNEL_IMAGE)


ifdef PTXCONF_KERNEL
$(KERNEL_CONFIG):
	@echo
	@echo "*************************************************************************"
	@echo "**** Please generate a kernelconfig with 'ptxdist menuconfig kernel' ****"
	@echo "*************************************************************************"
	@echo
	@echo
	@exit 1
endif


#
# when compiling the rootfs into the kernel, we just include an empty
# file for now. the rootfs isn't build yet.
#
KERNEL_INITRAMFS_SOURCE_$(PTXCONF_IMAGE_KERNEL_INITRAMFS) += $(STATEDIR)/empty.cpio

$(STATEDIR)/kernel.prepare:
	@$(call targetinfo)
#
# Make sure there is a non empty INITRAMFS_SOURCE in $(KERNEL_CONFIG), but
# not the real expanded path because it contains local workdir path which
# is not relevant to other developers.
#
ifdef KERNEL_INITRAMFS_SOURCE_y
	@sed -i -e 's,^CONFIG_INITRAMFS_SOURCE.*$$,CONFIG_INITRAMFS_SOURCE=\"# Automatically set by PTXDist\",g' \
		"$(KERNEL_CONFIG)"
endif
ifdef PTXCONF_KERNEL_IMAGE_SIMPLE
	cp $(PTXCONF_KERNEL_IMAGE_SIMPLE_DTS) \
		$(KERNEL_DIR)/arch/$(GENERIC_KERNEL_ARCH)/boot/dts/$(PTXCONF_KERNEL_IMAGE_SIMPLE_TARGET).dts
endif

	@$(call world/prepare, KERNEL)

#
# Use an existing dummy INITRAMFS_SOURCE for the first 'make' call. The
# kernel image will be rebuilt in the image-kernel package with the real
# initramfs.
#
ifdef KERNEL_INITRAMFS_SOURCE_y
	@touch "$(KERNEL_INITRAMFS_SOURCE_y)"
	@sed -i -e 's,^CONFIG_INITRAMFS_SOURCE.*$$,CONFIG_INITRAMFS_SOURCE=\"$(KERNEL_INITRAMFS_SOURCE_y)\",g' \
		"$(KERNEL_BUILD_DIR)/.config"
endif
ifdef PTXCONF_KERNEL_CODE_SIGNING
	if [ -n "`cs_get_ca kernel-trusted`" ]; then \
		sed -i -e "s'^\(CONFIG_SYSTEM_TRUSTED_KEYS\)=.*'\1=\"`cs_get_ca kernel-trusted`\"'" \
			"$(KERNEL_BUILD_DIR)/.config"; \
	fi
endif
ifdef PTXCONF_KERNEL_MODULES_SIGN
	sed -i -e "s'^\(CONFIG_MODULE_SIG_KEY\)=.*'\1=\"`cs_get_uri kernel-modules`\"'" \
		"$(KERNEL_BUILD_DIR)/.config"
endif
	@$(call touch)


# ----------------------------------------------------------------------------
# tags
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel.tags:
	@$(call targetinfo)
	@$(MAKE) -C $(KERNEL_DIR) $(KERNEL_MAKE_OPT) tags TAGS cscope

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

KERNEL_MAKE_OPT		= \
	$(call kernel/deprecated, KERNEL_MAKE_OPT) \
	$(KERNEL_SHARED_OPT) \
	$(KERNEL_IMAGE) \
	$(call ptx/ifdef, PTXCONF_KERNEL_MODULES,modules)

KERNEL_TOOL_PERF_OPTS	:= \
	-C $(KERNEL_DIR)/tools/perf \
	O=$(KERNEL_BUILD_DIR)/tools/perf \
	$(KERNEL_BASE_OPT) \
	prefix=/usr \
	WERROR=0 \
	NO_LIBPERL=1 \
	NO_LIBPYTHON=1 \
	NO_DWARF= \
	NO_SLANG= \
	NO_GTK2=1 \
	NO_DEMANGLE= \
	NO_LIBELF= \
	NO_LIBUNWIND=1 \
	NO_BACKTRACE= \
	NO_LIBNUMA=1 \
	NO_LIBAUDIT=1 \
	NO_LIBBIONIC=1 \
	NO_LIBCRYPTO=1 \
	NO_LIBDW_DWARF_UNWIND= \
	NO_PERF_READ_VDSO32=1 \
	NO_PERF_READ_VDSOX32=1 \
	NO_ZLIB= \
	NO_LIBBABELTRACE=1 \
	NO_LZMA=1 \
	NO_LIBZSTD= \
	NO_AUXTRACE= \
	NO_LIBBPF=1 \
	NO_SDT=1 \
	NO_LIBCAP=1

# manual make to handle CPPFLAGS and broken parallel building for some
# kernel versions
KERNEL_TOOL_IIO_OPTS	:= \
	PTXDIST_ICECC=$(PTXDIST_ICERUN) \
	CPPFLAGS="-D__EXPORTED_HEADERS__ -I$(KERNEL_DIR)/include/uapi -I$(KERNEL_DIR)/include" \
	-C $(KERNEL_DIR)/tools/iio \
	O=$(KERNEL_BUILD_DIR)/tools/iio \
	$(KERNEL_BASE_OPT) \
	$(PARALLELMFLAGS_BROKEN)

$(STATEDIR)/kernel.compile:
	@$(call targetinfo)
	@rm -f \
		$(KERNEL_BUILD_DIR)/usr/initramfs_data.cpio.* \
		$(KERNEL_BUILD_DIR)/usr/.initramfs_data.cpio.*
	@$(call world/compile, KERNEL)
ifdef PTXCONF_KERNEL_TOOL_PERF
	@mkdir -p $(KERNEL_BUILD_DIR)/tools/perf
	@$(call compile, KERNEL, $(KERNEL_TOOL_PERF_OPTS))
endif
ifdef PTXCONF_KERNEL_TOOL_IIO
	@mkdir -p $(KERNEL_BUILD_DIR)/tools/iio
	@$(call world/execute, KERNEL, \
		$(MAKE) $(KERNEL_TOOL_IIO_OPTS))
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

KERNEL_INSTALL_OPT = \
	$(KERNEL_BASE_OPT) \
	modules_install

$(STATEDIR)/kernel.install:
	@$(call targetinfo)
ifdef PTXCONF_KERNEL_MODULES_INSTALL
	@$(call world/install, KERNEL)
	@chmod -x $(KERNEL_PKGDIR)/lib/modules/*/modules.builtin.modinfo
endif
	@$(call world/dtb, KERNEL)
	@$(call world/dtbo, KERNEL)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ifneq ($(KERNEL_DTB_FILES),)
$(addprefix $(IMAGEDIR)/,$(KERNEL_DTB_FILES)): $(STATEDIR)/kernel.targetinstall
endif

$(STATEDIR)/kernel.targetinstall:
	@$(call targetinfo)

	@$(foreach dtb, $(KERNEL_DTB_FILES), \
		$(call ptx/image-install, KERNEL, \
			$(KERNEL_PKGDIR)/boot/$(dtb), $(dtb))$(ptx/nl))

ifdef PTXCONF_KERNEL_XPKG
	@$(call install_init,  kernel)
	@$(call install_fixup, kernel, PRIORITY,optional)
	@$(call install_fixup, kernel, SECTION,base)
	@$(call install_fixup, kernel, AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, kernel, DESCRIPTION,missing)

	@$(call install_copy, kernel, 0, 0, 0755, /boot);

ifdef PTXCONF_KERNEL_INSTALL
	@$(call install_copy, kernel, 0, 0, 0644, $(KERNEL_IMAGE_PATH_y), /boot/$(KERNEL_IMAGE), n)

	@$(foreach dtb, $(KERNEL_DTB_FILES), \
		$(call install_copy, kernel, 0, 0, 0644, -, \
			/boot/$(dtb), n)$(ptx/nl))

	@$(foreach dtbo, $(KERNEL_DTBO_FILES), \
		$(call install_copy, kernel, 0, 0, 0644, -, \
			$(KERNEL_DTBO_DIR)/$(dtbo), n)$(ptx/nl))
endif

# install the ELF kernel image for debugging purpose
ifdef PTXCONF_KERNEL_VMLINUX
	@$(call install_copy, kernel, 0, 0, 0644, $(KERNEL_BUILD_DIR)/vmlinux, /boot/vmlinux, n)
endif

ifdef PTXCONF_KERNEL_TOOL_PERF
	@$(call install_copy, kernel, 0, 0, 0755, $(KERNEL_BUILD_DIR)/tools/perf/perf, \
		/usr/bin/perf)
endif

ifdef PTXCONF_KERNEL_TOOL_IIO
	@$(call install_copy, kernel, 0, 0, 0755, $(wildcard $(KERNEL_BUILD_DIR)/tools/iio/*generic_buffer), \
		/usr/bin/iio_generic_buffer)
	@$(call install_copy, kernel, 0, 0, 0755, $(KERNEL_BUILD_DIR)/tools/iio/lsiio, \
		/usr/bin/lsiio)
	@$(call install_copy, kernel, 0, 0, 0755, $(KERNEL_BUILD_DIR)/tools/iio/iio_event_monitor, \
		/usr/bin/iio_event_monitor)
endif

	@$(call install_finish, kernel)
endif

	@$(call touch)


# ----------------------------------------------------------------------------
# Target-Install-post
# ----------------------------------------------------------------------------

ifdef PTXCONF_IMAGE_KERNEL_INSTALL_EARLY
$(STATEDIR)/kernel.targetinstall.post: $(IMAGEDIR)/linuximage
ifdef PTXCONF_IMAGE_KERNEL_LZOP
$(STATEDIR)/kernel.targetinstall.post: $(IMAGEDIR)/linuximage.lzo
endif
endif

$(STATEDIR)/kernel.targetinstall.post:
	@$(call targetinfo)

ifdef PTXCONF_KERNEL_MODULES_INSTALL
	@$(call install_init,  kernel-modules)
	@$(call install_fixup, kernel-modules, PRIORITY,optional)
	@$(call install_fixup, kernel-modules, SECTION,base)
	@$(call install_fixup, kernel-modules, AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, kernel-modules, DESCRIPTION,missing)

	@$(call install_glob, kernel-modules, 0, 0, -, /lib/modules, *.ko,, n)
	@$(call install_glob, kernel-modules, 0, 0, -, /lib/modules,, *.ko */build */source, n)

	@$(call install_finish, kernel-modules)
endif

	@$(call touch)

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

$(call ptx/kconfig-targets, kernel): $(STATEDIR)/kernel.extract
	@$(call world/kconfig, KERNEL, $(subst kernel_,,$@))

# vim: syntax=make
