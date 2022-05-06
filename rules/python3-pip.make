# -*-makefile-*-
#
# Copyright (C) 2021 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_PIP) += python3-pip

#
# Paths and names
#
PYTHON3_PIP_VERSION		:= 21.0.1
PYTHON3_PIP_MD5			:= 246523bd34dd356e7506adf54d206b12
PYTHON3_PIP			:= pip-$(PYTHON3_PIP_VERSION)
PYTHON3_PIP_SUFFIX		:= tar.gz
PYTHON3_PIP_URL			:= $(call ptx/mirror-pypi, pip, $(PYTHON3_PIP).$(PYTHON3_PIP_SUFFIX))
PYTHON3_PIP_SOURCE		:= $(SRCDIR)/$(PYTHON3_PIP).$(PYTHON3_PIP_SUFFIX)
PYTHON3_PIP_DIR			:= $(BUILDDIR)/$(PYTHON3_PIP)
PYTHON3_PIP_LICENSE		:= MIT
PYTHON3_PIP_LICENSE_FILES	:= file://LICENSE.txt;md5=4f6af77f7f2552976eb14dede2e57e29

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# python3
#
PYTHON3_PIP_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pip.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pip)
	@$(call install_fixup, python3-pip,PRIORITY,optional)
	@$(call install_fixup, python3-pip,SECTION,base)
	@$(call install_fixup, python3-pip,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python3-pip,DESCRIPTION,missing)

	@$(call install_copy, python3-pip, 0, 0, 0755, -, \
		/usr/bin/pip$(PYTHON3_MAJORMINOR))
	@$(call install_copy, python3-pip, 0, 0, 0755, -, \
		/usr/bin/pip3)
	@$(call install_copy, python3-pip, 0, 0, 0755, -, \
		/usr/bin/pip)

	@$(call install_glob, python3-pip, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py *.exe)
	# accessed at runtime by .../pip/_vendor/pep517/wrappers.py
	@$(call install_copy, python3-pip, 0, 0, 0644, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/pip/_vendor/pep517/_in_process.py)

	@$(call install_finish, python3-pip)

	@$(call touch)

# vim: syntax=make
