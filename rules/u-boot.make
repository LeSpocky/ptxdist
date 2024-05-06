# -*-makefile-*-
#
# Copyright (C) 2007 by Sascha Hauer
#               2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2018 by Ahmad Fatoum <a.fatoum@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_U_BOOT) += u-boot

#
# Paths and names
#
U_BOOT_VERSION		:= $(call ptx/config-version, PTXCONF_U_BOOT)
U_BOOT_MD5		:= $(call ptx/config-md5, PTXCONF_U_BOOT)
U_BOOT			:= u-boot-$(U_BOOT_VERSION)
U_BOOT_SUFFIX		:= tar.bz2
U_BOOT_URL		:= https://ftp.denx.de/pub/u-boot/$(U_BOOT).$(U_BOOT_SUFFIX)
U_BOOT_SOURCE		:= $(SRCDIR)/$(U_BOOT).$(U_BOOT_SUFFIX)
U_BOOT_DIR		:= $(BUILDDIR)/$(U_BOOT)
U_BOOT_BUILD_DIR	:= $(U_BOOT_DIR)$(call ptx/ifdef, PTXCONF_U_BOOT_BUILD_OOT,-build)
U_BOOT_DEVPKG		:= NO
U_BOOT_BUILD_OOT	:= $(call ptx/ifdef, PTXCONF_U_BOOT_BUILD_OOT,KEEP,NO)

ifdef PTXCONF_U_BOOT_CONFIGSYSTEM_KCONFIG
U_BOOT_CONFIG	:= $(call ptx/in-platformconfigdir, \
		$(call remove_quotes, $(PTXCONF_U_BOOT_CONFIGFILE_KCONFIG)))
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

U_BOOT_INJECT_PATH	:= ${PTXDIST_SYSROOT_TARGET}/usr/lib/firmware
U_BOOT_INJECT_OOT	:= $(call ptx/ifdef, PTXCONF_U_BOOT_BUILD_OOT,YES,NO)

ifdef PTXCONF_U_BOOT_BOOT_SCRIPT
U_BOOT_BOOT_SCRIPT_TXT := $(call ptx/in-platformconfigdir, uboot.scr)
U_BOOT_BOOT_SCRIPT_BIN := $(call remove_quotes, \
	$(PTXCONF_U_BOOT_BOOT_SCRIPT_ROOTFS_PATH))
$(call ptx/cfghash-file, U_BOOT, $(U_BOOT_BOOT_SCRIPT_TXT))
endif

ifdef PTXCONF_U_BOOT_ENV_IMAGE_CUSTOM
U_BOOT_ENV_IMAGE_CUSTOM_SRC := $(call ptx/in-platformconfigdir, \
	$(call remove_quotes, $(PTXCONF_U_BOOT_ENV_IMAGE_CUSTOM_SOURCE)))
$(call ptx/cfghash-file, U_BOOT, $(U_BOOT_ENV_IMAGE_CUSTOM_SRC))
endif

# use host pkg-config for host tools
U_BOOT_PATH		:= PATH=$(HOST_PATH)

U_BOOT_WRAPPER_BLACKLIST := \
	$(PTXDIST_LOWLEVEL_WRAPPER_BLACKLIST)

U_BOOT_CONF_OPT		:= \
	-C $(U_BOOT_DIR) \
	$(call ptx/ifdef, PTXCONF_U_BOOT_BUILD_OOT,O=$(U_BOOT_BUILD_DIR)) \
	V=$(PTXDIST_VERBOSE) \
	$(call remove_quotes,$(PTXCONF_U_BOOT_CUSTOM_MAKE_OPTS))

U_BOOT_MAKE_ENV		:= \
	CROSS_COMPILE=$(BOOTLOADER_CROSS_COMPILE) \
	HOSTCC=$(HOSTCC) \
	$(call remove_quotes,$(PTXCONF_U_BOOT_CUSTOM_MAKE_ENV))

