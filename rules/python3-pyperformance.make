# -*-makefile-*-
#
# Copyright (C) 2025 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_PYPERFORMANCE) += python3-pyperformance

#
# Paths and names
#
PYTHON3_PYPERFORMANCE_VERSION		:= 1.11.0
PYTHON3_PYPERFORMANCE_MD5		:= 99e0c3a9444e95998d1d18ab606926e9
PYTHON3_PYPERFORMANCE			:= pyperformance-$(PYTHON3_PYPERFORMANCE_VERSION)
PYTHON3_PYPERFORMANCE_SUFFIX		:= tar.gz
PYTHON3_PYPERFORMANCE_URL		:= $(call ptx/mirror-pypi, pyperformance, $(PYTHON3_PYPERFORMANCE).$(PYTHON3_PYPERFORMANCE_SUFFIX))
PYTHON3_PYPERFORMANCE_SOURCE		:= $(SRCDIR)/$(PYTHON3_PYPERFORMANCE).$(PYTHON3_PYPERFORMANCE_SUFFIX)
PYTHON3_PYPERFORMANCE_DIR		:= $(BUILDDIR)/$(PYTHON3_PYPERFORMANCE)
PYTHON3_PYPERFORMANCE_LICENSE		:= MIT
PYTHON3_PYPERFORMANCE_LICENSE_FILES	:= \
	file://COPYING;md5=1ec23723682ec494ce9b9deec2467f25

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PYPERFORMANCE_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pyperformance.install:
	@$(call targetinfo)
	@$(call world/install, PYTHON3_PYPERFORMANCE)
ifdef PTXCONF_PYTHON3_PYPERFORMANCE_DEPS
	@sed -i \
		-e 's/^dulwich==.*/dulwich==$(PYTHON3_DULWICH_VERSION)/' \
		-e 's/^greenlet==.*/greenlet==$(PYTHON3_GREENLET_VERSION)/' \
		-e 's/^psutil==.*/psutil==$(PYTHON3_PSUTIL_VERSION)/' \
		$(PYTHON3_PYPERFORMANCE_PKGDIR)/usr/lib/python3.13/site-packages/pyperformance/data-files/benchmarks/*/requirements.txt
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pyperformance.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pyperformance)
	@$(call install_fixup, python3-pyperformance,PRIORITY,optional)
	@$(call install_fixup, python3-pyperformance,SECTION,base)
	@$(call install_fixup, python3-pyperformance,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python3-pyperformance,DESCRIPTION,missing)

	@$(call install_glob, python3-pyperformance, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py */run_benchmark.pyc)
#	# run_benchmark.py files are needed for the benchmarks to find their requirements.txt
	@$(call install_glob, python3-pyperformance, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),*/run_benchmark.py)

	@$(call install_copy, python3-pyperformance, 0, 0, 0755, -, \
		/usr/bin/pyperformance)

	@$(call install_finish, python3-pyperformance)

	@$(call touch)

# vim: syntax=make
