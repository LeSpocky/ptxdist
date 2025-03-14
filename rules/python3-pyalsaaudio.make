# -*-makefile-*-
#
# Copyright (C) 2017 by David Jander <david@protonic.nl>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_PYALSAAUDIO) += python3-pyalsaaudio

#
# Paths and names
#
PYTHON3_PYALSAAUDIO_VERSION	:= 0.11.0
PYTHON3_PYALSAAUDIO_MD5		:= 8c11664f8787e3d9900d666f15565713
PYTHON3_PYALSAAUDIO		:= python3-pyalsaaudio-$(PYTHON3_PYALSAAUDIO_VERSION)
PYTHON3_PYALSAAUDIO_SUFFIX	:= tar.gz
PYTHON3_PYALSAAUDIO_URL		:= $(call ptx/mirror-pypi, pyalsaaudio, pyalsaaudio-$(PYTHON3_PYALSAAUDIO_VERSION).$(PYTHON3_PYALSAAUDIO_SUFFIX))
PYTHON3_PYALSAAUDIO_SOURCE	:= $(SRCDIR)/$(PYTHON3_PYALSAAUDIO).$(PYTHON3_PYALSAAUDIO_SUFFIX)
PYTHON3_PYALSAAUDIO_DIR		:= $(BUILDDIR)/$(PYTHON3_PYALSAAUDIO)
PYTHON3_PYALSAAUDIO_LICENSE	:= PSF

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PYALSAAUDIO_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pyalsaaudio.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pyalsaaudio)
	@$(call install_fixup, python3-pyalsaaudio, PRIORITY, optional)
	@$(call install_fixup, python3-pyalsaaudio, SECTION, base)
	@$(call install_fixup, python3-pyalsaaudio, AUTHOR, "David Jander <david@protonic.nl>")
	@$(call install_fixup, python3-pyalsaaudio, DESCRIPTION, missing)

	@$(call install_glob, python3-pyalsaaudio, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),*/alsaaudio*.so)

	@$(call install_finish, python3-pyalsaaudio)

	@$(call touch)

# vim: syntax=make
