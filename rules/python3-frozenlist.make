# -*-makefile-*-
#
# Copyright (C) 2022 by Enrico Jorns <e.joerns@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_FROZENLIST) += python3-frozenlist

#
# Paths and names
#
PYTHON3_FROZENLIST_VERSION	:= 1.3.3
PYTHON3_FROZENLIST_MD5		:= 14e9ffd849c6a1dfa3c6b1fb1ff77b14
PYTHON3_FROZENLIST		:= frozenlist-$(PYTHON3_FROZENLIST_VERSION)
PYTHON3_FROZENLIST_SUFFIX	:= tar.gz
PYTHON3_FROZENLIST_URL		:= $(call ptx/mirror-pypi, frozenlist, $(PYTHON3_FROZENLIST).$(PYTHON3_FROZENLIST_SUFFIX))
PYTHON3_FROZENLIST_SOURCE	:= $(SRCDIR)/$(PYTHON3_FROZENLIST).$(PYTHON3_FROZENLIST_SUFFIX)
PYTHON3_FROZENLIST_DIR		:= $(BUILDDIR)/$(PYTHON3_FROZENLIST)
PYTHON3_FROZENLIST_LICENSE	:= Apache-2.0
PYTHON3_FROZENLIST_LICENSE_FILES:= \
	file://LICENSE;md5=cf056e8e7a0a5477451af18b7b5aa98c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_FROZENLIST_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-frozenlist.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-frozenlist)
	@$(call install_fixup, python3-frozenlist,PRIORITY,optional)
	@$(call install_fixup, python3-frozenlist,SECTION,base)
	@$(call install_fixup, python3-frozenlist,AUTHOR,"Enrico Jorns <e.joerns@pengutronix.de>")
	@$(call install_fixup, python3-frozenlist,DESCRIPTION,missing)

	@$(call install_glob, python3-frozenlist, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-frozenlist)

	@$(call touch)

# vim: syntax=make
