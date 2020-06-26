# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_HDIMG) += image-hdimg

#
# Paths and names
#
IMAGE_HDIMG		:= image-hdimg
IMAGE_HDIMG_DIR		:= $(BUILDDIR)/$(IMAGE_HDIMG)
IMAGE_HDIMG_IMAGE	:= $(IMAGEDIR)/hd.img
IMAGE_HDIMG_CONFIG	:= hd.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

ifdef PTXCONF_IMAGE_HDIMG
IMAGE_HDIMG_BOOTLOADER_ENV := \
	BOOTLOADER_IMAGES='' \
	BOOTLOADER_PARTITIONS=''

ifdef PTXCONF_IMAGE_HDIMG_GRUB
IMAGE_HDIMG_BOOTLOADER_ENV = \
	GRUB_STAGE_DIR=$(GRUB_STAGE_DIR) \
	BOOTLOADER_IMAGES='include("grub.config")' \
	BOOTLOADER_PARTITIONS='include("grub_partitions.config")'
endif
ifdef PTXCONF_IMAGE_HDIMG_BAREBOX
IMAGE_HDIMG_BOOTLOADER_ENV := \
	BOOTLOADER_IMAGES='' \
	BOOTLOADER_PARTITIONS='include("barebox_partitions.config")'
endif
ifdef PTXCONF_IMAGE_HDIMG_VFAT
IMAGE_HDIMG_BOOTLOADER_ENV := \
	BOOTLOADER_IMAGES='' \
	BOOTLOADER_PARTITIONS='include("vfat_partitions.config")'

ifdef PTXCONF_IMAGE_HDIMG_GPT
IMAGE_HDIMG_BOOTLOADER_ENV += \
	VFAT_PARTITION_TYPE=$(call ptx/ifdef, PTXCONF_IMAGE_BOOT_VFAT_EFI_BAREBOX,U,F)
else
IMAGE_HDIMG_BOOTLOADER_ENV += \
	VFAT_PARTITION_TYPE=$(call ptx/ifdef, PTXCONF_IMAGE_BOOT_VFAT_EFI_BAREBOX,0xef,0x0c)
endif
endif

IMAGE_HDIMG_ENV = \
	GPT=$(call ptx/ifdef, PTXCONF_IMAGE_HDIMG_GPT,true,false) \
	PARTITION_TYPE_SUFFIX=$(call ptx/ifdef, PTXCONF_IMAGE_HDIMG_GPT,-uuid) \
	ROOT_PARTITION_TYPE=$(call ptx/ifdef, PTXCONF_IMAGE_HDIMG_GPT,L,0x83) \
	$(IMAGE_HDIMG_BOOTLOADER_ENV)

$(IMAGE_HDIMG_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_HDIMG)
	@$(call finish)
endif

# vim: syntax=make
