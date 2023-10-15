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
PACKAGES-$(PTXCONF_PYTHON3_SCIKIT_LEARN) += python3-scikit-learn

#
# Paths and names
#
PYTHON3_SCIKIT_LEARN_VERSION		:= 1.3.1
PYTHON3_SCIKIT_LEARN_MD5		:= 7f53fc2b70a4c1df207e1efc9ddbae33
PYTHON3_SCIKIT_LEARN			:= scikit-learn-$(PYTHON3_SCIKIT_LEARN_VERSION)
PYTHON3_SCIKIT_LEARN_SUFFIX		:= tar.gz
PYTHON3_SCIKIT_LEARN_URL		:= $(call ptx/mirror-pypi, scikit-learn, $(PYTHON3_SCIKIT_LEARN).$(PYTHON3_SCIKIT_LEARN_SUFFIX))
PYTHON3_SCIKIT_LEARN_SOURCE		:= $(SRCDIR)/$(PYTHON3_SCIKIT_LEARN).$(PYTHON3_SCIKIT_LEARN_SUFFIX)
PYTHON3_SCIKIT_LEARN_DIR		:= $(BUILDDIR)/$(PYTHON3_SCIKIT_LEARN)
PYTHON3_SCIKIT_LEARN_LICENSE		:= BSD-3-Clause
PYTHON3_SCIKIT_LEARN_LICENSE_FILES	:= \
	file://COPYING;md5=e087d8348a7a6d2b63e1f305d7acf1a9

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_SCIKIT_LEARN_CONF_ENV	:= \
	$(CROSS_ENV) \
	PYTHON_CROSSENV=1

PYTHON3_SCIKIT_LEARN_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-scikit-learn.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-scikit-learn)
	@$(call install_fixup, python3-scikit-learn,PRIORITY,optional)
	@$(call install_fixup, python3-scikit-learn,SECTION,base)
	@$(call install_fixup, python3-scikit-learn,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python3-scikit-learn,DESCRIPTION,missing)

	@$(call install_glob, python3-scikit-learn, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-scikit-learn)

	@$(call touch)

# vim: syntax=make
