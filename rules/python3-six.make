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
PACKAGES-$(PTXCONF_PYTHON3_SIX) += python3-six

#
# Paths and names
#
PYTHON3_SIX_VERSION	:= 1.16.0
PYTHON3_SIX_MD5		:= a7c927740e4964dd29b72cebfc1429bb
PYTHON3_SIX		:= six-$(PYTHON3_SIX_VERSION)
PYTHON3_SIX_SUFFIX	:= tar.gz
PYTHON3_SIX_URL		:= $(call ptx/mirror-pypi, six, $(PYTHON3_SIX).$(PYTHON3_SIX_SUFFIX))
PYTHON3_SIX_SOURCE	:= $(SRCDIR)/$(PYTHON3_SIX).$(PYTHON3_SIX_SUFFIX)
PYTHON3_SIX_DIR		:= $(BUILDDIR)/python3-$(PYTHON3_SIX)
PYTHON3_SIX_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_SIX_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-six.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-six)
	@$(call install_fixup, python3-six,PRIORITY,optional)
	@$(call install_fixup, python3-six,SECTION,base)
	@$(call install_fixup, python3-six,AUTHOR,"Lucas Stach <l.stach@pengutronix.de>")
	@$(call install_fixup, python3-six,DESCRIPTION,missing)

	@$(call install_glob, python3-six, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-six)

	@$(call touch)

# vim: syntax=make
