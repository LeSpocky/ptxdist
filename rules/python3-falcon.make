# -*-makefile-*-
#
# Copyright (C) 2022 by Bruno Thomsen <bruno.thomsen@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_FALCON) += python3-falcon

#
# Paths and names
#
PYTHON3_FALCON_VERSION		:= 3.1.3
PYTHON3_FALCON_MD5		:= 22a5c32f3d9dd96d498febe8e16ddffe
PYTHON3_FALCON			:= falcon-$(PYTHON3_FALCON_VERSION)
PYTHON3_FALCON_SUFFIX		:= tar.gz
PYTHON3_FALCON_URL		:= $(call ptx/mirror-pypi, falcon, $(PYTHON3_FALCON).$(PYTHON3_FALCON_SUFFIX))
PYTHON3_FALCON_SOURCE		:= $(SRCDIR)/$(PYTHON3_FALCON).$(PYTHON3_FALCON_SUFFIX)
PYTHON3_FALCON_DIR		:= $(BUILDDIR)/$(PYTHON3_FALCON)
PYTHON3_FALCON_LICENSE		:= Apache-2.0
PYTHON3_FALCON_LICENSE_FILES	:= \
	file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_FALCON_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-falcon.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-falcon)
	@$(call install_fixup, python3-falcon,PRIORITY,optional)
	@$(call install_fixup, python3-falcon,SECTION,base)
	@$(call install_fixup, python3-falcon,AUTHOR,"Bruno Thomsen <bruno.thomsen@gmail.com>")
	@$(call install_fixup, python3-falcon,DESCRIPTION,missing)

	@$(call install_glob, python3-falcon, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-falcon)

	@$(call touch)

# vim: syntax=make
