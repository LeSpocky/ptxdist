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
	@HOST_SYSTEM_PYTHON3_SETUP=1 $(SYSTEMPYTHON3) -V || \
		ptxd_bailout "'python3' not found! Please install.";
	@echo
	@HOST_SYSTEM_PYTHON3_SETUP=1 $(SYSTEMPYTHON3) -m venv \
		--system-site-packages \
		$(PTXDIST_SYSROOT_HOST)/usr/lib/system-python3
	@$(PTXDIST_SYSROOT_HOST)/usr/lib/system-python3/bin/pip3 \
		uninstall --yes setuptools

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
ifdef PTXCONF_HOST_SYSTEM_PYTHON3_NUMPY
	@echo "Checking for Python Numpy ..."
	@$(SYSTEMPYTHON3) -c 'import numpy' 2>/dev/null || \
		ptxd_bailout "Python numpy module not found! \
	Please install python3-numpy (debian)";
endif
ifdef PTXCONF_HOST_SYSTEM_PYTHON3_PYYAML
	@echo "Checking for Python pyyaml ..."
	@$(SYSTEMPYTHON3) -c 'import yaml' 2>/dev/null || \
		ptxd_bailout "Python pyyaml module not found! \
	Please install python3-yaml (debian)";
endif

	@$(call touch)

# vim: syntax=make
