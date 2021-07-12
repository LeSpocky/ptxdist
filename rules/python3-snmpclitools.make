# -*-makefile-*-
#
# Copyright (C) 2021 by Lars Pedersen <lapeddk@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_SNMPCLITOOLS) += python3-snmpclitools

#
# Paths and names
#
PYTHON3_SNMPCLITOOLS_VERSION	:= 0.6.4
PYTHON3_SNMPCLITOOLS_MD5	:= 132b100f5e7b80715e6c1d424e89687c
PYTHON3_SNMPCLITOOLS		:= snmpclitools-$(PYTHON3_SNMPCLITOOLS_VERSION)
PYTHON3_SNMPCLITOOLS_SUFFIX	:= tar.gz
PYTHON3_SNMPCLITOOLS_URL	:= $(call ptx/mirror-pypi, snmpclitools, $(PYTHON3_SNMPCLITOOLS).$(PYTHON3_SNMPCLITOOLS_SUFFIX))
PYTHON3_SNMPCLITOOLS_SOURCE	:= $(SRCDIR)/$(PYTHON3_SNMPCLITOOLS).$(PYTHON3_SNMPCLITOOLS_SUFFIX)
PYTHON3_SNMPCLITOOLS_DIR	:= $(BUILDDIR)/$(PYTHON3_SNMPCLITOOLS)
PYTHON3_SNMPCLITOOLS_LICENSE	:= BSD-2-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_SNMPCLITOOLS_CONF_TOOL	:= python3
PYTHON3_SNMPCLITOOLS_MAKE_OPT	:= install_scripts

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-snmpclitools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-snmpclitools)
	@$(call install_fixup, python3-snmpclitools,PRIORITY,optional)
	@$(call install_fixup, python3-snmpclitools,SECTION,base)
	@$(call install_fixup, python3-snmpclitools,AUTHOR,"Lars Pedersen <lapeddk@gmail.com>")
	@$(call install_fixup, python3-snmpclitools,DESCRIPTION,missing)

	@$(call install_glob, python3-snmpclitools, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_glob,python3-snmpclitools, 0, 0, -, \
		/usr/bin/,*.py,)

	@$(call install_finish, python3-snmpclitools)

	@$(call touch)

# vim: syntax=make
