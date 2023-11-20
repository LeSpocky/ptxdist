# -*-makefile-*-
#
# Copyright (C) 2019 by Guillermo Rodriguez <guille.rodriguez@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_NUMPY) += python3-numpy

#
# Paths and names
#
PYTHON3_NUMPY_VERSION	:= 1.26.0
PYTHON3_NUMPY_MD5	:= 69bd28f07afbeed2bb6ecd467afcd469
PYTHON3_NUMPY		:= numpy-$(PYTHON3_NUMPY_VERSION)
PYTHON3_NUMPY_SUFFIX	:= tar.gz
PYTHON3_NUMPY_URL	:= $(call ptx/mirror-pypi, numpy, $(PYTHON3_NUMPY).$(PYTHON3_NUMPY_SUFFIX))
PYTHON3_NUMPY_SOURCE	:= $(SRCDIR)/$(PYTHON3_NUMPY).$(PYTHON3_NUMPY_SUFFIX)
PYTHON3_NUMPY_DIR	:= $(BUILDDIR)/$(PYTHON3_NUMPY)
PYTHON3_NUMPY_LICENSE	:= BSD-3-Clause AND MIT AND Zlib
PYTHON3_NUMPY_LICENSE_FILES := \
	file://LICENSE.txt;md5=a752eb20459cf74a9d84ee4825e8317c \
	file://tools/npy_tempita/license.txt;md5=c66b85ddcd09296abff87601467724fd \
	file://numpy/core/src/multiarray/dragon4.c;startline=2;endline=20;md5=7f70862b43e17922c5adf18ec84fb720 \
	file://numpy/core/include/numpy/libdivide/LICENSE.txt;md5=e1c97b70a98c8ec5aff0aa275fdb2c91


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_NUMPY_CONF_ENV	:= \
	$(CROSS_ENV) \
	SETUPTOOLS_USE_DISTUTILS=stdlib \
	NPY_LAPACK_ORDER=openblas \
	OPENBLAS=$(SYSROOT)/usr/lib \
	NPY_DISABLE_SVML=1

PYTHON3_NUMPY_CONF_TOOL	:= python3

PYTHON3_NUMPY_CXXFLAGS	:= \
	-std=c++11

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-numpy.prepare:
	@$(call targetinfo)
	@$(call world/prepare, PYTHON3_NUMPY)
	@echo -e '[DEFAULT]\nlibrary_dirs =\ninclude_dirs =' > $(PYTHON3_NUMPY_DIR)/site.cfg
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-numpy.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-numpy)
	@$(call install_fixup, python3-numpy, PRIORITY, optional)
	@$(call install_fixup, python3-numpy, SECTION, base)
	@$(call install_fixup, python3-numpy, AUTHOR, "Guillermo Rodriguez <guille.rodriguez@gmail.com>")
	@$(call install_fixup, python3-numpy, DESCRIPTION, missing)

	@$(call install_glob, python3-numpy, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES)/numpy,,  *.py)

	@$(call install_finish, python3-numpy)

	@$(call touch)

# vim: syntax=make
