# -*-makefile-*-
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

SEL_ROOTFS-$(PTXCONF_IMAGE_KERNEL) += $(IMAGEDIR)/linuximage
SEL_ROOTFS-$(PTXCONF_IMAGE_KERNEL_LZOP) += $(IMAGEDIR)/linuximage.lzo
SEL_ROOTFS-$(PTXCONF_IMAGE_KERNEL_APPENDED_DTB_ZIMAGE) += $(IMAGEDIR)/linux_dtb.zImage
SEL_ROOTFS-$(PTXCONF_IMAGE_KERNEL_APPENDED_DTB_UIMAGE) += $(IMAGEDIR)/linux_dtb.uImage

ifdef PTXCONF_IMAGE_KERNEL_INITRAMFS
$(IMAGEDIR)/linuximage: $(STATEDIR)/image_kernel.compile
endif

$(STATEDIR)/image_kernel.compile: $(IMAGEDIR)/root.cpio
	@echo -n "Creating '$(KERNEL_IMAGE)' including '$(notdir $(<))'..."
	@sed -i -e 's,^CONFIG_INITRAMFS_SOURCE.*$$,CONFIG_INITRAMFS_SOURCE=\"$(<)\",g' \
		$(KERNEL_DIR)/.config
	@cd $(KERNEL_DIR) && $(KERNEL_PATH) $(KERNEL_ENV) $(MAKE) \
		$(KERNEL_MAKEVARS) $(KERNEL_IMAGE)
	@echo "done."

$(IMAGEDIR)/linuximage: $(STATEDIR)/kernel.targetinstall
	@echo -n "Creating '$(notdir $(@))' from '$(notdir $(KERNEL_IMAGE_PATH_y))'..."
	@install -m 644 "$(KERNEL_IMAGE_PATH_y)" "$(@)"
	@echo "done."

$(IMAGEDIR)/linuximage.lzo: $(IMAGEDIR)/linuximage
	@echo -n "Creating '$(notdir $(@))' from '$(notdir $(<))'..."
	@lzop -f $(call remove_quotes,$(PTXCONF_IMAGE_KERNEL_LZOP_EXTRA_ARGS)) -c "$(<)" > "$(@)"
	@echo "done."

$(IMAGEDIR)/linux_dtb.zImage: $(IMAGEDIR)/linuximage $(STATEDIR)/dtc.targetinstall
	@echo -n "Creating '$(notdir $(@))' from '$(notdir $(<))' ..."
	@cat "$(<)" "$(IMAGEDIR)/$(call remove_quotes,$(PTXCONF_IMAGE_KERNEL_APPENDED_DTB_FILE))" > "$(@)"
	@echo ' done.'

#
# Create architecture type for mkimage
# Most architectures are working with label $(PTXCONF_ARCH_STRING)
# but the i386 family needs "x86" instead!
#
ifeq ($(PTXCONF_ARCH_STRING),"i386")
MKIMAGE_ARCH := x86
else
MKIMAGE_ARCH := $(PTXCONF_ARCH_STRING)
endif

$(IMAGEDIR)/linux_dtb.uImage: $(IMAGEDIR)/linux_dtb.zImage
	@echo "Creating '$(notdir $(@))' from '$(notdir $(<))' ..."
	@$(PTXCONF_SYSROOT_HOST)/bin/mkimage \
			-A $(MKIMAGE_ARCH) \
			-O linux \
			-T kernel \
			-C none \
			-a $(PTXCONF_KERNEL_LOADADDR) \
			-e $(PTXCONF_KERNEL_LOADADDR) \
			-n "Linux-$(KERNEL_VERSION)" \
			-d "$(<)" \
			"$(@)"
	@echo 'Done.'

# vim: syntax=make
