# -*-makefile-*-
#
# Copyright (C) 2017 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HAVEGED) += haveged

#
# Paths and names
#
HAVEGED_VERSION	:= 1.9.13
HAVEGED_MD5	:= 5391978794208b6cca6f53d7a6211c04
HAVEGED		:= haveged-$(HAVEGED_VERSION)
HAVEGED_SUFFIX	:= tar.gz
HAVEGED_URL	:= \
	https://github.com/jirka-h/haveged/archive/v$(HAVEGED_VERSION).tar.gz
HAVEGED_SOURCE	:= $(SRCDIR)/$(HAVEGED).$(HAVEGED_SUFFIX)
HAVEGED_DIR	:= $(BUILDDIR)/$(HAVEGED)
HAVEGED_LICENSE	:= GPL-3.0-or-later
HAVEGED_LICENSE_FILES   := \
	file://COPYING;md5=d32239bcb673463ab874e80d47fae504 \
	file://src/haveged.c;startline=1;endline=20;md5=0b45b25b79d4a3b7d800cc2c951429b2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HAVEGED_CONF_TOOL	:= autoconf
HAVEGED_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-clock_gettime \
	--enable-daemon \
	--disable-diagnostic \
	--enable-init=service.fedora \
	--enable-initdir=/usr/lib/systemd/system \
	--disable-nistest \
	--disable-olt \
	--enable-threads \
	--enable-tune

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/haveged.targetinstall:
	@$(call targetinfo)

	@$(call install_init, haveged)
	@$(call install_fixup, haveged,PRIORITY,optional)
	@$(call install_fixup, haveged,SECTION,base)
	@$(call install_fixup, haveged,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, haveged,DESCRIPTION,missing)

	@$(call install_lib, haveged, 0, 0, 0644, libhavege)
	@$(call install_copy, haveged, 0, 0, 0755, -, /usr/sbin/haveged)

ifdef PTXCONF_HAVEGED_STARTSCRIPT
	@$(call install_alternative, haveged, 0, 0, 0755, /etc/init.d/haveged)

ifneq ($(call remove_quotes,$(PTXCONF_HAVEGED_BBINIT_LINK)),)
	@$(call install_link, haveged, ../init.d/haveged, \
		/etc/rc.d/$(PTXCONF_HAVEGED_BBINIT_LINK))
endif
endif

ifdef PTXCONF_HAVEGED_SYSTEMD_UNIT
	@$(call install_alternative, haveged, 0, 0, 0644, \
		/usr/lib/systemd/system/haveged.service)
	@$(call install_link, haveged, ../haveged.service, \
		/usr/lib/systemd/system/sysinit.target.wants/haveged.service)
endif

	@$(call install_finish, haveged)

	@$(call touch)

# vim: syntax=make
