# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON_SETUPTOOLS) += host-python-setuptools

#
# Paths and names
#
HOST_PYTHON_SETUPTOOLS_VERSION	:= 17.0
HOST_PYTHON_SETUPTOOLS_MD5	:= a661715d164163ec7a01a9277a6d49da
HOST_PYTHON_SETUPTOOLS		:= setuptools-$(HOST_PYTHON_SETUPTOOLS_VERSION)
HOST_PYTHON_SETUPTOOLS_SUFFIX	:= zip
HOST_PYTHON_SETUPTOOLS_URL	:= https://pypi.python.org/packages/source/s/setuptools/$(HOST_PYTHON_SETUPTOOLS).$(HOST_PYTHON_SETUPTOOLS_SUFFIX)
HOST_PYTHON_SETUPTOOLS_SOURCE	:= $(SRCDIR)/$(HOST_PYTHON_SETUPTOOLS).$(HOST_PYTHON_SETUPTOOLS_SUFFIX)
HOST_PYTHON_SETUPTOOLS_DIR	:= $(HOST_BUILDDIR)/$(HOST_PYTHON_SETUPTOOLS)
HOST_PYTHON_SETUPTOOLS_LICENSE	:= PSF, ZPL

HOST_PYTHON			= $(PTXCONF_SYSROOT_HOST)/bin/python$(PYTHON_MAJORMINOR)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON_SETUPTOOLS_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-python-setuptools.compile:
	@$(call targetinfo)
	@cd $(HOST_PYTHON_SETUPTOOLS_DIR)/$(HOST_PYTHON_SETUPTOOLS_SUBDIR) && \
		$(HOST_ENV) $(HOST_PYTHON) \
		setup.py build
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-python-setuptools.install:
	@$(call targetinfo)
	@cd $(HOST_PYTHON_SETUPTOOLS_DIR)/$(HOST_PYTHON_SETUPTOOLS_SUBDIR) && \
		$(HOST_ENV) $(HOST_PYTHON) \
		setup.py install --root=$(HOST_PYTHON_SETUPTOOLS_PKGDIR) --prefix=
	@$(call touch)

# vim: syntax=make
