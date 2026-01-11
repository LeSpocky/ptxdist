# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ORC) += orc

#
# Paths and names
#
ORC_VERSION	:= 0.4.42
ORC_MD5		:= b8b4e43d46a62b32150ed5e9833f1d55
ORC		:= orc-$(ORC_VERSION)
ORC_SUFFIX	:= tar.xz
ORC_URL		:= https://gstreamer.freedesktop.org/data/src/orc/$(ORC).$(ORC_SUFFIX)
ORC_SOURCE	:= $(SRCDIR)/$(ORC).$(ORC_SUFFIX)
ORC_DIR		:= $(BUILDDIR)/$(ORC)
ORC_LICENSE	:= BSD-2-Clause AND BSD-3-Clause
ORC_LICENSE_FILES := \
	file://COPYING;md5=1400bd9d09e8af56b9ec982b3d85797e

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ORC_TARGET := all
ifdef PTXCONF_ARCH_ARM_NEON
ORC_TARGET := neon
endif

ORC_CONF_TOOL	:= meson
ORC_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dorc-target=$(ORC_TARGET) \
	-Dorc-test=$(call ptx/endis,PTXCONF_ORC_TEST)d \
	-Dbenchmarks=disabled \
	-Dexamples=disabled \
	-Dhotdoc=disabled \
	-Dtests=disabled \
	-Dtools=disabled

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/orc.install:
	@$(call targetinfo)
	@$(call world/install, ORC)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/orc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, orc)
	@$(call install_fixup, orc,PRIORITY,optional)
	@$(call install_fixup, orc,SECTION,base)
	@$(call install_fixup, orc,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, orc,DESCRIPTION,missing)

	@$(call install_lib, orc, 0, 0, 0644, liborc-0.4)
ifdef PTXCONF_ORC_TEST
	@$(call install_lib, orc, 0, 0, 0644, liborc-test-0.4)
endif

	@$(call install_finish, orc)

	@$(call touch)

# vim: syntax=make
