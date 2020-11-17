# -*-makefile-*-
#
# Copyright (C) 2020 by Lars Pedersen <lapeddk@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_ADBUS) += python3-adbus

#
# Paths and names
#
PYTHON3_ADBUS_VERSION	:= 1.1.3
PYTHON3_ADBUS_MD5	:= 6802bdf83110edaf3b76dcd00f7aadbf
PYTHON3_ADBUS		:= adbus-$(PYTHON3_ADBUS_VERSION)
PYTHON3_ADBUS_SUFFIX	:= tar.gz
PYTHON3_ADBUS_URL	:= $(call ptx/mirror-pypi, adbus, $(PYTHON3_ADBUS).$(PYTHON3_ADBUS_SUFFIX))
PYTHON3_ADBUS_SOURCE	:= $(SRCDIR)/$(PYTHON3_ADBUS).$(PYTHON3_ADBUS_SUFFIX)
PYTHON3_ADBUS_DIR	:= $(BUILDDIR)/$(PYTHON3_ADBUS)
PYTHON3_ADBUS_LICENSE	:= MIT
PYTHON3_ADBUS_LICENSE_FILES := \
	file://LICENSE;md5=da428c97c811cd93a27a66732d9597ed


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_ADBUS_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-adbus.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-adbus)
	@$(call install_fixup, python3-adbus,PRIORITY,optional)
	@$(call install_fixup, python3-adbus,SECTION,base)
	@$(call install_fixup, python3-adbus,AUTHOR,"Lars Pedersen <lapeddk@gmail.com>")
	@$(call install_fixup, python3-adbus,DESCRIPTION,missing)

	@$(call install_glob, python3-adbus, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-adbus)

	@$(call touch)

# vim: syntax=make
