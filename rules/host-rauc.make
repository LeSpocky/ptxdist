# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Grzeschik <mgr@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_RAUC) += host-rauc

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_RAUC_CONF_TOOL	:= autoconf
HOST_RAUC_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--enable-debug=info \
	--enable-largefile \
	--enable-compile-warnings=yes \
	--disable-Werror \
	--disable-code-coverage \
	--disable-valgrind \
	--disable-service \
	--enable-create \
	--disable-network \
	--disable-json \
	--disable-gpt \
	--with-gcov=gcov \
	--with-systemdunitdir=/usr/lib/systemd/system \
	--with-dbuspolicydir=/usr/share/dbus-1/system.d \
	--with-dbussystemservicedir=/usr/share/dbus-1/system-services \
	--with-dbusinterfacesdir=/usr/share/dbus-1/interfaces

# vim: syntax=make
