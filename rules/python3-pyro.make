# -*-makefile-*-
#
# Copyright (C) 2019 by Niklas Reisser <niklas.reisser@de.bosch.com>
#               2021 by Roland Hieber, Pengutronix <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_PYRO) += python3-pyro

#
# Paths and names
#

PYTHON3_PYRO_VERSION	:= 4.80
PYTHON3_PYRO		:= Pyro4-$(PYTHON3_PYRO_VERSION)
PYTHON3_PYRO_MD5	:= e31fc077e06de9fc0bb061e357401954
PYTHON3_PYRO_SUFFIX	:= tar.gz
PYTHON3_PYRO_URL	:= $(call ptx/mirror-pypi, pyro4, $(PYTHON3_PYRO).$(PYTHON3_PYRO_SUFFIX))
PYTHON3_PYRO_SOURCE	:= $(SRCDIR)/$(PYTHON3_PYRO).$(PYTHON3_PYRO_SUFFIX)
PYTHON3_PYRO_DIR	:= $(BUILDDIR)/$(PYTHON3_PYRO)
PYTHON3_PYRO_LICENSE	:= MIT
PYTHON3_PYRO_LICENSE_FILES	:= file://LICENSE;md5=cd13dafd4eeb0802bb6efea6b4a4bdbc

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PYRO_CONF_TOOL := python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pyro.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pyro)
	@$(call install_fixup, python3-pyro,PRIORITY,optional)
	@$(call install_fixup, python3-pyro,SECTION,base)
	@$(call install_fixup, python3-pyro,AUTHOR,"Niklas Reisser <niklas.reisser@de.bosch.com>")
	@$(call install_fixup, python3-pyro,DESCRIPTION,missing)

	@$(call install_glob, python3-pyro, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES)/Pyro4,, *.py)

	@$(call install_finish, python3-pyro)

	@$(call touch)

# vim: syntax=make
