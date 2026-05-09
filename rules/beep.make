# -*-makefile-*-
#
# Copyright (C) 2017 by Bastian Stender <bst@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BEEP) += beep

#
# Paths and names
#
BEEP_VERSION	:= 1.4.12
BEEP_SHA256	:= 6188d0f0c180db7a30467b5b6065a3cb5d2665b937d2e8c40366efb52bf689fe
BEEP		:= beep-$(BEEP_VERSION)
BEEP_SUFFIX	:= tar.gz
BEEP_URL	:= https://github.com/spkr-beep/beep/archive/refs/tags/v$(BEEP_VERSION).$(BEEP_SUFFIX)
BEEP_SOURCE	:= $(SRCDIR)/$(BEEP).$(BEEP_SUFFIX)
BEEP_DIR	:= $(BUILDDIR)/$(BEEP)
BEEP_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BEEP_CONF_TOOL	:= NO
BEEP_MAKE_OPT	:= \
	CC=$(CROSS_CC) \
	prefix=/usr

$(STATEDIR)/beep.prepare:
	@$(call targetinfo)
	# Override detected CFLAGS as some of them may require linking
	# with additional libraries (-lubsan and -latomic)
	@echo "common_CFLAGS = -std=gnu99 -pedantic"	>  $(BEEP_DIR)/local.mk
	@echo "CFLAGS = -O2 -g -save-temps=obj"		>> $(BEEP_DIR)/local.mk
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

BEEP_INSTALL_OPT	:= \
	prefix=/usr \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/beep.targetinstall:
	@$(call targetinfo)

	@$(call install_init, beep)
	@$(call install_fixup, beep,PRIORITY,optional)
	@$(call install_fixup, beep,SECTION,base)
	@$(call install_fixup, beep,AUTHOR,"Bastian Stender <bst@pengutronix.de>")
	@$(call install_fixup, beep,DESCRIPTION,missing)

	@$(call install_copy, beep, 0, 0, 0755, -, /usr/bin/beep)

	@$(call install_finish, beep)

	@$(call touch)

# vim: syntax=make
