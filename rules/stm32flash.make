# -*-makefile-*-
#
# Copyright (C) 2018 by Guillermo Rodriguez <guille.rodriguez@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_STM32FLASH) += stm32flash

#
# Paths and names
#
STM32FLASH_VERSION		:= 0.7
STM32FLASH_SUFFIX		:= tar.gz
STM32FLASH_SHA256		:= c4c9cd8bec79da63b111d15713ef5cc2cd947deca411d35d6e3065e227dc414a
STM32FLASH			:= stm32flash-$(STM32FLASH_VERSION)
STM32FLASH_URL			:= $(call ptx/mirror, SF, stm32flash/$(STM32FLASH).$(STM32FLASH_SUFFIX))
STM32FLASH_DIR			:= $(BUILDDIR)/$(STM32FLASH)
STM32FLASH_SOURCE		:= $(SRCDIR)/$(STM32FLASH).$(STM32FLASH_SUFFIX)
STM32FLASH_LICENSE		:= GPL-2.0-or-later
STM32FLASH_LICENSE_FILES	:= \
	file://gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

STM32FLASH_CONF_TOOL	:= NO
STM32FLASH_MAKE_ENV	:= $(CROSS_ENV)
STM32FLASH_INSTALL_OPT	:= PREFIX=/usr install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/stm32flash.targetinstall:
	@$(call targetinfo)

	@$(call install_init, stm32flash)
	@$(call install_fixup, stm32flash, PRIORITY,optional)
	@$(call install_fixup, stm32flash, SECTION,base)
	@$(call install_fixup, stm32flash, AUTHOR,"Guillermo Rodriguez <guille.rodriguez@gmail.com>")
	@$(call install_fixup, stm32flash, DESCRIPTION,missing)

	@$(call install_copy, stm32flash, 0, 0, 0755, -, /usr/bin/stm32flash)

	@$(call install_finish, stm32flash)

	@$(call touch)

# vim: syntax=make
