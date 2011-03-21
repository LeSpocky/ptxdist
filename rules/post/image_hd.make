# -*-makefile-*-
#
# Copyright (C) 2003-2010 by the ptxdist project <ptxdist@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

SEL_ROOTFS-$(PTXCONF_IMAGE_HD)		+= $(IMAGEDIR)/hd.img

ifdef PTXCONF_IMAGE_HD_PART1
	GENHDIMARGS = -p $(PTXCONF_IMAGE_HD_PART1_START):$(PTXCONF_IMAGE_HD_PART1_END):$(PTXCONF_IMAGE_HD_PART1_TYPE):$(IMAGEDIR)/root.ext2
endif
ifdef PTXCONF_IMAGE_HD_PART2
ifdef PTXCONF_BAREBOX
	GENHDIMARGS += -p $(PTXCONF_IMAGE_HD_PART2_START):$(PTXCONF_IMAGE_HD_PART2_END):$(PTXCONF_IMAGE_HD_PART2_TYPE):$(IMAGEDIR)/linuximage
else
	GENHDIMARGS += -p $(PTXCONF_IMAGE_HD_PART2_START):$(PTXCONF_IMAGE_HD_PART2_END):$(PTXCONF_IMAGE_HD_PART2_TYPE):
endif
endif
ifdef PTXCONF_IMAGE_HD_PART3
	GENHDIMARGS += -p $(PTXCONF_IMAGE_HD_PART3_START):$(PTXCONF_IMAGE_HD_PART3_END):$(PTXCONF_IMAGE_HD_PART3_TYPE):
endif
ifdef PTXCONF_IMAGE_HD_PART4
	GENHDIMARGS += -p $(PTXCONF_IMAGE_HD_PART4_START):$(PTXCONF_IMAGE_HD_PART4_END):$(PTXCONF_IMAGE_HD_PART4_TYPE):
endif

$(IMAGEDIR)/hd.img: $(IMAGEDIR)/root.ext2
	@echo "Creating hdimg from root.ext2";					\
	PATH=$(PTXCONF_SYSROOT_HOST)/bin:$$PATH $(PTXDIST_TOPDIR)/scripts/genhdimg	\
	-o $@ $(GENHDIMARGS)
ifdef PTXCONF_GRUB
	@echo
	@echo "-----------------------------------"
	@echo "Making the image bootable with grub"
	@echo "-----------------------------------"
	@ptxd_make_bootable $@ $(PTXCONF_IMAGE_HD_PART1_START) $(GRUB_DIR)/stage1/stage1 $(GRUB_DIR)/stage2/stage2
endif
ifdef PTXCONF_BAREBOX
	@echo
	@echo "--------------------------------------"
	@echo "Making the image bootable with barebox"
	@echo "--------------------------------------"
ifdef PTXCONF_ARCH_X86
	@$(BAREBOX_DIR)/scripts/setupmbr/setupmbr -s 32 -m $(IMAGEDIR)/barebox-image -d $@
else
	@ptxd_make_bootable $@ $(PTXCONF_IMAGE_HD_PART1_START) $(IMAGEDIR)/barebox-image
endif
endif
	@echo "done."

# vim: syntax=make
