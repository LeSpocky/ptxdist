# -*-makefile-*-
#
# Copyright (C) 2020 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_WCWIDTH) += python3-wcwidth

#
# Paths and names
#
PYTHON3_WCWIDTH_VERSION	:= 0.2.5
PYTHON3_WCWIDTH_MD5	:= a07a75f99d316e14838ac760c831ea37
PYTHON3_WCWIDTH		:= wcwidth-$(PYTHON3_WCWIDTH_VERSION)
PYTHON3_WCWIDTH_SUFFIX	:= tar.gz
PYTHON3_WCWIDTH_URL	:= https://pypi.python.org/packages/source/w/wcwidth/$(PYTHON3_WCWIDTH).$(PYTHON3_WCWIDTH_SUFFIX)
PYTHON3_WCWIDTH_SOURCE	:= $(SRCDIR)/$(PYTHON3_WCWIDTH).$(PYTHON3_WCWIDTH_SUFFIX)
PYTHON3_WCWIDTH_DIR	:= $(BUILDDIR)/$(PYTHON3_WCWIDTH)
PYTHON3_WCWIDTH_LICENSE	:= MIT
PYTHON3_WCWIDTH_LICENSE_FILES := \
	file://LICENSE;md5=b15979c39a2543892fca8cd86b4b52cb

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_WCWIDTH_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-wcwidth.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-wcwidth)
	@$(call install_fixup, python3-wcwidth, PRIORITY, optional)
	@$(call install_fixup, python3-wcwidth, SECTION, base)
	@$(call install_fixup, python3-wcwidth, AUTHOR, "Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, python3-wcwidth, DESCRIPTION, missing)

	@$(call install_glob, python3-wcwidth, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-wcwidth)

	@$(call touch)

# vim: syntax=make
