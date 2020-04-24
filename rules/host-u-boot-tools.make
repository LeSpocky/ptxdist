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
HOST_PACKAGES-$(PTXCONF_HOST_U_BOOT_TOOLS) += host-u-boot-tools


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_U_BOOT_TOOLS_CONF_TOOL	:= NO
HOST_U_BOOT_TOOLS_MAKE_OPT	:= tools-only_defconfig tools-only NO_SDL=1

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

HOST_U_BOOT_TOOLS_PROGS := \
	fit_check_sign \
	mkenvimage \
	mkimage

$(STATEDIR)/host-u-boot-tools.install:
	@$(call targetinfo)
	@$(foreach prog, $(HOST_U_BOOT_TOOLS_PROGS), \
		install -vD $(HOST_U_BOOT_TOOLS_DIR)/tools/$(prog) \
		$(HOST_U_BOOT_TOOLS_PKGDIR)/bin/$(prog)$(ptx/nl))

	@$(call touch)

# vim: syntax=make
