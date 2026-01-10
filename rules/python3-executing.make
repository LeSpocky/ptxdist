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
PACKAGES-$(PTXCONF_PYTHON3_EXECUTING) += python3-executing

#
# Paths and names
#
PYTHON3_EXECUTING_VERSION	:= 2.2.1
PYTHON3_EXECUTING_MD5		:= 02588d10820c930874def80b2fb60c4e
PYTHON3_EXECUTING		:= executing-$(PYTHON3_EXECUTING_VERSION)
PYTHON3_EXECUTING_SUFFIX	:= tar.gz
PYTHON3_EXECUTING_URL		:= $(call ptx/mirror-pypi, executing, $(PYTHON3_EXECUTING).$(PYTHON3_EXECUTING_SUFFIX))
PYTHON3_EXECUTING_SOURCE	:= $(SRCDIR)/$(PYTHON3_EXECUTING).$(PYTHON3_EXECUTING_SUFFIX)
PYTHON3_EXECUTING_DIR		:= $(BUILDDIR)/$(PYTHON3_EXECUTING)
PYTHON3_EXECUTING_LICENSE	:= MIT
PYTHON3_EXECUTING_LICENSE_FILES	:= file://LICENSE.txt;md5=a3d6c15f7859ae235a78f2758e5a48cf

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_EXECUTING_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-executing.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-executing)
	@$(call install_fixup, python3-executing,PRIORITY,optional)
	@$(call install_fixup, python3-executing,SECTION,base)
	@$(call install_fixup, python3-executing,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python3-executing,DESCRIPTION,missing)

	@$(call install_glob, python3-executing, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-executing)

	@$(call touch)

# vim: ft=make
