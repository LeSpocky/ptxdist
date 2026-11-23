# -*-makefile-*-
#
# Copyright (C) 2015 Dr. Neuhaus Telekommunikation GmbH, Hamburg Germany, Oliver Graute <oliver.graute@neuhaus.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DHCP_HELPER) += dhcp-helper

#
# Paths and names
#
DHCP_HELPER_VERSION	:= 1.2
DHCP_HELPER_SHA256	:= ae9e589ec50f1b5be302e7ebb8111ad734a11e2422a9cf61d08f7858ea2366ad
DHCP_HELPER		:= dhcp-helper-$(DHCP_HELPER_VERSION)
DHCP_HELPER_SUFFIX	:= tar.gz
DHCP_HELPER_URL		:= https://thekelleys.org.uk/dhcp-helper/$(DHCP_HELPER).$(DHCP_HELPER_SUFFIX)
DHCP_HELPER_SOURCE	:= $(SRCDIR)/$(DHCP_HELPER).$(DHCP_HELPER_SUFFIX)
DHCP_HELPER_DIR		:= $(BUILDDIR)/$(DHCP_HELPER)
DHCP_HELPER_LICENSE	:= GPL-2.0-only OR GPL-3.0-only
DHCP_HELPER_LICENSE_FILES	:= \
	file://dhcp-helper.c;startline=3;endline=14;md5=b6241445151de1406877c4e1f86fcbe8 \
	file://COPYING;md5=0636e73ff0215e8d672dc4c32c317bb3 \
	file://COPYING-v3;md5=d32239bcb673463ab874e80d47fae504

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DHCP_HELPER_CONF_TOOL	:= NO
DHCP_HELPER_MAKE_OPT	:= \
	$(CROSS_ENV_CC) \
	PREFIX=/usr \
	version=$(DHCP_HELPER_VERSION)

DHCP_HELPER_INSTALL_OPT := \
	$(DHCP_HELPER_MAKE_OPT) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dhcp-helper.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dhcp-helper)
	@$(call install_fixup, dhcp-helper,PRIORITY,optional)
	@$(call install_fixup, dhcp-helper,SECTION,base)
	@$(call install_fixup, dhcp-helper,AUTHOR,"<oliver.graute@neuhaus.de>")
	@$(call install_fixup, dhcp-helper,DESCRIPTION,missing)

	@$(call install_copy, dhcp-helper, 0, 0, 0755, -, /usr/sbin/dhcp-helper)

	@$(call install_finish, dhcp-helper)

	@$(call touch)

# vim: syntax=make
