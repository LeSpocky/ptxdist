# -*-makefile-*-
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_SCIPY) += python3-scipy

#
# Paths and names
#
PYTHON3_SCIPY_VERSION		:= 1.15.1
PYTHON3_SCIPY_MD5		:= 161e1937805a55cc940bd09f4f1a759a
PYTHON3_SCIPY			:= scipy-$(PYTHON3_SCIPY_VERSION)
PYTHON3_SCIPY_SUFFIX		:= tar.gz
PYTHON3_SCIPY_URL		:= $(call ptx/mirror-pypi, scipy, $(PYTHON3_SCIPY).$(PYTHON3_SCIPY_SUFFIX))
PYTHON3_SCIPY_SOURCE		:= $(SRCDIR)/$(PYTHON3_SCIPY).$(PYTHON3_SCIPY_SUFFIX)
PYTHON3_SCIPY_DIR		:= $(BUILDDIR)/$(PYTHON3_SCIPY)
PYTHON3_SCIPY_LICENSE		:= BSD-2-Clause AND BSD-3-Clause AND MIT AND BSD-3-Clause-LBNL AND BSL-1.0 AND Apache-2.0 WITH LLVM-exception
PYTHON3_SCIPY_LICENSE_FILES	:= \
	file://LICENSE.txt;md5=5f477c3073ea2d02a70a764319f5f873 \
	file://LICENSES_bundled.txt;md5=86efba5e36c406c7b024a0cff905a921


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_SCIPY_MESON_CROSS_FILE := $(call ptx/get-alternative, config/meson, python3-scipy-cross-file.meson)

PYTHON3_SCIPY_CONF_ENV	= \
	$(CROSS_ENV) \
	PTXDIST_PYTHON3=$(PTXDIST_SYSROOT_HOST)/lib/wrapper/python$(PYTHON3_MAJORMINOR)

PYTHON3_SCIPY_CONF_TOOL	:= meson
PYTHON3_SCIPY_CONF_OPT	= \
	$(CROSS_MESON_USR) \
	-Duse-pythran=false \
	-Dpython3=$(CROSS_PYTHON3) \
	\
	--cross-file $(PYTHON3_SCIPY_MESON_CROSS_FILE)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-scipy.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-scipy)
	@$(call install_fixup, python3-scipy,PRIORITY,optional)
	@$(call install_fixup, python3-scipy,SECTION,base)
	@$(call install_fixup, python3-scipy,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python3-scipy,DESCRIPTION,missing)

#	# does not load when .py files are missing so install .py and .pyc
	@$(call install_tree, python3-scipy, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES))

	@$(call install_finish, python3-scipy)

	@$(call touch)

# vim: syntax=make
