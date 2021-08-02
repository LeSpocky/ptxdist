# -*-makefile-*-
#
# Copyright (C) 2021 by Ahmad Fatoum <a.fatoum@pengutronix.de>
#

PACKAGES-$(PTXCONF_FSCRYPTCTL) += fscryptctl

#
# Paths and names
#
FSCRYPTCTL_VERSION		:= 1.0.0
FSCRYPTCTL_MD5			:= 1013d00ac166b233631100e5905004cc
FSCRYPTCTL			:= fscryptctl-$(FSCRYPTCTL_VERSION)
FSCRYPTCTL_SUFFIX		:= tar.gz
FSCRYPTCTL_URL			:= https://github.com/google/fscryptctl/archive/v$(FSCRYPTCTL_VERSION).$(FSCRYPTCTL_SUFFIX)
FSCRYPTCTL_SOURCE		:= $(SRCDIR)/$(FSCRYPTCTL).$(FSCRYPTCTL_SUFFIX)
FSCRYPTCTL_DIR			:= $(BUILDDIR)/$(FSCRYPTCTL)
FSCRYPTCTL_LICENSE		:= Apache-2.0
FSCRYPTCTL_LICENSE_FILES	:= \
	file://fscryptctl.c;startline=5;endline=20;md5=989e571b78197682b85e3643d13296e5 \
	file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FSCRYPTCTL_CONF_TOOL := NO
FSCRYPTCTL_MAKE_OPT := \
	$(CROSS_ENV_CC) \
	CFLAGS="-O2 -g3 -Wall" \
	PREFIX=/usr

FSCRYPTCTL_INSTALL_OPT := \
	$(FSCRYPTCTL_MAKE_OPT) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fscryptctl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fscryptctl)
	@$(call install_fixup, fscryptctl,PRIORITY,optional)
	@$(call install_fixup, fscryptctl,SECTION,base)
	@$(call install_fixup, fscryptctl,AUTHOR,"Ahmad Fatoum <a.fatoum@pengutronix.de>")
	@$(call install_fixup, fscryptctl,DESCRIPTION, "Low-level Linux fscrypt control tool")

	@$(call install_copy, fscryptctl, 0, 0, 0755, -, /usr/bin/fscryptctl)

	@$(call install_finish, fscryptctl)

	@$(call touch)

# vim: syntax=make
