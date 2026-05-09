# -*-makefile-*-
#
# Copyright (C) 2022 by Alexander Dahl <ada@thorsis.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NUMACTL) += numactl

#
# Paths and names
#
NUMACTL_VERSION	:= 2.0.14
NUMACTL_SHA256	:= 826bd148c1b6231e1284e42a4db510207747484b112aee25ed6b1078756bcff6
NUMACTL		:= numactl-$(NUMACTL_VERSION)
NUMACTL_SUFFIX	:= tar.gz
NUMACTL_URL	:= https://github.com/numactl/numactl/releases/download/v$(NUMACTL_VERSION)/$(NUMACTL).$(NUMACTL_SUFFIX)
NUMACTL_SOURCE	:= $(SRCDIR)/$(NUMACTL).$(NUMACTL_SUFFIX)
NUMACTL_DIR	:= $(BUILDDIR)/$(NUMACTL)
NUMACTL_LICENSE	:= LGPL-2.1 AND GPL-2.0
NUMACTL_LICENSE_FILES := \
	file://README.md;startline=25;endline=47;md5=0ca89e009b5e838824a114916c20e382 \
	file://LICENSE.GPL2;md5=751419260aa954499f7abaabaa882bbe \
	file://LICENSE.LGPL2.1;md5=4fbd65380cdd255951079008b364516c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NUMACTL_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/numactl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, numactl)
	@$(call install_fixup, numactl,PRIORITY,optional)
	@$(call install_fixup, numactl,SECTION,base)
	@$(call install_fixup, numactl,AUTHOR,"Alexander Dahl <ada@thorsis.com>")
	@$(call install_fixup, numactl,DESCRIPTION,missing)

ifdef PTXCONF_NUMACTL_NUMACTL
	@$(call install_copy, numactl, 0, 0, 0755, -, /usr/bin/numactl)
endif

	@$(call install_lib, numactl, 0, 0, 0644, libnuma)

	@$(call install_finish, numactl)

	@$(call touch)

# vim: ft=make noet tw=72 ts=8 sw=8
