# -*-makefile-*-
#
# Copyright (C) 2020 by Lucas Stach <l.stach@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_CONFIGSHELL) += python3-configshell

#
# Paths and names
#
PYTHON3_CONFIGSHELL_VERSION	:= 1.1.28
PYTHON3_CONFIGSHELL_MD5		:= effc6c44784e5cd77e2eacd07bef494d
PYTHON3_CONFIGSHELL		:= configshell-fb-$(PYTHON3_CONFIGSHELL_VERSION)
PYTHON3_CONFIGSHELL_SUFFIX	:= tar.gz
PYTHON3_CONFIGSHELL_URL		:= https://pypi.io/packages/source/c/configshell-fb/$(PYTHON3_CONFIGSHELL).$(PYTHON3_CONFIGSHELL_SUFFIX)
PYTHON3_CONFIGSHELL_SOURCE	:= $(SRCDIR)/$(PYTHON3_CONFIGSHELL).$(PYTHON3_CONFIGSHELL_SUFFIX)
PYTHON3_CONFIGSHELL_DIR		:= $(BUILDDIR)/$(PYTHON3_CONFIGSHELL)
PYTHON3_CONFIGSHELL_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# python3
#
PYTHON3_CONFIGSHELL_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-configshell.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-configshell)
	@$(call install_fixup, python3-configshell,PRIORITY,optional)
	@$(call install_fixup, python3-configshell,SECTION,base)
	@$(call install_fixup, python3-configshell,AUTHOR,"Lucas Stach <l.stach@pengutronix.de>")
	@$(call install_fixup, python3-configshell,DESCRIPTION,missing)

	@$(call install_glob, python3-configshell, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES)/configshell_fb,, *.py)

	@$(call install_finish, python3-configshell)

	@$(call touch)

# vim: syntax=make
