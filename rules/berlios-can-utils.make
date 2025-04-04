# -*-makefile-*-
#
# Copyright (C) 2010, 2012 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BERLIOS_CAN_UTILS) += berlios-can-utils

#
# Paths and names
#
BERLIOS_CAN_UTILS_VERSION	:= v2021.06.0
BERLIOS_CAN_UTILS_MD5		:= 6f4eb3739fb9179588fa2824889213bb
BERLIOS_CAN_UTILS		:= canutils-$(BERLIOS_CAN_UTILS_VERSION)
BERLIOS_CAN_UTILS_SUFFIX	:= tar.gz
BERLIOS_CAN_UTILS_URL		:= https://github.com/linux-can/can-utils/archive/$(BERLIOS_CAN_UTILS_VERSION).$(BERLIOS_CAN_UTILS_SUFFIX)
BERLIOS_CAN_UTILS_SOURCE	:= $(SRCDIR)/$(BERLIOS_CAN_UTILS).$(BERLIOS_CAN_UTILS_SUFFIX)
BERLIOS_CAN_UTILS_DIR		:= $(BUILDDIR)/$(BERLIOS_CAN_UTILS)
BERLIOS_CAN_UTILS_LICENSE	:= GPL-2.0-only AND (GPL-2.0-only OR BSD-3-Clause)
BERLIOS_CAN_UTILS_LICENSE_FILES	:= \
	file://LICENSES/GPL-2.0-only.txt;md5=f9d20a453221a1b7e32ae84694da2c37 \
	file://canfdtest.c;startline=5;endline=15;md5=dc24414affc2b72358c3b7c8933d3132 \
	file://candump.c;startline=5;endline=39;md5=3b695bf13b721cf1d2f4b117e38cba00


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BERLIOS_CAN_UTILS_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

BERLIOS_CAN_UTILS_INST-y =
BERLIOS_CAN_UTILS_INST-m =
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_ASC2LOG) += /usr/bin/asc2log
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_BCMSERVER) += /usr/bin/bcmserver
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_CANBUSLOAD) += /usr/bin/canbusload
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_CANDUMP) += /usr/bin/candump
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_CANFDTEST) += /usr/bin/canfdtest
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_CANGEN) += /usr/bin/cangen
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_CANGW) += /usr/bin/cangw
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_CANLOGSERVER) += /usr/bin/canlogserver
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_CANPLAYER) += /usr/bin/canplayer
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_CANSEND) += /usr/bin/cansend
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_CANSEQUENCE) += /usr/bin/cansequence
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_CANSNIFFER) += /usr/bin/cansniffer
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_ISOTPDUMP) += /usr/bin/isotpdump
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_ISOTPRECV) += /usr/bin/isotprecv
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_ISOTPSEND) += /usr/bin/isotpsend
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_ISOTPSERVER) += /usr/bin/isotpserver
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_ISOTPSNIFFER) += /usr/bin/isotpsniffer
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_ISOTPTUN) += /usr/bin/isotptun
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_LOG2ASC) += /usr/bin/log2asc
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_LOG2LONG) += /usr/bin/log2long
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_SLCAN_ATTACH) += /usr/bin/slcan_attach
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_SLCAND) += /usr/bin/slcand
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_SLCANPTY) += /usr/bin/slcanpty
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_J1939SPY) += /usr/bin/j1939spy
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_J1939SR) += /usr/bin/j1939sr
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_J1939ACD) += /usr/bin/j1939acd
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_J1939CAT) += /usr/bin/j1939cat
BERLIOS_CAN_UTILS_INST-$(PTXCONF_BERLIOS_CAN_UTILS_TESTJ1939) += /usr/bin/testj1939

$(STATEDIR)/berlios-can-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, berlios-can-utils)
	@$(call install_fixup, berlios-can-utils,PRIORITY,optional)
	@$(call install_fixup, berlios-can-utils,SECTION,base)
	@$(call install_fixup, berlios-can-utils,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, berlios-can-utils,DESCRIPTION,missing)

	@for i in $(BERLIOS_CAN_UTILS_INST-y) $(BERLIOS_CAN_UTILS_INST-m); do \
		$(call install_copy, berlios-can-utils, 0, 0, 0755, -, $$i) \
	done

	@$(call install_finish, berlios-can-utils)

	@$(call touch)

# vim: syntax=make
