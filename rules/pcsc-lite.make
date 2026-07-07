# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#               2015, 2018 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PCSC_LITE) += pcsc-lite

#
# Paths and names
#
PCSC_LITE_VERSION	:= 2.5.1
PCSC_LITE_SHA256	:= 78cd514e1b549292696a5c549d42d69a44fd084aa06ccd1af2ff6c2208282581
PCSC_LITE_SUFFIX	:= tar.gz
PCSC_LITE		:= pcsc-lite-$(PCSC_LITE_VERSION)
PCSC_LITE_URL		:= https://github.com/LudovicRousseau/PCSC/archive/refs/tags/$(PCSC_LITE_VERSION).$(PCSC_LITE_SUFFIX)
PCSC_LITE_SOURCE	:= $(SRCDIR)/$(PCSC_LITE).$(PCSC_LITE_SUFFIX)
PCSC_LITE_DIR		:= $(BUILDDIR)/$(PCSC_LITE)
PCSC_LITE_BUILD_OOT	:= YES
# src/spy LICENSE := GPL-3.0-or-later - but file is not distributed
PCSC_LITE_LICENSE	:= BSD-3-Clause AND BSD-2-Clause AND MIT AND ISC

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PCSC_LITE_CONF_ENV := \
	$(CROSS_ENV) \
	PTXDIST_PKG_CONFIG_VAR_NO_SYSROOT=systemdsystemunitdir

#
# autoconf
#
PCSC_LITE_CONF_TOOL := meson
PCSC_LITE_CONF_OPT := \
	$(CROSS_MESON_USR) \
	-Dembedded=false \
	-Dfilter_names=true \
	-Dipcdir=/run/pcscd \
	-Dlibsystemd=$(call ptx/truefalse, PTXCONF_PCSC_LITE_SYSTEMD_UNIT) \
	-Dlibudev=$(call ptx/truefalse, PTXCONF_PCSC_LITE_LIBUDEV) \
	-Dlibusb=false \
	-Dpolkit=false \
	-Dserial=false \
	-Dsystemdunit=system \
	-Dusb=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pcsc-lite.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  pcsc-lite)
	@$(call install_fixup, pcsc-lite,PRIORITY,optional)
	@$(call install_fixup, pcsc-lite,SECTION,base)
	@$(call install_fixup, pcsc-lite,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, pcsc-lite,DESCRIPTION,missing)

	@$(call install_alternative, pcsc-lite, 0, 0, 0644, /etc/reader.conf.d/reader.conf)

	@$(call install_lib, pcsc-lite, 0, 0, 0644, libpcsclite)
	@$(call install_copy, pcsc-lite, 0, 0, 0755, -, /usr/sbin/pcscd)

ifdef PTXCONF_PCSC_LITE_SYSTEMD_UNIT
	@$(call install_alternative, pcsc-lite, 0, 0, 0644, /usr/lib/systemd/system/pcscd.service)
	@$(call install_alternative, pcsc-lite, 0, 0, 0644, /usr/lib/systemd/system/pcscd.socket)
	@$(call install_link, pcsc-lite, ../pcscd.socket, \
		/usr/lib/systemd/system/sockets.target.wants/pcscd.socket)
endif

	@$(call install_finish, pcsc-lite)

	@$(call touch)

# vim: syntax=make