U_BOOT_MAKE_OPT		:= $(U_BOOT_CONF_OPT)

U_BOOT_TAGS_OPT		:= ctags cscope etags

ifdef PTXCONF_U_BOOT_CONFIGSYSTEM_KCONFIG
U_BOOT_CONF_TOOL	:= kconfig
U_BOOT_CONF_ENV		:= $(U_BOOT_MAKE_ENV)
endif

ifdef PTXCONF_U_BOOT_CONFIGSYSTEM_LEGACY
U_BOOT_CONF_ENV		:= PATH=$(CROSS_PATH) $(U_BOOT_MAKE_ENV)
U_BOOT_CONF_OPT		+= $(call remove_quotes, $(PTXCONF_U_BOOT_CONFIG))
U_BOOT_MAKE_PAR		:= NO
endif


ifdef PTXCONF_U_BOOT
$(U_BOOT_CONFIG):
	@echo
	@echo "****************************************************************************"
	@echo "***** Please generate a u-boot config with 'ptxdist menuconfig u-boot' *****"
	@echo "****************************************************************************"
	@echo
	@echo
	@exit 1
endif

$(STATEDIR)/u-boot.prepare:
	@$(call targetinfo)

ifdef PTXCONF_U_BOOT_CONFIGSYSTEM_KCONFIG
	@$(call world/prepare, U_BOOT)
endif

ifdef PTXCONF_U_BOOT_CONFIGSYSTEM_LEGACY
	$(U_BOOT_CONF_ENV) $(MAKE) $(U_BOOT_CONF_OPT)
endif

ifdef PTXCONF_U_BOOT_FIRMWARE
	@$(call world/inject, U_BOOT)
endif

	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/u-boot.compile:
	@$(call targetinfo)
	@$(call world/compile, U_BOOT)
ifdef PTXCONF_U_BOOT_BOOT_SCRIPT
	@$(U_BOOT_BUILD_DIR)/tools/mkimage -T script -C none \
		-d $(U_BOOT_BOOT_SCRIPT_TXT) \
		$(U_BOOT_BUILD_DIR)/boot.scr.uimg
endif
ifdef PTXCONF_U_BOOT_ENV_IMAGE_DEFAULT
	$(U_BOOT_MAKE_ENV) $(U_BOOT_DIR)/scripts/get_default_envs.sh $(U_BOOT_BUILD_DIR) | \
		$(U_BOOT_BUILD_DIR)/tools/mkenvimage \
		$(call ptx/ifdef,PTXCONF_U_BOOT_ENV_IMAGE_REDUNDANT,-r,) \
		-s $(PTXCONF_U_BOOT_ENV_IMAGE_SIZE) \
		-o $(U_BOOT_BUILD_DIR)/u-boot-env.img -
endif
ifdef PTXCONF_U_BOOT_ENV_IMAGE_CUSTOM
	$(U_BOOT_BUILD_DIR)/tools/mkenvimage \
		$(call ptx/ifdef,PTXCONF_U_BOOT_ENV_IMAGE_REDUNDANT,-r,) \
		-s $(PTXCONF_U_BOOT_ENV_IMAGE_SIZE) \
		-o $(U_BOOT_BUILD_DIR)/u-boot-env.img \
		$(U_BOOT_ENV_IMAGE_CUSTOM_SRC)
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/u-boot.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/u-boot.targetinstall:
	@$(call targetinfo)
	@$(call world/image-clean, U_BOOT)
ifdef PTXCONF_U_BOOT_INSTALL_U_BOOT_BIN
	@$(call ptx/image-install, U_BOOT, $(U_BOOT_BUILD_DIR)/u-boot.bin)
endif
ifdef PTXCONF_U_BOOT_INSTALL_SREC
	@$(call ptx/image-install, U_BOOT, $(U_BOOT_BUILD_DIR)/u-boot.srec)
