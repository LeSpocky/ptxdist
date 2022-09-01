# -*-makefile-*-
#
# Copyright (C) 2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3) += host-system-python3
HOST_SYSTEM_PYTHON3_LICENSE := ignore

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# $(SYSTEMPYTHON3) is defined in rules/pre/python.make

$(STATEDIR)/host-system-python3.prepare:
	@$(call targetinfo)
	@echo "Checking for Python 3 ..."
	@$(SYSTEMPYTHON3) -V >/dev/null 2>&1 || \
		ptxd_bailout "'python3' not found! Please install.";
	@echo
ifdef PTXCONF_HOST_SYSTEM_PYTHON3_CRYPTOGRAPHY
	@echo "Checking for Python Cryptography ..."
	@$(SYSTEMPYTHON3) -c 'import cryptography' 2>/dev/null || \
		ptxd_bailout "Python cryptography module not found! \
	Please install python3-cryptography (debian)";
endif
ifdef PTXCONF_HOST_SYSTEM_PYTHON3_DEV
	@echo "Checking for Python development files ..."
	@$(SYSTEMPYTHON3)-config --includes &>/dev/null || \
		ptxd_bailout "Python development files module not found! \
	Please install python3-dev (debian)";
endif
ifdef PTXCONF_HOST_SYSTEM_PYTHON3_JINJA2
	@echo "Checking for Python Jinja2 ..."
	@$(SYSTEMPYTHON3) -c 'import jinja2' 2>/dev/null || \
		ptxd_bailout "Python jinja2 module not found! \
	Please install python3-jinja2 (debian)";
endif
ifdef PTXCONF_HOST_SYSTEM_PYTHON3_MAKO
	@echo "Checking for Python Mako ..."
	@$(SYSTEMPYTHON3) -c 'import mako' 2>/dev/null || \
		ptxd_bailout "Python mako module not found! \
	Please install python3-mako (debian)";
endif
ifdef PTXCONF_HOST_SYSTEM_PYTHON3_NUMPY
	@echo "Checking for Python Numpy ..."
	@$(SYSTEMPYTHON3) -c 'import numpy' 2>/dev/null || \
		ptxd_bailout "Python numpy module not found! \
	Please install python3-numpy (debian)";
endif
ifdef PTXCONF_HOST_SYSTEM_PYTHON3_SETUPTOOLS
	@echo "Checking for Python Setuptools ..."
	@$(SYSTEMPYTHON3) -c 'import setuptools' 2>/dev/null || \
		ptxd_bailout "Python setuptools module not found! \
	Please install python3-setuptools (debian)";
endif
ifdef PTXCONF_HOST_SYSTEM_PYTHON3_SIX
	@echo "Checking for Python Six ..."
	@$(SYSTEMPYTHON3) -c 'import six' 2>/dev/null || \
		ptxd_bailout "Python six module not found! \
	Please install python3-six (debian)";
endif
ifdef PTXCONF_HOST_SYSTEM_PYTHON3_PLY
	@echo "Checking for Python ply ..."
	@$(SYSTEMPYTHON3) -c 'import ply' 2>/dev/null || \
		ptxd_bailout "Python ply module not found! \
	Please install python3-ply (debian)";
endif
ifdef PTXCONF_HOST_SYSTEM_PYTHON3_PYELFTOOLS
	@echo "Checking for Python Pyelftools ..."
	@$(SYSTEMPYTHON3) -c 'import elftools' 2>/dev/null || \
		ptxd_bailout "Python elftools module not found! \
	Please install python3-pyelftools (debian)";
endif
ifdef PTXCONF_HOST_SYSTEM_PYTHON3_PYYAML
	@echo "Checking for Python pyyaml ..."
	@$(SYSTEMPYTHON3) -c 'import yaml' 2>/dev/null || \
		ptxd_bailout "Python pyyaml module not found! \
	Please install python3-yaml (debian)";
endif
	@$(call touch)

# vim: syntax=make
