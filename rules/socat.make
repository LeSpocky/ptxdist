# -*-makefile-*-
#
# Copyright (C) 2013 by Michael Grzeschik <mgr@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_SOCAT) += socat

#
# Paths and names
#

SOCAT_VERSION	:= 1.8.0.3
SOCAT_MD5	:= ffd9c84c8bce700eac26847c8a700a78
SOCAT		:= socat-$(SOCAT_VERSION)
SOCAT_SUFFIX	:= tar.gz
SOCAT_URL	:= \
	http://www.dest-unreach.org/socat/download/$(SOCAT).$(SOCAT_SUFFIX) \
	http://www.dest-unreach.org/socat/download/Archive/$(SOCAT).$(SOCAT_SUFFIX)
SOCAT_SOURCE	:= $(SRCDIR)/$(SOCAT).$(SOCAT_SUFFIX)
SOCAT_DIR	:= $(BUILDDIR)/$(SOCAT)
SOCAT_LICENSE	:= GPL-2.0-only AND MIT
SOCAT_LICENSE_FILES := \
	file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
	file://README;startline=248;endline=281;md5=4e953b796133e1470eb57b3f59611720 \
	file://install-sh;startline=6;endline=16;md5=6c39b6a36ad775d09cc9ee0e33fe9e6c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SOCAT_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_lib_bsd_openpty=no

#
# autoconf
#
SOCAT_CONF_TOOL	:= autoconf
SOCAT_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-help \
	--enable-largefile \
	--enable-stats \
	--enable-stdio \
	--enable-fdnum \
	--enable-file \
	--enable-creat \
	--enable-gopen \
	--enable-pipe \
	--enable-socketpair \
	--enable-termios \
	--enable-unix \
	--enable-abstract-unixsocket \
	--enable-ip4 \
	--$(call ptx/endis, PTXCONF_GLOBAL_IPV6)-ip6 \
	--enable-rawip \
	--enable-genericsocket \
	--enable-interface \
	--enable-tcp \
	--enable-udp \
	--enable-udplite \
	--enable-sctp \
	--enable-dccp \
	--enable-vsock \
	--enable-namespaces \
	--enable-listen \
	--enable-posixmq \
	--enable-socks4 \
	--enable-socks4a \
	--enable-socks5 \
	--enable-proxy \
	--enable-exec \
	--enable-system \
	--enable-shell \
	--enable-pty \
	--enable-fs \
	--disable-readline \
	--$(call ptx/endis, PTXCONF_SOCAT_OPENSSL)-openssl \
	--enable-resolve \
	--disable-res-deprecated \
	--disable-fips \
	--enable-tun \
	--enable-sycls \
	--enable-filan \
	--enable-retry \
	--disable-devtests \
	--enable-msglevel=0 \
	--enable-default-ipv=4 \
	--disable-libwrap


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/socat.targetinstall:
	@$(call targetinfo)

	@$(call install_init, socat)
	@$(call install_fixup, socat,PRIORITY,optional)
	@$(call install_fixup, socat,SECTION,base)
	@$(call install_fixup, socat,AUTHOR,"Michael Grzeschik <mgr@pengutronix.de>")
	@$(call install_fixup, socat,DESCRIPTION,missing)

	@$(call install_copy, socat, 0, 0, 0755, -, /usr/bin/procan)
	@$(call install_copy, socat, 0, 0, 0755, -, /usr/bin/filan)
	@$(call install_copy, socat, 0, 0, 0755, -, /usr/bin/socat)

	@$(call install_finish, socat)

	@$(call touch)

# vim: syntax=make
