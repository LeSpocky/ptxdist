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
PPP_LICENSE	:= \
	BSD-3-Clause AND GPL-2.0-only AND Apache-2.0 AND BSD-4.3TAHOE AND \
	BSD-Attribution-HPND-disclaimer AND Mackerras-3-Clause AND FSFAP AND \
	(GPL-2.0-or-later OR BSD-4-Clause OR BSD-3-Clause OR BSD-2-Clause) AND \
	GPL-2.0-or-later WITH Autoconf-exception-generic AND \
	HPND-Fenneberg-Livingston AND UMich-Merit AND HPND-INRIA-IMAG AND \
	ISC AND LGPL-2.1-or-later AND MIT AND Mackerras-3-Clause-acknowledgment \
	AND public_domain AND Sun-PPP AND Sun-PPP-2000
PPP_LICENSE_FILES := \
	file://LICENSE.BSD;md5=3775480a712fc46a69647678acb234cb \
	file://LICENSE.GPL-2;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
	file://pppd/crypto_ms.c;startline=49;endline=54;md5=2683a91a6df93c252f955a916d71cf33 \
	file://pppstats/pppstats.c;startline=18;endline=31;md5=d668e8c42e0238dd219c556aea5f313f \
	file://pppd/auth.c;startline=28;endline=64;md5=c67784d4e4100a46116adb0c69679980 \
	file://pppd/chap_ms.c;startline=4;endline=28;md5=6d1ed5fc616bc97b03c0eba74516ec55 \
	file://m4/ax_check_atm.m4;startline=17;endline=22;md5=0c957d771d01d2fe770ff40e7929c794 \
	file://pppd/termios_linux.h;startline=1;endline=6;md5=0502fac4cda6f3e1cee20e375d6ec6f7 \
	file://m4/pkg.m4;startline=4;endline=26;md5=9c6805bddda682155b00f2d2ae5b3b0b \
	file://pppd/plugins/radius/COPYRIGHT;startline=20;endline=32;md5=cb79d2ada1c67f5a36bd6e876701f18f \
	file://pppd/plugins/radius/COPYRIGHT;startline=50;endline=68;md5=162895d33fd19ceb38742c7aa1d23253 \
	file://pppd/ipv6cp.c;startline=72;endline=91;md5=72d14927791f0c58004e9948a3c8b2a4 \
	file://pppd/pppd.8;startline=8;endline=20;md5=063c017c0747428ab8fcb6a924d1768e \
	file://pppd/plugins/pppoatm/COPYING;startline=1;endline=4;md5=83bda153d6fc6da3dfcffbf75dcb5744 \
	file://chat/chat.c;startline=6;endline=27;md5=fb879812bb782070b1b0549d1057689a \
	file://pppd/session.c;startline=4;endline=28;md5=3052982a4f12f2dc3d8854695b7e95d1 \
	file://pppd/ppp-md5.c;startline=101;endline=119;md5=bda64dbdffcf95ec99a3ad78d2b55301 \
	file://pppd/eap.c;startline=4;endline=16;md5=fb3c09febdc398e3d3d3165730fc1641 \
	file://pppd/sys-solaris.c;startline=7;endline=19;md5=63c3c2a91abee830755b6fbe2b3e4b0f \
	file://pppd/eui64.c;startline=4;endline=33;md5=f761f20c0bd9aba37f1caf6065929cbd \
	file://pppd/sys-solaris.c;startline=21;endline=41;md5=35c31e0a22bf9ea211c1ebab7169f6b8

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
