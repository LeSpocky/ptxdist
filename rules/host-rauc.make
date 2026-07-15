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
HOST_RAUC_CONF_TOOL	:= meson
HOST_RAUC_CONF_OPT	:= \
	$(HOST_MESON_OPT) \
	-Dcomposefs=enabled \
	-Dcreate=true \
	-Ddbusinterfacesdir=/usr/share/dbus-1/interfaces \
	-Ddbuspolicydir=/usr/share/dbus-1/system.d \
	-Ddbussystemservicedir=/usr/share/dbus-1/system-services \
	-Dfuzzing=false \
	-Dgpt=disabled \
	-Dhtmldocs=false \
	-Djson=disabled \
	-Dmanpages=false \
	-Dnetwork=false \
	-Dpkcs11_engine=true \
	-Dservice=false \
	-Dstreaming=false \
	-Dstreaming_user=nobody \
	-Dsystemdcatalogdir=/usr/lib/systemd/catalog \
	-Dsystemdunitdir=/usr/lib/systemd/system \
	-Dtests=false

# vim: syntax=make
