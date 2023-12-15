# -*-makefile-*-
#
# Copyright (C) 2021 by Roland Hieber, Pengutronix <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OFONO) += ofono

#
# Paths and names
#
OFONO_VERSION		:= 1.32
OFONO_MD5		:= 7496b3b89ab84bfb4ccfc26cda3fdf5e
OFONO			:= ofono-$(OFONO_VERSION)
OFONO_SUFFIX		:= tar.xz
OFONO_URL		:= $(call ptx/mirror, KERNEL, network/ofono/$(OFONO).$(OFONO_SUFFIX))
OFONO_SOURCE		:= $(SRCDIR)/$(OFONO).$(OFONO_SUFFIX)
OFONO_DIR		:= $(BUILDDIR)/$(OFONO)
OFONO_LICENSE		:= GPL-2.0-only AND GPL-2.0-or-later AND LGPL-2.1-or-later
OFONO_LICENSE_FILES	:= \
	file://COPYING;md5=eb723b61539feef013de476e68b5c50a \
	file://src/main.c;startline=7;endline=18;md5=cd0127f490f549377abc525c09d2673a \
	file://btio/btio.c;startline=9;endline=21;md5=eecbd02555c55f436075d7cca5c93d29 \
	file://gdbus/mainloop.c;startline=8;endline=20;md5=eecbd02555c55f436075d7cca5c93d29 \
	file://ell/main.c;startline=7;endline=19;md5=165042f5afe0b75cb88eebd3658d7927 \

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
OFONO_CONF_TOOL	:= autoconf
OFONO_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-optimization \
	--disable-debug \
	--disable-pie \
	--$(call ptx/endis, PTXCONF_OFONO_TESTS)-test \
	--disable-tools \
	--disable-dundee \
	--enable-udev \
	--enable-atmodem \
	--enable-cdmamodem \
	--enable-phonesim \
	--enable-isimodem \
	--enable-rilmodem \
	--enable-qmimodem \
	--enable-mbimmodem \
	--$(call ptx/endis, PTXCONF_OFONO_BLUETOOTH)-bluetooth \
	--disable-bluez4 \
	--disable-provision \
	--disable-upower \
	--disable-external-ell \
	--enable-datafiles \
	--with-systemdunitdir=/usr/lib/systemd/system

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ofono.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ofono)
	@$(call install_fixup, ofono,PRIORITY,optional)
	@$(call install_fixup, ofono,SECTION,base)
	@$(call install_fixup, ofono,AUTHOR,"Roland Hieber, Pengutronix <rhi@pengutronix.de>")
	@$(call install_fixup, ofono,DESCRIPTION,missing)

	@$(call install_copy, ofono, 0, 0, 0755, -, /usr/sbin/ofonod)

	@$(call install_alternative, ofono, 0, 0, 0644, /etc/dbus-1/system.d/ofono.conf)
	@$(call install_alternative, ofono, 0, 0, 0644, /etc/ofono/phonesim.conf)
	@$(call install_alternative, ofono, 0, 0, 0644, /usr/lib/udev/rules.d/96-ofono.rules)

ifdef PTXCONF_INITMETHOD_SYSTEMD
	@$(call install_alternative, ofono, 0, 0, 0644, /usr/lib/systemd/system/ofono.service)
endif

ifdef PTXCONF_OFONO_TESTS
	@$(call install_tree, ofono, 0, 0, -, /usr/lib/ofono/test)
endif
	@$(call install_finish, ofono)

	@$(call touch)

# vim: syntax=make
