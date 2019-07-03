# -*-makefile-*-
#
# Copyright (C) 2010 by Remy Bohmer <linux@bohmer.net>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SCHED_SWITCH) += sched_switch

#
# Paths and names
#
SCHED_SWITCH_VERSION	:= 0.1
SCHED_SWITCH_MD5	:= 88772802583336efa4f4bbcfbf130194
SCHED_SWITCH		:= sched_switch-$(SCHED_SWITCH_VERSION)
SCHED_SWITCH_SUFFIX	:= tgz
SCHED_SWITCH_URL	:= http://www.osadl.org/uploads/media/$(SCHED_SWITCH).$(SCHED_SWITCH_SUFFIX)
SCHED_SWITCH_SOURCE	:= $(SRCDIR)/$(SCHED_SWITCH).$(SCHED_SWITCH_SUFFIX)
SCHED_SWITCH_DIR	:= $(BUILDDIR)/$(SCHED_SWITCH)
SCHED_SWITCH_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SCHED_SWITCH_CONF_TOOL	:= NO
SCHED_SWITCH_MAKE_ENV	:= $(CROSS_ENV_FLAGS)
SCHED_SWITCH_MAKE_OPT	:= $(CROSS_ENV_CC)
SCHED_SWITCH_INSTALL_OPT:= \
	$(SCHED_SWITCH_MAKE_OPT) \
	DESTDIR=$(SCHED_SWITCH_PKGDIR) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sched_switch.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  sched_switch)
	@$(call install_fixup, sched_switch,PRIORITY,optional)
	@$(call install_fixup, sched_switch,SECTION,base)
	@$(call install_fixup, sched_switch,AUTHOR,"Remy Bohmer <linux@bohmer.net>")
	@$(call install_fixup, sched_switch,DESCRIPTION,missing)

	@$(call install_copy, sched_switch, 0, 0, 0755, -, /usr/bin/sched_switch)

	@$(call install_finish, sched_switch)

	@$(call touch)

# vim: syntax=make
