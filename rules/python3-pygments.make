# -*-makefile-*-
#
# Copyright (C) 2026 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_PYGMENTS) += python3-pygments

#
# Paths and names
#
PYTHON3_PYGMENTS_VERSION	:= 2.19.2
PYTHON3_PYGMENTS_MD5		:= 79260d1c566a507953a81d24b1c51c72
PYTHON3_PYGMENTS		:= pygments-$(PYTHON3_PYGMENTS_VERSION)
PYTHON3_PYGMENTS_SUFFIX		:= tar.gz
PYTHON3_PYGMENTS_URL		:= $(call ptx/mirror-pypi, Pygments, $(PYTHON3_PYGMENTS).$(PYTHON3_PYGMENTS_SUFFIX))
PYTHON3_PYGMENTS_SOURCE		:= $(SRCDIR)/$(PYTHON3_PYGMENTS).$(PYTHON3_PYGMENTS_SUFFIX)
PYTHON3_PYGMENTS_DIR		:= $(BUILDDIR)/$(PYTHON3_PYGMENTS)
PYTHON3_PYGMENTS_LICENSE	:= BSD-2-Clause
PYTHON3_PYGMENTS_LICENSE_FILES	:= file://LICENSE;md5=36a13c90514e2899f1eba7f41c3ee592

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PYGMENTS_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pygments.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pygments)
	@$(call install_fixup, python3-pygments,PRIORITY,optional)
	@$(call install_fixup, python3-pygments,SECTION,base)
	@$(call install_fixup, python3-pygments,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python3-pygments,DESCRIPTION,missing)

	@$(call install_glob, python3-pygments, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-pygments)

	@$(call touch)

# vim: ft=make
