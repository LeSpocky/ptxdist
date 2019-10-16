# -*-makefile-*-
#
# Copyright (C) 2019 by Sascha Hauer <s.hauer@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_KERNEL_FIT_INSTALL
PACKAGES-$(PTXCONF_KERNEL_FIT) += kernel-fit
else
EXTRA_PACKAGES-$(PTXCONF_KERNEL_FIT) += kernel-fit
endif

#
# Paths and names
#
KERNEL_FIT_VERSION		:= $(KERNEL_VERSION)
KERNEL_FIT_IMAGE		:= $(IMAGEDIR)/linuximage.fit
ifdef PTXCONF_KERNEL_FIT_SIGNED
KERNEL_FIT_SIGN_ROLE		:= image-kernel-fit
KERNEL_FIT_KEY_NAME_HINT	:= image-kernel-fit
endif
KERNEL_FIT_KERNEL		 = $(KERNEL_IMAGE_PATH_y)
ifdef PTXCONF_KERNEL_FIT_INITRAMFS
KERNEL_FIT_INITRAMFS		:= $(IMAGEDIR)/root.cpio
endif
KERNEL_FIT_DTB			 = $(DTC_DTB)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel-fit.targetinstall:
	@$(call targetinfo)

	@$(call world/image-fit, KERNEL_FIT)

ifdef PTXCONF_KERNEL_FIT_INSTALL
	@$(call install_init, kernel-fit)
	@$(call install_fixup,kernel-fit,PRIORITY,optional)
	@$(call install_fixup,kernel-fit,SECTION,base)
	@$(call install_fixup,kernel-fit,AUTHOR,Sascha Hauer <s.hauer@pengutronix.de>)
	@$(call install_fixup,kernel-fit,DESCRIPTION,missing)

	@$(call install_copy, kernel-fit, 0, 0, 0644, $(KERNEL_FIT_IMAGE), /boot/linux.fit)

	@$(call install_finish,kernel-fit)
endif

	@$(call touch)

# vim: syntax=make