endif
ifdef PTXCONF_U_BOOT_INSTALL_ELF
	@$(call ptx/image-install, U_BOOT, $(U_BOOT_BUILD_DIR)/u-boot, u-boot.elf)
endif
ifdef PTXCONF_U_BOOT_INSTALL_EFI_APPLICATION
	@$(call ptx/image-install, U_BOOT, $(U_BOOT_BUILD_DIR)/u-boot-app.efi)
endif
ifdef PTXCONF_U_BOOT_INSTALL_EFI_PAYLOAD
	@$(call ptx/image-install, U_BOOT, $(U_BOOT_BUILD_DIR)/u-boot-payload.efi)
endif
ifdef PTXCONF_U_BOOT_INSTALL_SPL
	@$(call ptx/image-install, U_BOOT, $(U_BOOT_BUILD_DIR)/SPL)
endif
ifdef PTXCONF_U_BOOT_INSTALL_MLO
	@$(call ptx/image-install, U_BOOT, $(U_BOOT_BUILD_DIR)/MLO)
endif
ifdef PTXCONF_U_BOOT_INSTALL_U_BOOT_IMG
	@$(call ptx/image-install, U_BOOT, $(U_BOOT_BUILD_DIR)/u-boot.img)
endif
ifdef PTXCONF_U_BOOT_INSTALL_U_BOOT_IMX
	@$(call ptx/image-install, U_BOOT, $(U_BOOT_BUILD_DIR)/u-boot.imx)
endif
ifdef PTXCONF_U_BOOT_INSTALL_U_BOOT_DTB_IMX
	@$(call ptx/image-install, U_BOOT, $(U_BOOT_BUILD_DIR)/u-boot-dtb.imx)
endif
ifdef PTXCONF_U_BOOT_INSTALL_U_BOOT_DTB
	@$(call ptx/image-install, U_BOOT, $(U_BOOT_BUILD_DIR)/u-boot-dtb.bin)
endif
ifdef PTXCONF_U_BOOT_INSTALL_U_BOOT_WITH_SPL_PBL
	@$(call ptx/image-install, U_BOOT, $(U_BOOT_BUILD_DIR)/u-boot-with-spl-pbl.bin)
endif
ifdef PTXCONF_U_BOOT_INSTALL_U_BOOT_STM32
	@$(call ptx/image-install, U_BOOT, $(U_BOOT_BUILD_DIR)/u-boot.stm32)
endif
ifdef PTXCONF_U_BOOT_INSTALL_U_BOOT_FLASH_BIN
	@$(call ptx/image-install, U_BOOT, $(U_BOOT_BUILD_DIR)/flash.bin)
endif
ifndef PTXCONF_U_BOOT_ENV_IMAGE_NONE
	@$(call ptx/image-install, U_BOOT, $(U_BOOT_BUILD_DIR)/u-boot-env.img)
endif

ifdef PTXCONF_U_BOOT_BOOT_SCRIPT
	@$(call install_init, u-boot)
	@$(call install_fixup, u-boot, PRIORITY, optional)
	@$(call install_fixup, u-boot, SECTION, base)
	@$(call install_fixup, u-boot, AUTHOR, "Ahmad Fatoum <afa@pengutronix.de>")
	@$(call install_fixup, u-boot, DESCRIPTION, "U-Boot boot script")

	@$(call install_copy, u-boot, 0, 0, 0644, \
		$(U_BOOT_BUILD_DIR)/boot.scr.uimg, $(U_BOOT_BOOT_SCRIPT_BIN))

	@$(call install_finish, u-boot)
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/u-boot.clean:
	@$(call targetinfo)
	@$(call clean_pkg, U_BOOT)

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

ifdef PTXCONF_U_BOOT_CONFIGSYSTEM_KCONFIG
u-boot_oldconfig u-boot_menuconfig u-boot_nconfig: $(STATEDIR)/u-boot.extract
	@$(call world/kconfig, U_BOOT, $(subst u-boot_,,$@))
endif

# vim: syntax=make
