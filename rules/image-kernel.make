# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_KERNEL) += image-kernel

#
# Paths and names
#
IMAGE_KERNEL		:= image-kernel
IMAGE_KERNEL_IMAGE	:= $(IMAGEDIR)/linuximage

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

$(IMAGE_KERNEL_IMAGE): $(STATEDIR)/kernel.install.post
	@$(call targetinfo)

ifdef PTXCONF_IMAGE_KERNEL_INITRAMFS
	@echo "Creating '$(KERNEL_IMAGE)' including '$(notdir $(IMAGE_ROOT_CPIO_IMAGE))'..."
	@sed -i -e 's,^CONFIG_INITRAMFS_SOURCE.*$$,CONFIG_INITRAMFS_SOURCE=\"$(IMAGE_ROOT_CPIO_IMAGE)\",g' \
		$(KERNEL_BUILD_DIR)/.config
	@$(call compile, KERNEL, $(KERNEL_MAKE_OPT) $(KERNEL_IMAGE))
endif

	@echo "Creating '$(notdir $(@))' from '$(notdir $(KERNEL_IMAGE_PATH_y))'..."
	@install -m 644 "$(KERNEL_IMAGE_PATH_y)" "$(@)"

	@$(call finish)

# vim: syntax=make
