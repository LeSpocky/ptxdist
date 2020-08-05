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
PACKAGES-$(PTXCONF_PYTHON3_MORE_ITERTOOLS) += python3-more-itertools

#
# Paths and names
#
PYTHON3_MORE_ITERTOOLS_VERSION	:= 8.4.0
PYTHON3_MORE_ITERTOOLS_MD5	:= 0912041c05148ed079984cff69af2e99
PYTHON3_MORE_ITERTOOLS		:= more-itertools-$(PYTHON3_MORE_ITERTOOLS_VERSION)
PYTHON3_MORE_ITERTOOLS_SUFFIX	:= tar.gz
PYTHON3_MORE_ITERTOOLS_URL	:= https://pypi.python.org/packages/source/m/more-itertools/$(PYTHON3_MORE_ITERTOOLS).$(PYTHON3_MORE_ITERTOOLS_SUFFIX)
PYTHON3_MORE_ITERTOOLS_SOURCE	:= $(SRCDIR)/$(PYTHON3_MORE_ITERTOOLS).$(PYTHON3_MORE_ITERTOOLS_SUFFIX)
PYTHON3_MORE_ITERTOOLS_DIR	:= $(BUILDDIR)/$(PYTHON3_MORE_ITERTOOLS)
PYTHON3_MORE_ITERTOOLS_LICENSE	:= MIT
PYTHON3_MORE_ITERTOOLS_LICENSE_FILES := \
	file://LICENSE;md5=3396ea30f9d21389d7857719816f83b5

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_MORE_ITERTOOLS_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-more-itertools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-more-itertools)
	@$(call install_fixup, python3-more-itertools, PRIORITY, optional)
	@$(call install_fixup, python3-more-itertools, SECTION, base)
	@$(call install_fixup, python3-more-itertools, AUTHOR, "Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, python3-more-itertools, DESCRIPTION, missing)

	@$(call install_glob, python3-more-itertools, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-more-itertools)

	@$(call touch)

# vim: syntax=make
