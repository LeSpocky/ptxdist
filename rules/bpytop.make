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
PACKAGES-$(PTXCONF_BPYTOP) += bpytop

#
# Paths and names
#
BPYTOP_VERSION	:= 1.0.26
BPYTOP_MD5	:= 0f726e1e5c9830a1a346182abdc259a0
BPYTOP		:= bpytop-$(BPYTOP_VERSION)
BPYTOP_SUFFIX	:= tar.gz
BPYTOP_URL	:= https://github.com/aristocratos/bpytop/archive/v$(BPYTOP_VERSION).$(BPYTOP_SUFFIX)
BPYTOP_SOURCE	:= $(SRCDIR)/$(BPYTOP).$(BPYTOP_SUFFIX)
BPYTOP_DIR	:= $(BUILDDIR)/$(BPYTOP)
BPYTOP_LICENSE	:= Apache-2.0
BPYTOP_LICENSE_FILES := \
	file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BYPTOP_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

BPYTOP_INSTALL_OPT	:= PREFIX=/usr install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bpytop.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bpytop)
	@$(call install_fixup, bpytop, PRIORITY, optional)
	@$(call install_fixup, bpytop, SECTION, base)
	@$(call install_fixup, bpytop, AUTHOR, "Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, bpytop, DESCRIPTION, missing)

	@$(call install_copy, bpytop, 0, 0, 0755, -, /usr/bin/bpytop)
	@$(call install_tree, bpytop, 0, 0, -, /usr/share/bpytop)

	@$(call install_finish, bpytop)

	@$(call touch)

# vim: syntax=make
