# -*-makefile-*-
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_THREADPOOLCTL) += python3-threadpoolctl

#
# Paths and names
#
PYTHON3_THREADPOOLCTL_VERSION		:= 3.2.0
PYTHON3_THREADPOOLCTL_MD5		:= b1d5f56e410df7022c38883d51b6a24c
PYTHON3_THREADPOOLCTL			:= threadpoolctl-$(PYTHON3_THREADPOOLCTL_VERSION)
PYTHON3_THREADPOOLCTL_SUFFIX		:= tar.gz
PYTHON3_THREADPOOLCTL_URL		:= $(call ptx/mirror-pypi, threadpoolctl, $(PYTHON3_THREADPOOLCTL).$(PYTHON3_THREADPOOLCTL_SUFFIX))
PYTHON3_THREADPOOLCTL_SOURCE		:= $(SRCDIR)/$(PYTHON3_THREADPOOLCTL).$(PYTHON3_THREADPOOLCTL_SUFFIX)
PYTHON3_THREADPOOLCTL_DIR		:= $(BUILDDIR)/$(PYTHON3_THREADPOOLCTL)
PYTHON3_THREADPOOLCTL_LICENSE		:= BSD-3-Clause
PYTHON3_THREADPOOLCTL_LICENSE_FILES	:= file://LICENSE;md5=8f2439cfddfbeebdb5cac3ae4ae80eaf

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_THREADPOOLCTL_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-threadpoolctl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-threadpoolctl)
	@$(call install_fixup, python3-threadpoolctl,PRIORITY,optional)
	@$(call install_fixup, python3-threadpoolctl,SECTION,base)
	@$(call install_fixup, python3-threadpoolctl,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python3-threadpoolctl,DESCRIPTION,missing)

	@$(call install_tree, python3-threadpoolctl, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES))

	@$(call install_finish, python3-threadpoolctl)

	@$(call touch)

# vim: syntax=make
