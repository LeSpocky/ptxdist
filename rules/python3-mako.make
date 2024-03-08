# -*-makefile-*-
#
# Copyright (C) 2017 by Lucas Stach <l.stach@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_MAKO) += python3-mako

#
# Paths and names
#
PYTHON3_MAKO_VERSION	:= 1.3.2
PYTHON3_MAKO_MD5	:= 0500a3df18f02c9e53fe3a9314c1a1ae
PYTHON3_MAKO		:= Mako-$(PYTHON3_MAKO_VERSION)
PYTHON3_MAKO_SUFFIX	:= tar.gz
PYTHON3_MAKO_URL	:= $(call ptx/mirror-pypi, Mako, $(PYTHON3_MAKO).$(PYTHON3_MAKO_SUFFIX))
PYTHON3_MAKO_SOURCE	:= $(SRCDIR)/$(PYTHON3_MAKO).$(PYTHON3_MAKO_SUFFIX)
PYTHON3_MAKO_DIR	:= $(BUILDDIR)/python3-$(PYTHON3_MAKO)
PYTHON3_MAKO_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_MAKO_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-mako.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-mako)
	@$(call install_fixup, python3-mako,PRIORITY,optional)
	@$(call install_fixup, python3-mako,SECTION,base)
	@$(call install_fixup, python3-mako,AUTHOR,"Lucas Stach <l.stach@pengutronix.de>")
	@$(call install_fixup, python3-mako,DESCRIPTION,missing)

	@$(call install_glob, python3-mako, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES)/mako,, *.py)

	@$(call install_finish, python3-mako)

	@$(call touch)

# vim: syntax=make
