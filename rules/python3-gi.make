# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_GI) += python3-gi

#
# Paths and names
#
PYTHON3_GI_VERSION	:= 3.42.1
PYTHON3_GI_MD5		:= 8b2fa857229aaf526781376a20367ba8
PYTHON3_GI		:= pygobject-$(PYTHON3_GI_VERSION)
PYTHON3_GI_SUFFIX	:= tar.xz
PYTHON3_GI_URL		:= $(call ptx/mirror, GNOME, pygobject/$(basename $(PYTHON3_GI_VERSION))/$(PYTHON3_GI).$(PYTHON3_GI_SUFFIX))
PYTHON3_GI_SOURCE	:= $(SRCDIR)/$(PYTHON3_GI).$(PYTHON3_GI_SUFFIX)
PYTHON3_GI_DIR		:= $(BUILDDIR)/$(PYTHON3_GI)
PYTHON3_GI_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
PYTHON3_GI_CONF_TOOL	:= meson
PYTHON3_GI_CONF_OPT	 = \
	$(CROSS_MESON_USR) \
	-Dpycairo=disabled \
	-Dpython=$(CROSS_PYTHON3) \
	-Dtests=false

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-gi.install:
	@$(call targetinfo)
	@$(call world/install, PYTHON3_GI)
	@$(call world/env, PYTHON3_GI) ptxd_make_world_install_python_cleanup
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-gi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-gi)
	@$(call install_fixup, python3-gi,PRIORITY,optional)
	@$(call install_fixup, python3-gi,SECTION,base)
	@$(call install_fixup, python3-gi,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python3-gi,DESCRIPTION,missing)

	@$(call install_glob, python3-gi, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES)/gi,, *.la)

	@$(call install_finish, python3-gi)

	@$(call touch)

# vim: syntax=make
