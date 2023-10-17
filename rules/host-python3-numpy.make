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
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_NUMPY) += host-python3-numpy

#
# Paths and names
#
HOST_PYTHON3_NUMPY_DIR		= $(HOST_BUILDDIR)/$(HOST_PYTHON3_NUMPY)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_NUMPY_CONF_ENV	:= \
	$(HOST_ENV) \
	SETUPTOOLS_USE_DISTUTILS=stdlib \
	NPY_DISABLE_SVML=1

HOST_PYTHON3_NUMPY_CONF_TOOL	:= python3

HOST_PYTHON3_NUMPY_CXXFLAGS	:= \
	-std=c++11

$(STATEDIR)/host-python3-numpy.prepare:
	@$(call targetinfo)
	@$(call world/prepare, HOST_PYTHON3_NUMPY)
	@echo -e '[DEFAULT]\nlibrary_dirs =\ninclude_dirs =' > $(HOST_PYTHON3_NUMPY_DIR)/site.cfg
	@$(call touch)

# vim: syntax=make
