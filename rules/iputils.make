# -*-makefile-*-
#
# Copyright (C) 2014 by Alexander Aring <aar@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IPUTILS) += iputils

#
# Paths and names
#
IPUTILS_VERSION	:= s20200821
IPUTILS_MD5	:= 85a5ce27f92d8fa2770dd290acd4c1e3
IPUTILS		:= iputils-$(IPUTILS_VERSION)
IPUTILS_SUFFIX	:= tar.gz
IPUTILS_URL	:= http://codeload.github.com/iputils/iputils/$(IPUTILS_SUFFIX)/$(IPUTILS_VERSION)
IPUTILS_SOURCE	:= $(SRCDIR)/$(IPUTILS).$(IPUTILS_SUFFIX)
IPUTILS_DIR	:= $(BUILDDIR)/$(IPUTILS)
IPUTILS_LICENSE	:= GPL-2.0-only
IPUTILS_LICENSE_FILES := file://ninfod/COPYING;md5=5e9a325527978995c41e6d9a83f6e6bd

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

IPUTILS_CONF_TOOL	:= meson
IPUTILS_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-DBUILD_ARPING=$(call ptx/truefalse, PTXCONF_IPUTILS_ARPING) \
	-DBUILD_CLOCKDIFF=$(call ptx/truefalse, PTXCONF_IPUTILS_CLOCKDIFF) \
	-DBUILD_HTML_MANS=false \
	-DBUILD_MANS=false \
	-DBUILD_NINFOD=false \
	-DBUILD_PING=$(call ptx/truefalse, PTXCONF_IPUTILS_PING) \
	-DBUILD_RARPD=$(call ptx/truefalse, PTXCONF_IPUTILS_RARPD) \
	-DBUILD_RDISC=$(call ptx/truefalse, PTXCONF_IPUTILS_RDISC) \
	-DBUILD_TFTPD=$(call ptx/truefalse, PTXCONF_IPUTILS_TFTPD) \
	-DBUILD_TRACEPATH=$(call ptx/truefalse, PTXCONF_IPUTILS_TRACEPATH) \
	-DBUILD_TRACEROUTE6=$(call ptx/truefalse, PTXCONF_IPUTILS_TRACEROUTE6) \
	-DENABLE_RDISC_SERVER=true \
	-DNINFOD_MESSAGES=true \
	-DNO_SETCAP_OR_SUID=true \
	-DSETCAP_OR_SUID_ARPING=false \
	-DSETCAP_OR_SUID_CLOCKDIFF=false \
	-DSETCAP_OR_SUID_PING=false \
	-DSETCAP_OR_SUID_TRACEROUTE6=false \
	-DUSE_CAP=$(call ptx/truefalse, PTXCONF_IPUTILS_LIBCAP) \
	-DUSE_GETTEXT=false \
	-DUSE_IDN=false \
	-Dsystemdunitdir=/usr/lib/systemd/system

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/iputils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, iputils)
	@$(call install_fixup, iputils,PRIORITY,optional)
	@$(call install_fixup, iputils,SECTION,base)
	@$(call install_fixup, iputils,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, iputils,DESCRIPTION,missing)

	@$(call install_tree, iputils, 0, 0, -, /usr/bin)
	@$(call install_tree, iputils, 0, 0, -, /usr/sbin)

	@$(call install_finish, iputils)

	@$(call touch)

# vim: syntax=make
