# -*-makefile-*-
#
# Copyright (C) 2024 by Roland Hieber <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_AIOMQTT) += python3-aiomqtt

#
# Paths and names
#
PYTHON3_AIOMQTT_VERSION	:= 2.1.0
PYTHON3_AIOMQTT_MD5	:= 83a05e30a73feb6131a064f83e67a710
PYTHON3_AIOMQTT		:= aiomqtt-$(PYTHON3_AIOMQTT_VERSION)
PYTHON3_AIOMQTT_SUFFIX	:= tar.gz
PYTHON3_AIOMQTT_URL	:= $(call ptx/mirror-pypi, aiomqtt, $(PYTHON3_AIOMQTT).$(PYTHON3_AIOMQTT_SUFFIX))
PYTHON3_AIOMQTT_SOURCE	:= $(SRCDIR)/$(PYTHON3_AIOMQTT).$(PYTHON3_AIOMQTT_SUFFIX)
PYTHON3_AIOMQTT_DIR	:= $(BUILDDIR)/$(PYTHON3_AIOMQTT)
PYTHON3_AIOMQTT_LICENSE	:= BSD-3-Clause
PYTHON3_AIOMQTT_LICENSE_FILES	:= \
	file://README.md;startline=76;endline=78;md5=077fa167040809425eeaa14a6f641b74 \
	file://LICENSE;md5=a462083fa4d830bdcf8c22a8ddf453cf

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_AIOMQTT_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-aiomqtt.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-aiomqtt)
	@$(call install_fixup, python3-aiomqtt,PRIORITY,optional)
	@$(call install_fixup, python3-aiomqtt,SECTION,base)
	@$(call install_fixup, python3-aiomqtt,AUTHOR,"Roland Hieber <rhi@pengutronix.de>")
	@$(call install_fixup, python3-aiomqtt,DESCRIPTION,missing)

	@$(call install_glob, python3-aiomqtt, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-aiomqtt)

	@$(call touch)

# vim: syntax=make
