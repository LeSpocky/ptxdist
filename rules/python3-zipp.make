# -*-makefile-*-
#
# Copyright (C) 2020 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_ZIPP) += python3-zipp

#
# Paths and names
#
PYTHON3_ZIPP_VERSION	:= 3.1.0
PYTHON3_ZIPP_MD5	:= 199da7385f080ec45da6c1942e2b5996
PYTHON3_ZIPP		:= zipp-$(PYTHON3_ZIPP_VERSION)
PYTHON3_ZIPP_SUFFIX	:= tar.gz
PYTHON3_ZIPP_URL	:= https://pypi.python.org/packages/source/z/zipp/$(PYTHON3_ZIPP).$(PYTHON3_ZIPP_SUFFIX)
PYTHON3_ZIPP_SOURCE	:= $(SRCDIR)/$(PYTHON3_ZIPP).$(PYTHON3_ZIPP_SUFFIX)
PYTHON3_ZIPP_DIR	:= $(BUILDDIR)/$(PYTHON3_ZIPP)
PYTHON3_ZIPP_LICENSE	:= MIT
PYTHON3_ZIPP_LICENSE_FILES := \
	file://LICENSE;md5=7a7126e068206290f3fe9f8d6c713ea6

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_ZIPP_CONF_TOOL	:= python3

$(STATEDIR)/python3-zipp.extract.post:
	@$(call targetinfo)
	@$(call world/patchin/post, PYTHON3_ZIPP)
	@sed -i '/^name =/aversion = $(PYTHON3_ZIPP_VERSION)' $(PYTHON3_ZIPP_DIR)/setup.cfg
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-zipp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-zipp)
	@$(call install_fixup, python3-zipp, PRIORITY, optional)
	@$(call install_fixup, python3-zipp, SECTION, base)
	@$(call install_fixup, python3-zipp, AUTHOR, "Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, python3-zipp, DESCRIPTION, missing)

	@$(call install_glob, python3-zipp, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-zipp)

	@$(call touch)

# vim: syntax=make
