# -*-makefile-*-
#
# Copyright (C) 2012 by Andreas Bießmann <andreas@biessmann.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_U_BOOT_TOOLS) += u-boot-tools

#
# Paths and names
#
U_BOOT_TOOLS_VERSION	:= 2020.07
U_BOOT_TOOLS_MD5	:= 86e51eeccd15e658ad1df943a0edf622
U_BOOT_TOOLS		:= u-boot-$(U_BOOT_TOOLS_VERSION)
U_BOOT_TOOLS_SUFFIX	:= tar.bz2
U_BOOT_TOOLS_URL	:= https://ftp.denx.de/pub/u-boot/$(U_BOOT_TOOLS).$(U_BOOT_TOOLS_SUFFIX)
U_BOOT_TOOLS_SOURCE	:= $(SRCDIR)/$(U_BOOT_TOOLS).$(U_BOOT_TOOLS_SUFFIX)
U_BOOT_TOOLS_DIR	:= $(BUILDDIR)/u-boot-tools-$(U_BOOT_TOOLS_VERSION)
U_BOOT_TOOLS_PKGDIR	:= $(PKGDIR)/u-boot-tools-$(U_BOOT_TOOLS_VERSION)
U_BOOT_TOOLS_LICENSE	:= GPL-2.0-or-later AND Zlib
U_BOOT_TOOLS_LICENSE_FILES := \
	file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
	file://include/u-boot/zlib.h;startline=15;endline=43;md5=7c27ae0384929249664da410d539a1dc

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

U_BOOT_TOOLS_CONF_TOOL	:= NO
U_BOOT_TOOLS_MAKE_OPT	:= \
	CROSS_COMPILE=$(BOOTLOADER_CROSS_COMPILE) \
	tools-only_defconfig \
	envtools \
	NO_SDL=1

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/u-boot-tools.install:
	@$(call targetinfo)
	install -D $(U_BOOT_TOOLS_DIR)/tools/env/fw_printenv \
		$(U_BOOT_TOOLS_PKGDIR)/usr/sbin/fw_printenv
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/u-boot-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  u-boot-tools)
	@$(call install_fixup, u-boot-tools,PRIORITY,optional)
	@$(call install_fixup, u-boot-tools,SECTION,base)
	@$(call install_fixup, u-boot-tools,AUTHOR,\
		"Andreas Bießmann <andreas@biessmann.de>")
	@$(call install_fixup, u-boot-tools,DESCRIPTION,missing)

	@$(call install_copy, u-boot-tools, 0, 0, 0755, -, /usr/sbin/fw_printenv)
	@$(call install_link, u-boot-tools, fw_printenv, /usr/sbin/fw_setenv)
	@$(call install_alternative, u-boot-tools, 0, 0, 0644, /etc/fw_env.config)

	@$(call install_finish, u-boot-tools)

	@$(call touch)

# vim: syntax=make
