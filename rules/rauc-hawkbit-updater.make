# -*-makefile-*-
#
# Copyright (C) 2020 by Bastian Krause <bst@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RAUC_HAWKBIT_UPDATER) += rauc-hawkbit-updater

#
# Paths and names
#
RAUC_HAWKBIT_UPDATER_VERSION		:= 2020-09-09-gb38f5a5
RAUC_HAWKBIT_UPDATER_MD5		:= c2accd9bdcab813dbf9850e6ed63085e
RAUC_HAWKBIT_UPDATER			:= rauc-hawkbit-updater-$(RAUC_HAWKBIT_UPDATER_VERSION)
RAUC_HAWKBIT_UPDATER_SUFFIX		:= tar.gz
RAUC_HAWKBIT_UPDATER_URL		:= https://github.com/rauc/rauc-hawkbit-updater/archive/$(RAUC_HAWKBIT_UPDATER).$(RAUC_HAWKBIT_UPDATER_SUFFIX)
RAUC_HAWKBIT_UPDATER_SOURCE		:= $(SRCDIR)/$(RAUC_HAWKBIT_UPDATER).$(RAUC_HAWKBIT_UPDATER_SUFFIX)
RAUC_HAWKBIT_UPDATER_DIR		:= $(BUILDDIR)/$(RAUC_HAWKBIT_UPDATER)
RAUC_HAWKBIT_UPDATER_LICENSE		:= LGPL-2.1-or-later
RAUC_HAWKBIT_UPDATER_LICENSE_FILES	:= file://LICENSE;md5=1a6d268fd218675ffea8be556788b780

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
RAUC_HAWKBIT_UPDATER_CONF_TOOL	:= cmake
RAUC_HAWKBIT_UPDATER_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DWITH_SYSTEMD=$(call ptx/onoff,PTXCONF_RAUC_HAWKBIT_UPDATER_SYSTEMD_UNIT) \
	-DBUILD_DOC=OFF \
	-DQA_BUILD=ON \
	--with-systemdsystemunitdir=/usr/lib/systemd/system

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rauc-hawkbit-updater.targetinstall:
	@$(call targetinfo)

	@$(call install_init, rauc-hawkbit-updater)
	@$(call install_fixup, rauc-hawkbit-updater,PRIORITY,optional)
	@$(call install_fixup, rauc-hawkbit-updater,SECTION,base)
	@$(call install_fixup, rauc-hawkbit-updater,AUTHOR,"Bastian Krause <bst@pengutronix.de>")
	@$(call install_fixup, rauc-hawkbit-updater,DESCRIPTION,missing)

	@$(call install_copy, rauc-hawkbit-updater, 0, 0, 0755, -, \
		/usr/bin/rauc-hawkbit-updater)

	@$(call install_alternative, rauc-hawkbit-updater, 0, 0, 0644, \
		/etc/rauc-hawkbit-updater/config.conf)

ifdef PTXCONF_RAUC_HAWKBIT_UPDATER_SYSTEMD_UNIT
	@$(call install_alternative, rauc-hawkbit-updater, 0, 0, 0644, \
		/usr/lib/systemd/system/rauc-hawkbit-updater.service)
	@$(call install_link, rauc-hawkbit-updater, ../rauc-hawkbit-updater.service, \
		/usr/lib/systemd/system/multi-user.target.wants/rauc-hawkbit-updater.service)
endif

	@$(call install_finish, rauc-hawkbit-updater)

	@$(call touch)

# vim: syntax=make
