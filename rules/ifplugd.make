# -*-makefile-*-
#
# Copyright (C) 2007 by Ladislav Michl
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IFPLUGD) += ifplugd

#
# Paths and names
#
IFPLUGD_VERSION	:= 0.28
IFPLUGD_MD5	:= df6f4bab52f46ffd6eb1f5912d4ccee3
IFPLUGD		:= ifplugd-$(IFPLUGD_VERSION)
IFPLUGD_SUFFIX	:= tar.gz
IFPLUGD_URL	:= http://0pointer.de/lennart/projects/ifplugd/$(IFPLUGD).$(IFPLUGD_SUFFIX)
IFPLUGD_SOURCE	:= $(SRCDIR)/$(IFPLUGD).$(IFPLUGD_SUFFIX)
IFPLUGD_DIR	:= $(BUILDDIR)/$(IFPLUGD)
IFPLUGD_LICENSE	:= GPL-2.0-or-later
IFPLUGD_LICENSE_FILES	:= \
	file://README;md5=591f54e7283317e5d562c55f10ba90b3;startline=16;endline=30 \
	file://LICENSE;md5=94d55d512a9ba36caa9b7df079bae19f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
IFPLUGD_CONF_TOOL	:= autoconf
IFPLUGD_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-lynx \
	--disable-xmltoman \
	--disable-subversion \
	--with-initdir=/etc/init.d

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ifplugd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ifplugd)
	@$(call install_fixup, ifplugd,PRIORITY,optional)
	@$(call install_fixup, ifplugd,SECTION,base)
	@$(call install_fixup, ifplugd,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, ifplugd,DESCRIPTION,missing)

	@$(call install_copy, ifplugd, 0, 0, 0755, -, /usr/sbin/ifplugd)
	@$(call install_copy, ifplugd, 0, 0, 0755, -, /etc/ifplugd/ifplugd.action, n)

ifdef PTXCONF_IFPLUGD_STATUS
	@$(call install_copy, ifplugd, 0, 0, 0755, -, /usr/sbin/ifplugstatus)
endif

	@$(call install_finish, ifplugd)

	@$(call touch)

# vim: syntax=make
