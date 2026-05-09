# -*-makefile-*-
#
# Copyright (C) 2020 by Marian Cichy <m.cichy@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_AML) += aml

#
# Paths and names
#
AML_VERSION	:= 0.3.0
AML_SHA256	:= cba1ca1689d4031faf37bb7a184559106b6d2f462ae8890a9fa16e3022ca1eb0
AML		:= aml-$(AML_VERSION)
AML_SUFFIX	:= tar.gz
AML_URL		:= https://github.com/any1/aml/archive/refs/tags/v$(AML_VERSION).$(AML_SUFFIX)
AML_SOURCE	:= $(SRCDIR)/$(AML).$(AML_SUFFIX)
AML_DIR		:= $(BUILDDIR)/$(AML)
AML_LICENSE	:= ISC

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
AML_CONF_TOOL	:= meson
AML_CONF_OPT	:=  \
	$(CROSS_MESON_USR) \
	-Dexamples=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/aml.targetinstall:
	@$(call targetinfo)

	@$(call install_init, aml)
	@$(call install_fixup, aml,PRIORITY,optional)
	@$(call install_fixup, aml,SECTION,base)
	@$(call install_fixup, aml,AUTHOR,"Marian Cichy <m.cichy@pengutronix.de>")
	@$(call install_fixup, aml,DESCRIPTION,missing)

	@$(call install_lib, aml, 0, 0, 0644, libaml)

	@$(call install_finish, aml)

	@$(call touch)

# vim: syntax=make
