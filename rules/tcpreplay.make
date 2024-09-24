# -*-makefile-*-
#
# Copyright (C) 2024 by Bastian Krause <bst@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TCPREPLAY) += tcpreplay

#
# Paths and names
#
TCPREPLAY_VERSION	:= 4.5.1
TCPREPLAY_MD5		:= 53375102b54b3e6ef124f6ae85836092
TCPREPLAY		:= tcpreplay-$(TCPREPLAY_VERSION)
TCPREPLAY_SUFFIX	:= tar.xz
TCPREPLAY_URL		:= https://github.com/appneta/tcpreplay/releases/download/v$(TCPREPLAY_VERSION)/$(TCPREPLAY).$(TCPREPLAY_SUFFIX)
TCPREPLAY_SOURCE	:= $(SRCDIR)/$(TCPREPLAY).$(TCPREPLAY_SUFFIX)
TCPREPLAY_DIR		:= $(BUILDDIR)/$(TCPREPLAY)
TCPREPLAY_LICENSE	:= GPL-3.0-only AND BSD-4-Clause-UC AND BSD-3-Clause
TCPREPLAY_LICENSE_FILES := \
	file://docs/LICENSE;md5=10f0474a2f0e5dccfca20f69d6598ad8 \
	file://src/tcpreplay.c;startline=4;endline=15;md5=9b41c5c891f51dfe9669e794a1d680c7 \
	file://src/common/err.c;startline=14;endline=43;md5=0fd028531634bf7aba2791035e3c2de4 \
	file://src/common/fakepoll.c;startline=8;endline=36;md5=903f05912a12e9a01b3018b915a1a7df

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
TCPREPLAY_CONF_TOOL	:= autoconf
TCPREPLAY_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-asan \
	--disable-tsan \
	--disable-debug \
	--disable-extra-debug \
	--disable-dmalloc \
	--disable-efence \
	--disable-gprof \
	--disable-pcapconfig \
	--enable-dynamic-link \
	--disable-tuntap \
	--disable-nls \
	--enable-local-libopts \
	--disable-libopts-install \
	--with-libpcap=$(PTXDIST_SYSROOT_TARGET)/usr \
	--without-netmap \
	--without-libdnet \
	--without-pcapnav-config \
	--without-tcpdump \
	--without-autoopts-config \
	--without-regex-header \
	--without-libregex

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tcpreplay.targetinstall:
	@$(call targetinfo)

	@$(call install_init, tcpreplay)
	@$(call install_fixup, tcpreplay,PRIORITY,optional)
	@$(call install_fixup, tcpreplay,SECTION,base)
	@$(call install_fixup, tcpreplay,AUTHOR,"Bastian Krause <bst@pengutronix.de>")
	@$(call install_fixup, tcpreplay,DESCRIPTION,missing)

	@$(call install_copy, tcpreplay, 0, 0, 0755, -, /usr/bin/tcpreplay)

	@$(call install_finish, tcpreplay)

	@$(call touch)

# vim: syntax=make
