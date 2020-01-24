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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON) += host-system-python
HOST_SYSTEM_PYTHON_LICENSE := ignore

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# $(SYSTEMPYTHON) is defined in rules/pre/python.make

$(STATEDIR)/host-system-python.prepare:
	@$(call targetinfo)
	@echo "Checking for Python ..."
	@$(SYSTEMPYTHON) -V >/dev/null 2>&1 || \
		ptxd_bailout "'python' not found! Please install.";
ifdef PTXCONF_HOST_SYSTEM_PYTHON_XML2
	@echo "Checking for Python libxml2 bindings ..."
	@$(SYSTEMPYTHON) -c 'import libxml2' 2>/dev/null || \
		ptxd_bailout "Python libxml2 module not found! \
	Please install python-libxml2 (debian)";
endif
ifdef PTXCONF_HOST_SYSTEM_PYTHON_MAKO
	@echo "Checking for Python Mako ..."
	@$(SYSTEMPYTHON) -c 'import mako' 2>/dev/null || \
		ptxd_bailout "Python mako module not found! \
	Please install python-mako (debian)";
endif
ifdef PTXCONF_HOST_SYSTEM_PYTHON_SIX
	@echo "Checking for Python Six ..."
	@$(SYSTEMPYTHON) -c 'import six' 2>/dev/null || \
		ptxd_bailout "Python six module not found! \
	Please install python-six (debian)";
endif
ifdef PTXCONF_HOST_SYSTEM_PYTHON_NUMPY
	@echo "Checking for Python Numpy ..."
	@$(SYSTEMPYTHON) -c 'import numpy' 2>/dev/null || \
		ptxd_bailout "Python numpy module not found! \
	Please install python-numpy (debian)";
endif
ifdef PTXCONF_HOST_SYSTEM_PYTHON_CRYPTO
	@echo "Checking for Python Crypto ..."
	@$(SYSTEMPYTHON) -c 'import Crypto' 2>/dev/null || \
		ptxd_bailout "Python Crypto module not found! \
	Please install python-crypto (debian)";
endif
	@echo
	@$(call touch)

# vim: syntax=make
