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
PACKAGES-$(PTXCONF_PYTHON3_STACK_DATA) += python3-stack-data

#
# Paths and names
#
PYTHON3_STACK_DATA_VERSION		:= 0.6.3
PYTHON3_STACK_DATA_MD5			:= d04f7cda6589138e90691aec1edbf0d5
PYTHON3_STACK_DATA			:= stack_data-$(PYTHON3_STACK_DATA_VERSION)
PYTHON3_STACK_DATA_SUFFIX		:= tar.gz
PYTHON3_STACK_DATA_URL			:= $(call ptx/mirror-pypi, stack-data, $(PYTHON3_STACK_DATA).$(PYTHON3_STACK_DATA_SUFFIX))
PYTHON3_STACK_DATA_SOURCE		:= $(SRCDIR)/$(PYTHON3_STACK_DATA).$(PYTHON3_STACK_DATA_SUFFIX)
PYTHON3_STACK_DATA_DIR			:= $(BUILDDIR)/$(PYTHON3_STACK_DATA)
PYTHON3_STACK_DATA_LICENSE		:= MIT
PYTHON3_STACK_DATA_LICENSE_FILES	:= file://LICENSE.txt;md5=a3d6c15f7859ae235a78f2758e5a48cf

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_STACK_DATA_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-stack-data.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-stack-data)
	@$(call install_fixup, python3-stack-data,PRIORITY,optional)
	@$(call install_fixup, python3-stack-data,SECTION,base)
	@$(call install_fixup, python3-stack-data,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python3-stack-data,DESCRIPTION,missing)

	@$(call install_glob, python3-stack-data, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-stack-data)

	@$(call touch)

# vim: ft=make
