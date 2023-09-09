# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_DBUS) += host-dbus

#
# Paths and names
#
HOST_DBUS_DIR	= $(HOST_BUILDDIR)/$(DBUS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
HOST_DBUS_CONF_TOOL	:= meson
HOST_DBUS_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	-Dapparmor=disabled \
	-Dasserts=false \
	-Dchecks=false \
	-Dcontainers=false \
	-Ddbus_user=messagebus \
	-Ddoxygen_docs=disabled \
	-Dducktype_docs=disabled \
	-Dembedded_tests=false \
	-Depoll=disabled \
	-Dinotify=disabled \
	-Dinstalled_tests=false \
	-Dkqueue=disabled \
	-Dlaunchd=disabled \
	-Dlibaudit=disabled \
	-Dmessage_bus=false \
	-Dmodular_tests=disabled \
	-Dqt_help=disabled \
	-Drelocation=disabled \
	-Dselinux=disabled \
	-Dstats=false \
	-Dsystemd=disabled \
	-Dsystemd_system_unitdir=/usr/lib/systemd/system \
	-Dsystemd_user_unitdir=/usr/lib/systemd/user \
	-Dtools=false \
	-Dtraditional_activation=false \
	-Duser_session=false \
	-Dvalgrind=disabled \
	-Dverbose_mode=false \
	-Dx11_autolaunch=disabled \
	-Dxml_docs=disabled

# vim: syntax=make
