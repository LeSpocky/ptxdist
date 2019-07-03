# -*-makefile-*-
#
# Copyright (C) 2005 Ladislav Michl <ladis@linux-mips.org>
#               2006, 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MODULE_INIT_TOOLS) += module-init-tools

#
# Paths and names
#
MODULE_INIT_TOOLS_VERSION	:= 3.16
MODULE_INIT_TOOLS_MD5		:= bc44832c6e41707b8447e2847d2019f5
MODULE_INIT_TOOLS		:= module-init-tools-$(MODULE_INIT_TOOLS_VERSION)
MODULE_INIT_TOOLS_SUFFIX	:= tar.bz2
MODULE_INIT_TOOLS_URL		:= $(call ptx/mirror, KERNEL, utils/kernel/module-init-tools/$(MODULE_INIT_TOOLS).$(MODULE_INIT_TOOLS_SUFFIX))
MODULE_INIT_TOOLS_SOURCE	:= $(SRCDIR)/$(MODULE_INIT_TOOLS).$(MODULE_INIT_TOOLS_SUFFIX)
MODULE_INIT_TOOLS_DIR		:= $(BUILDDIR)/$(MODULE_INIT_TOOLS)
MODULE_INIT_TOOLS_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MODULE_INIT_TOOLS_PATH	:= PATH=$(CROSS_PATH)
MODULE_INIT_TOOLS_ENV 	:= $(CROSS_ENV)
MODULE_INIT_TOOLS_MAKEVARS := MAN5="" MAN8=""

#
# autoconf
#
MODULE_INIT_TOOLS_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/module-init-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, module-init-tools)
	@$(call install_fixup, module-init-tools,PRIORITY,optional)
	@$(call install_fixup, module-init-tools,SECTION,base)
	@$(call install_fixup, module-init-tools,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, module-init-tools,DESCRIPTION,missing)

ifdef PTXCONF_MODULE_INIT_TOOLS_INSMOD
	@$(call install_copy, module-init-tools, 0, 0, 0755, -, /usr/sbin/insmod)
endif
ifdef PTXCONF_MODULE_INIT_TOOLS_RMMOD
	@$(call install_copy, module-init-tools, 0, 0, 0755, -, /usr/sbin/rmmod)
endif
ifdef PTXCONF_MODULE_INIT_TOOLS_LSMOD
	@$(call install_copy, module-init-tools, 0, 0, 0755, -, /usr/bin/lsmod)
endif
ifdef PTXCONF_MODULE_INIT_TOOLS_MODINFO
	@$(call install_copy, module-init-tools, 0, 0, 0755, -, /usr/sbin/modinfo)
endif
ifdef PTXCONF_MODULE_INIT_TOOLS_MODPROBE
	@$(call install_copy, module-init-tools, 0, 0, 0755, -, /usr/sbin/modprobe)
endif
ifdef PTXCONF_MODULE_INIT_TOOLS_DEPMOD
	@$(call install_copy, module-init-tools, 0, 0, 0755, -, /usr/sbin/depmod)
endif

	@$(call install_finish, module-init-tools)

	@$(call touch)

# vim: syntax=make
