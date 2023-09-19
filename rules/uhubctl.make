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
UHUBCTL_VERSION	:= 2.5.0
UHUBCTL_MD5	:= e4e66d445ba8fda181ce4aa4abcd4247
UHUBCTL		:= uhubctl-$(UHUBCTL_VERSION)
UHUBCTL_SUFFIX	:= tar.gz
UHUBCTL_URL	:= https://github.com/mvp/uhubctl/archive/v$(UHUBCTL_VERSION).$(UHUBCTL_SUFFIX)
UHUBCTL_SOURCE	:= $(SRCDIR)/$(UHUBCTL).$(UHUBCTL_SUFFIX)
UHUBCTL_DIR	:= $(BUILDDIR)/$(UHUBCTL)
UHUBCTL_LICENSE	:= GPL-2.0-only
UHUBCTL_LICENSE_FILES := \
	file://LICENSE;md5=1e7b16e6ef7cd15d58b0f1c58dbf9817

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

UHUBCTL_CONF_TOOL	:= NO
UHUBCTL_MAKE_ENV	:= $(CROSS_ENV)

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

	@$(call install_copy, uhubctl, 0, 0, 0755, -, /usr/sbin/uhubctl)

	@$(call install_finish, uhubctl)

	@$(call touch)

# vim: syntax=make
