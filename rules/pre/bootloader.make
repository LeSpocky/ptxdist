# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# handle special compiler
#
ifdef PTXCONF_BOOTLOADER
    ifneq ($(PTXCONF_COMPILER_PREFIX),$(PTXCONF_COMPILER_PREFIX_BOOTLOADER))
        ifeq ($(wildcard selected_toolchain_bootloader/$(PTXCONF_COMPILER_PREFIX_BOOTLOADER)gcc),)
            $(call ptx/error, no 'selected_toolchain_bootloader' link found. Please create a link)
            $(call ptx/error, 'selected_toolchain_bootloader' to the bin directory of your)
            $(call ptx/error, '$(PTXCONF_COMPILER_PREFIX_BOOTLOADER)' toolchain)
        endif
        BOOTLOADER_TOOLCHAIN_LINK := $(PTXDIST_WORKSPACE)/selected_toolchain_bootloader/
    endif
endif

BOOTLOADER_CROSS_COMPILE := $(BOOTLOADER_TOOLCHAIN_LINK)$(PTXCONF_COMPILER_PREFIX_BOOTLOADER)

# vim: syntax=make
