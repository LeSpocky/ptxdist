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
PACKAGES-$(PTXCONF_UHUBCTL) += uhubctl

#
# Paths and names
#
UHUBCTL_VERSION	:= 2.4.0
UHUBCTL_MD5	:= 9bdf73940881df02574a94703ad8b582
UHUBCTL		:= uhubctl-$(UHUBCTL_VERSION)
UHUBCTL_SUFFIX	:= tar.gz
UHUBCTL_URL	:= https://github.com/mvp/uhubctl/archive/v$(UHUBCTL_VERSION).$(UHUBCTL_SUFFIX)
UHUBCTL_SOURCE	:= $(SRCDIR)/$(UHUBCTL).$(UHUBCTL_SUFFIX)
UHUBCTL_DIR	:= $(BUILDDIR)/$(UHUBCTL)
UHUBCTL_LICENSE	:= GPL-2.0-only
UHUBCTL_LICENSE_FILES := \
	file://LICENSE;md5=a79e6a142b69522fe7757fe7313895eb

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

UHUBCTL_CONF_TOOL	:= NO
UHUBCTL_MAKE_ENV 	:= $(CROSS_ENV)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/uhubctl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, uhubctl)
	@$(call install_fixup, uhubctl,PRIORITY,optional)
	@$(call install_fixup, uhubctl,SECTION,base)
	@$(call install_fixup, uhubctl,AUTHOR,"Lars Pedersen <lapeddk@gmail.com>")
	@$(call install_fixup, uhubctl,DESCRIPTION,missing)

	@$(call install_copy, uhubctl, 0, 0, 0755, $(UHUBCTL_DIR)/uhubctl, /usr/bin/uhubctl)

	@$(call install_finish, uhubctl)

	@$(call touch)

# vim: syntax=make
