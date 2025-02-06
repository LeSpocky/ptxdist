# -*-makefile-*-
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de> for
#                       GYRO net GmbH <info@gyro-net.de>, Hannover, Germany
#               2008, 2009 by Juergen Beisert <juergen@kreuzholzen.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PPP) += ppp

#
# Paths and names
#
PPP_VERSION	:= 2.5.2
PPP_MD5		:= 28744065f8062622e2ab59901a310b2a
PPP		:= ppp-$(PPP_VERSION)
PPP_SUFFIX	:= tar.gz
PPP_URL		:= https://www.samba.org/ftp/ppp/$(PPP).$(PPP_SUFFIX)
PPP_SOURCE	:= $(SRCDIR)/$(PPP).$(PPP_SUFFIX)
PPP_DIR		:= $(BUILDDIR)/$(PPP)
PPP_LICENSE	:= BSD AND GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PPP_KERNEL_VERSION := $(if $(KERNEL_HEADER_VERSION),$(KERNEL_HEADER_VERSION),$(KERNEL_VERSION))

ifdef PTXCONF_PPP
ifeq ($(PPP_KERNEL_VERSION),)
$(call ptx/error, Linux kernel version required in order to make ppp work!)
$(call ptx/error, Define a platform kernel or the kernel headers)
endif
endif

PPP_SHARED_INST_PATH := /usr/lib/pppd/$(PPP_VERSION)

PPP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-systemd \
	--$(call ptx/endis,PTXCONF_PPP_MS_CBCP)-cbcp \
	--$(call ptx/endis,PTXCONF_PPP_MICROSOFT)-microsoft-extensions \
	--$(call ptx/endis,PTXCONF_PPP_MICROSOFT)-mslanman \
	--$(call ptx/endis,PTXCONF_GLOBAL_IPV6)-ipv6cp \
	--$(call ptx/endis,PTXCONF_PPP_MULTILINK)-multilink \
	--$(call ptx/endis,PTXCONF_PPP_PLUGINS)-plugins \
	--enable-eaptls \
	--$(call ptx/endis,PTXCONF_PPP_MICROSOFT)-peap \
	--enable-openssl-engine \
	--with-plugin-dir=$(PPP_SHARED_INST_PATH) \
	--with-system-ca-path=/etc/ssl/certs/ \
	--with-srp=$(call ptx/ifdef,PTXCONF_PPP_SRP,$(SYSROOT),no) \
	--without-atm \
	--without-pam \
	--with-pcap=$(call ptx/ifdef,PTXCONF_PPP_FILTER,$(SYSROOT),no)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ppp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ppp)
	@$(call install_fixup, ppp,PRIORITY,optional)
	@$(call install_fixup, ppp,SECTION,base)
	@$(call install_fixup, ppp,AUTHOR,"Robert Schwebel (r.schwebel@pengutronix.de)")
	@$(call install_fixup, ppp,DESCRIPTION,missing)

ifdef PTXCONF_PPP_SUID
	@$(call install_copy, ppp, 0, 0, 4755, -, /usr/sbin/pppd)
else
	@$(call install_copy, ppp, 0, 0, 0755, -, /usr/sbin/pppd)
endif

ifdef PTXCONF_PPP_INST_CHAT
	@$(call install_copy, ppp, 0, 0, 0755, -, /usr/sbin/chat)
endif

ifdef PTXCONF_PPP_INST_DEFAULT_CONFIG_FILES
	@$(call install_alternative, ppp, 0, 0, 0600, /etc/ppp/options)
	@$(call install_alternative, ppp, 0, 0, 0750, /etc/ppp/ip-up)
	@$(call install_alternative, ppp, 0, 0, 0750, /etc/ppp/ip-down)
	@$(call install_alternative, ppp, 0, 0, 0600, /etc/ppp/pap-secrets)

	@$(call install_alternative, ppp, 0, 0, 0600, /etc/ppp/peers/provider)
	@$(call install_alternative, ppp, 0, 0, 0600, /etc/chatscripts/provider)
	@$(call install_alternative, ppp, 0, 0, 0600, /etc/chatscripts/disconnect)
endif

#	#
#	# busybox init
#	#
ifdef PTXCONF_PPP_STARTSCRIPT
	@$(call install_alternative, ppp, 0, 0, 0755, /etc/init.d/pppd)
	@$(call install_replace, ppp, /etc/init.d/pppd, \
		@PPPD_INTF@, $(PTXCONF_PPPD_INTF))

ifneq ($(call remove_quotes,$(PTXCONF_PPPD_BBINIT_LINK)),)
	@$(call install_link, ppp, \
		../init.d/pppd, \
		/etc/rc.d/$(PTXCONF_PPPD_BBINIT_LINK))
endif
endif

ifdef PTXCONF_PPP_INST_PPPDUMP
	@$(call install_copy, ppp, 0, 0, 0755, -, /usr/sbin/pppdump)
endif

ifdef PTXCONF_PPP_INST_PPPSTATS
	@$(call install_copy, ppp, 0, 0, 0755, -, /usr/sbin/pppstats)
endif

ifdef PTXCONF_PPP_INST_PONOFF
	@$(call install_alternative, ppp, 0, 0, 0755, /usr/bin/pon)
	@$(call install_alternative, ppp, 0, 0, 0755, /usr/bin/poff)
endif

ifdef PTXCONF_PPP_PLUGINS
	@$(call install_copy, ppp, 0, 0, 0755, $(PPP_SHARED_INST_PATH))
endif

ifdef PTXCONF_PPP_OATM
	@$(call install_copy, ppp, 0, 0, 0644, -, \
		$(PPP_SHARED_INST_PATH)/pppoatm.so)
endif
ifdef PTXCONF_PPP_RADIUS
	@$(call install_copy, ppp, 0, 0, 0644, -, \
		$(PPP_SHARED_INST_PATH)/radius.so)
endif
ifdef PTXCONF_PPP_RADATTR
	@$(call install_copy, ppp, 0, 0, 0644, -, \
		$(PPP_SHARED_INST_PATH)/radattr.so)
endif
ifdef PTXCONF_PPP_RADREALMS
	@$(call install_copy, ppp, 0, 0, 0644, -, \
		$(PPP_SHARED_INST_PATH)/radrealms.so)
endif
ifdef PTXCONF_PPP_OE
	@$(call install_copy, ppp, 0, 0, 0644, -, \
		$(PPP_SHARED_INST_PATH)/pppoe.so)
endif
ifdef PTXCONF_PPP_MINCONN
	@$(call install_copy, ppp, 0, 0, 0644, -, \
		$(PPP_SHARED_INST_PATH)/minconn.so)
endif
ifdef PTXCONF_PPP_PASSWORDFD
	@$(call install_copy, ppp, 0, 0, 0644, -, \
		$(PPP_SHARED_INST_PATH)/passwordfd.so)
endif
ifdef PTXCONF_PPP_WINBIND
	@$(call install_copy, ppp, 0, 0, 0644, -, \
		$(PPP_SHARED_INST_PATH)/winbind.so)
endif
	@$(call install_finish, ppp)
	@$(call touch)

# vim: syntax=make
