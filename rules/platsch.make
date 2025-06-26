# -*-makefile-*-
#
# Copyright (C) 2025 by Rouven Czerwinski <r.czerwinski@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PLATSCH) += platsch

#
# Paths and names
#
PLATSCH_VERSION	:= v2024.08.0
PLATSCH_MD5		:= f71c2c60acb8ef221f3cc5612e6a920e
PLATSCH		:= platsch-$(PLATSCH_VERSION)
PLATSCH_SUFFIX	:= tar.gz
PLATSCH_URL		:= https://github.com/pengutronix/platsch/archive/refs/tags/$(PLATSCH_VERSION).$(PLATSCH_SUFFIX)
PLATSCH_SOURCE	:= $(SRCDIR)/$(PLATSCH).$(PLATSCH_SUFFIX)
PLATSCH_DIR		:= $(BUILDDIR)/$(PLATSCH)
PLATSCH_LICENSE	:= 0BSD
PLATSCH_LICENSE_FILES	:= file://LICENSE;md5=1a4c8b8d288b4fc32c3c4830d7a5e169

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PLATSCH_CONF_ENV	:= $(CROSS_ENV)

#
# meson
#
PLATSCH_CONF_TOOL	:= meson
PLATSCH_CONF_OPT	:= \
	$(CROSS_MESON_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/platsch.targetinstall:
	@$(call targetinfo)

	@$(call install_init, platsch)
	@$(call install_fixup, platsch,PRIORITY,optional)
	@$(call install_fixup, platsch,SECTION,base)
	@$(call install_fixup, platsch,AUTHOR,"Rouven Czerwinski <r.czerwinski@pengutronix.de>")
	@$(call install_fixup, platsch,DESCRIPTION,missing)

	@$(call install_lib, platsch, 0, 0, 0755, libplatsch)
	@$(call install_copy, platsch, 0, 0, 0755, -, /usr/sbin/platsch)

	@$(call install_finish, platsch)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

#$(STATEDIR)/platsch.clean:
#	@$(call targetinfo)
#	@$(call clean_pkg, PLATSCH)

# vim: syntax=make
