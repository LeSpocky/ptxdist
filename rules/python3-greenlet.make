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
PACKAGES-$(PTXCONF_PYTHON3_GREENLET) += python3-greenlet

#
# Paths and names
#
PYTHON3_GREENLET_VERSION	:= 3.1.1
PYTHON3_GREENLET_MD5		:= 13a71396abdf249280fa25d258acf435
PYTHON3_GREENLET		:= greenlet-$(PYTHON3_GREENLET_VERSION)
PYTHON3_GREENLET_SUFFIX	:= tar.gz
PYTHON3_GREENLET_URL		:= $(call ptx/mirror-pypi, greenlet, $(PYTHON3_GREENLET).$(PYTHON3_GREENLET_SUFFIX))
PYTHON3_GREENLET_SOURCE	:= $(SRCDIR)/$(PYTHON3_GREENLET).$(PYTHON3_GREENLET_SUFFIX)
PYTHON3_GREENLET_DIR		:= $(BUILDDIR)/$(PYTHON3_GREENLET)
PYTHON3_GREENLET_LICENSE	:= MIT AND PSF-2.0
PYTHON3_GREENLET_LICENSE_FILES	:= \
	file://LICENSE;md5=e95668d68e4329085c7ab3535e6a7aee \
	file://LICENSE.PSF;md5=c106931d9429eda0492617f037b8f69a

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_GREENLET_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-greenlet.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-greenlet)
	@$(call install_fixup, python3-greenlet,PRIORITY,optional)
	@$(call install_fixup, python3-greenlet,SECTION,base)
	@$(call install_fixup, python3-greenlet,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python3-greenlet,DESCRIPTION,missing)

	@$(call install_glob, python3-greenlet, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-greenlet)

	@$(call touch)

# vim: syntax=make
