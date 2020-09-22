# -*-makefile-*-
#
# Copyright (C) 2020 by Bastian Krause <bst@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_JINJA2) += python3-jinja2

PYTHON3_JINJA2_VERSION	:= 2.11.2
PYTHON3_JINJA2_MD5	:= 0362203b22547abca06ed1082bc1e7b4
PYTHON3_JINJA2		:= Jinja2-$(PYTHON3_JINJA2_VERSION)
PYTHON3_JINJA2_SUFFIX	:= tar.gz
PYTHON3_JINJA2_URL	:= $(call ptx/mirror-pypi, jinja2, $(PYTHON3_JINJA2).$(PYTHON3_JINJA2_SUFFIX))
PYTHON3_JINJA2_SOURCE	:= $(SRCDIR)/$(PYTHON3_JINJA2).$(PYTHON3_JINJA2_SUFFIX)
PYTHON3_JINJA2_DIR	:= $(BUILDDIR)/$(PYTHON3_JINJA2)
PYTHON3_JINJA2_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_JINJA2_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-jinja2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-jinja2)
	@$(call install_fixup,python3-jinja2,PRIORITY,optional)
	@$(call install_fixup,python3-jinja2,SECTION,base)
	@$(call install_fixup,python3-jinja2,AUTHOR,"Bastian Krause <bst@pengutronix.de>")
	@$(call install_fixup,python3-jinja2,DESCRIPTION,missing)

	@$(call install_glob, python3-jinja2, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish,python3-jinja2)

	@$(call touch)

# vim: syntax=make
