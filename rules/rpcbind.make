# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RPCBIND) += rpcbind

#
# Paths and names
#
RPCBIND_VERSION	:= 1.2.6
RPCBIND_MD5	:= 2d84ebbb7d6fb1fc3566d2d4b37f214b
RPCBIND		:= rpcbind-$(RPCBIND_VERSION)
RPCBIND_SUFFIX	:= tar.bz2
RPCBIND_URL	:= $(call ptx/mirror, SF, rpcbind/$(RPCBIND).$(RPCBIND_SUFFIX))
RPCBIND_SOURCE	:= $(SRCDIR)/$(RPCBIND).$(RPCBIND_SUFFIX)
RPCBIND_DIR	:= $(BUILDDIR)/$(RPCBIND)
RPCBIND_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
RPCBIND_CONF_TOOL	:= autoconf
RPCBIND_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-libwrap \
	--disable-debug \
	--disable-warmstarts \
	--disable-rmtcalls \
	--with-rpcuser=rpcuser \
	--with-nss-modules=files \
	--$(call ptx/wwo, PTXCONF_RPCBIND_SYSTEMD_UNIT)-systemdsystemunitdir$(call ptx/ifdef,PTXCONF_RPCBIND_SYSTEMD_UNIT,=/usr/lib/systemd/system)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rpcbind.targetinstall:
	@$(call targetinfo)

	@$(call install_init, rpcbind)
	@$(call install_fixup, rpcbind,PRIORITY,optional)
	@$(call install_fixup, rpcbind,SECTION,base)
	@$(call install_fixup, rpcbind,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, rpcbind,DESCRIPTION,missing)

	@$(call install_copy, rpcbind, 0, 0, 0755, -, /usr/sbin/rpcbind)

ifdef PTXCONF_RPCBIND_RPCINFO
	@$(call install_copy, rpcbind, 0, 0, 0755, -, /usr/bin/rpcinfo)
endif

ifdef PTXCONF_RPCBIND_SYSTEMD_UNIT
	@$(call install_alternative, rpcbind, 0, 0, 0644, \
		/usr/lib/systemd/system/rpcbind.service)
	@$(call install_alternative, rpcbind, 0, 0, 0644, \
		/usr/lib/systemd/system/rpcbind.socket)
	@$(call install_link, rpcbind, ../rpcbind.socket, \
		/usr/lib/systemd/system/sockets.target.wants/rpcbind.socket)
endif

	@$(call install_finish, rpcbind)

	@$(call touch)

# vim: syntax=make
