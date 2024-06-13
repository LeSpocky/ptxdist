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

PYTHON3_JINJA2_VERSION	:= 3.1.3
PYTHON3_JINJA2_MD5	:= caf5418c851eac59e70a78d9730d4cea
PYTHON3_JINJA2		:= Jinja2-$(PYTHON3_JINJA2_VERSION)
PYTHON3_JINJA2_SUFFIX	:= tar.gz
PYTHON3_JINJA2_URL	:= $(call ptx/mirror-pypi, jinja2, $(PYTHON3_JINJA2).$(PYTHON3_JINJA2_SUFFIX))
PYTHON3_JINJA2_SOURCE	:= $(SRCDIR)/$(PYTHON3_JINJA2).$(PYTHON3_JINJA2_SUFFIX)
PYTHON3_JINJA2_DIR	:= $(BUILDDIR)/$(PYTHON3_JINJA2)
PYTHON3_JINJA2_LICENSE	:= BSD-3-Clause
PYTHON3_JINJA2_LICENSE_FILES	:= \
	file://PKG-INFO;startline=6;endline=8;md5=9756d487e0b816adb26f07c9c1eea379 \
	file://LICENSE.rst;md5=5dc88300786f1c214c1e9827a5229462

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
