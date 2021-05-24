# -*-makefile-*-
#
# Copyright (C) 2007 by Carsten Schlote <c.schlote@konzeptpark.de>
#               2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2021 Roland Hieber, Pengutronix <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MINICOM) += minicom

#
# Paths and names
#
MINICOM_VERSION	:= 2.8
MINICOM_MD5	:= d32eb2e615f286611c4d1877a25939be
MINICOM_SUFFIX	:= tar.bz2
MINICOM		:= minicom-$(MINICOM_VERSION)
MINICOM_TARBALL	:= minicom_$(MINICOM_VERSION).orig.$(MINICOM_SUFFIX)
MINICOM_URL	:= http://snapshot.debian.org/archive/debian/20210524T032801Z/pool/main/m/minicom/$(MINICOM_TARBALL)
MINICOM_SOURCE	:= $(SRCDIR)/$(MINICOM).$(MINICOM_SUFFIX)
MINICOM_DIR	:= $(BUILDDIR)/$(MINICOM)
MINICOM_LICENSE	:= LGPL-2.0-or-later AND xinetd AND GPL-2.0-or-later
MINICOM_LICENSE_FILES	:= \
	file://lib/getopt.c;startline=12;endline=20;md5=33478700692dbfddf8702809f842f9dc \
	file://lib/snprintf.c;startline=15;endline=40;md5=a311a669ac916dad747dde2011caed9b \
	file://src/main.c;startline=7;endline=10;md5=908a4d755c7a49f4c6156a07400f3d60 \
	file://COPYING;md5=420477abc567404debca0a2a1cb6b645

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
MINICOM_CONF_TOOL	:= autoconf
MINICOM_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-rpath \
	--disable-music \
	--enable-socket \
	--enable-lock-dir=/var/lock \
	--enable-dfl-port=/dev/modem \
	--enable-dfl-baud=115200 \
	--enable-cfg-dir=/etc \
	--enable-kermit=$(call ptx/ifdef,PTXCONF_MINICOM_KERMIT,/usr/bin/ckermit,/usr/bin/false) \
	--disable-nls \
	--without-dmalloc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/minicom.targetinstall:
	@$(call targetinfo)

	@$(call install_init, minicom)
	@$(call install_fixup, minicom,PRIORITY,optional)
	@$(call install_fixup, minicom,SECTION,base)
	@$(call install_fixup, minicom,AUTHOR,"Carsten Schlote <c.schlote@konzeptpark.de>")
	@$(call install_fixup, minicom,DESCRIPTION,missing)

	@$(call install_copy, minicom, 0, 0, 0755, -, /usr/bin/minicom)
	@$(call install_copy, minicom, 0, 0, 0755, -, /usr/bin/runscript)
	@$(call install_copy, minicom, 0, 0, 0755, -, /usr/bin/ascii-xfr)

ifdef PTXCONF_MINICOM_DEFCONFIG
	@$(call install_alternative, minicom, 0, 0, 0644, /etc/minirc.dfl)
endif
	@$(call install_finish, minicom)

	@$(call touch)

# vim: syntax=make
