# -*-makefile-*-
#
# Copyright (C) 2021 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBWACOM) += libwacom

#
# Paths and names
#
LIBWACOM_VERSION	:= 2.9.0
LIBWACOM_MD5		:= 2824d1d0b3f8e4a5bc47acb5fca28d11
LIBWACOM		:= libwacom-$(LIBWACOM_VERSION)
LIBWACOM_SUFFIX		:= tar.gz
LIBWACOM_URL		:= https://github.com/linuxwacom/libwacom/archive/$(LIBWACOM).$(LIBWACOM_SUFFIX)
LIBWACOM_SOURCE		:= $(SRCDIR)/$(LIBWACOM).$(LIBWACOM_SUFFIX)
LIBWACOM_DIR		:= $(BUILDDIR)/$(LIBWACOM)
LIBWACOM_LICENSE	:= HPND
LIBWACOM_LICENSE_FILES	:= file://COPYING;md5=40a21fffb367c82f39fd91a3b137c36e

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBWACOM_CONF_TOOL	:= meson
LIBWACOM_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Ddocumentation=disabled \
	-Dtests=disabled \
	-Dudev-dir=/usr/lib/udev \

ifdef PTXCONF_SYSTEMD_HWDB
$(STATEDIR)/systemd-hwdb.extract.post: $(STATEDIR)/libwacom.install.post
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libwacom.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libwacom)
	@$(call install_fixup, libwacom,PRIORITY,optional)
	@$(call install_fixup, libwacom,SECTION,base)
	@$(call install_fixup, libwacom,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libwacom,DESCRIPTION,missing)

	@$(call install_lib, libwacom, 0, 0, 0644, libwacom)

	@$(call install_copy, libwacom, 0, 0, 0644, -, \
		/usr/lib/udev/rules.d/65-libwacom.rules)

	@$(call install_tree, libwacom, 0, 0, -, /usr/share/libwacom)

	@$(call install_finish, libwacom)

	@$(call touch)

# vim: syntax=make
