# -*-makefile-*-
#
# Copyright (C) 2013 by Alexander Dahl <post@lespocky.de>
# Copyright (C) 2015 by Clemens Gruber <clemens.gruber@pqgruber.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LLDPD) += lldpd

#
# Paths and names
#
LLDPD_VERSION	:= 1.0.19
LLDPD_MD5	:= c05268312d4bf19bad995406c3c30418
LLDPD		:= lldpd-$(LLDPD_VERSION)
LLDPD_SUFFIX	:= tar.gz
LLDPD_URL	:= http://media.luffy.cx/files/lldpd//$(LLDPD).$(LLDPD_SUFFIX)
LLDPD_SOURCE	:= $(SRCDIR)/$(LLDPD).$(LLDPD_SUFFIX)
LLDPD_DIR	:= $(BUILDDIR)/$(LLDPD)
LLDPD_LICENSE	:= ISC

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LLDPD_CONF_TOOL	:= autoconf
LLDPD_CONF_OPT	:= $(CROSS_AUTOCONF_USR) \
	--disable-doxygen-doc \
	--disable-doxygen-dot \
	--disable-doxygen-man \
	--disable-doxygen-rtf \
	--disable-doxygen-xml \
	--disable-doxygen-chm \
	--disable-doxygen-chi \
	--disable-doxygen-html \
	--disable-doxygen-ps \
	--disable-doxygen-pdf \
	--enable-hardening \
	--enable-pie \
	--disable-sanitizers \
	--disable-fuzzer \
	--disable-gcov \
	--disable-json0 \
	--disable-dtrace \
	--enable-privsep \
	--$(call ptx/endis, PTXCONF_LLDPD_CDP)-cdp \
	--$(call ptx/endis, PTXCONF_LLDPD_FDP)-fdp \
	--$(call ptx/endis, PTXCONF_LLDPD_EDP)-edp \
	--$(call ptx/endis, PTXCONF_LLDPD_SONMP)-sonmp \
	--$(call ptx/endis, PTXCONF_LLDPD_LLDPMED)-lldpmed \
	--$(call ptx/endis, PTXCONF_LLDPD_DOT1)-dot1 \
	--$(call ptx/endis, PTXCONF_LLDPD_DOT3)-dot3 \
	--$(call ptx/endis, PTXCONF_LLDPD_CUSTOM_TLV)-custom \
	--$(call ptx/endis, PTXCONF_LLDPD_OLDIES)-oldies \
	--with-libbsd \
	--without-embedded-libevent \
	--with-readline \
	--$(call ptx/wwo, PTXCONF_LLDPD_SNMP)-snmp \
	--$(call ptx/wwo, PTXCONF_LLDPD_XML)-xml \
	--without-seccomp \
	--without-launchddaemonsdir \
	--with-systemdsystemunitdir=/usr/lib/systemd/system \
	--without-sysusersdir \
	--without-apparmordir \
	--with-privsep-user="$(PTXCONF_LLDPD_PRIVSEP_USER)" \
	--with-privsep-group="$(PTXCONF_LLDPD_PRIVSEP_GROUP)" \
	--with-privsep-chroot="$(PTXCONF_LLDPD_PRIVSEP_CHROOT)" \
	--with-lldpd-ctl-socket="$(PTXCONF_LLDPD_CTL_SOCKET)" \
	--with-lldpd-pid-file="$(PTXCONF_LLDPD_PID_FILE)" \
	--with-netlink-max-receive-bufsize=1048576 \
	--with-netlink-receive-bufsize=0 \
	--with-netlink-send-bufsize=0


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lldpd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lldpd)
	@$(call install_fixup, lldpd,PRIORITY,optional)
	@$(call install_fixup, lldpd,SECTION,base)
	@$(call install_fixup, lldpd,AUTHOR,"Alexander Dahl <post@lespocky.de>")
	@$(call install_fixup, lldpd,DESCRIPTION,missing)

	@$(call install_copy, lldpd, 0, 0, 0755, -, /usr/sbin/lldpd)
	@$(call install_copy, lldpd, $(PTXCONF_LLDPD_PRIVSEP_USER), \
		$(PTXCONF_LLDPD_PRIVSEP_GROUP), 4750, -, /usr/sbin/lldpcli)
	@$(call install_link, lldpd, lldpcli, /usr/sbin/lldpctl)

	@$(call install_lib, lldpd, 0, 0, 0644, liblldpctl)

ifdef PTXCONF_LLDPD_STARTSCRIPT
	@$(call install_alternative, lldpd, 0, 0, 0755, /etc/init.d/lldpd)
	@$(call install_replace, lldpd, /etc/init.d/lldpd, \
		@DAEMON_ARGS@, $(PTXCONF_LLDPD_DAEMON_ARGS))
	@$(call install_replace, lldpd, /etc/init.d/lldpd, \
		@PRIVSEP_CHROOT@, $(PTXCONF_LLDPD_PRIVSEP_CHROOT))

ifneq ($(call remove_quotes,$(PTXCONF_LLDPD_BBINIT_LINK)),)
	@$(call install_link, lldpd, ../init.d/lldpd, \
		/etc/rc.d/$(PTXCONF_LLDPD_BBINIT_LINK))
endif
endif

ifdef PTXCONF_LLDPD_SYSTEMD_UNIT
	@$(call install_alternative, lldpd, 0, 0, 0644, /usr/lib/systemd/system/lldpd.service)
	@$(call install_replace, lldpd, /usr/lib/systemd/system/lldpd.service, \
		@DAEMON_ARGS@, $(PTXCONF_LLDPD_DAEMON_ARGS))
	@$(call install_replace, lldpd, /usr/lib/systemd/system/lldpd.service, \
		@PRIVSEP_CHROOT@, $(PTXCONF_LLDPD_PRIVSEP_CHROOT))
	@$(call install_link, lldpd, \
		../lldpd.service, \
		/usr/lib/systemd/system/multi-user.target.wants/lldpd.service \
	)
endif

	@$(call install_finish, lldpd)

	@$(call touch)

# vim: ft=make noet
