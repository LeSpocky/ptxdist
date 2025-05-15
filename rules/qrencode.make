# -*-makefile-*-
#
# Copyright (C) 2017 by Roland Hieber <r.hieber@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_QRENCODE) += qrencode

#
# Paths and names
#
QRENCODE_VERSION	:= 4.1.1
QRENCODE_MD5		:= a046d19b4ad90d9f28ee0b3f29b60da6
QRENCODE		:= qrencode-$(QRENCODE_VERSION)
QRENCODE_SUFFIX		:= tar.gz
QRENCODE_URL		:= https://github.com/fukuchi/libqrencode/archive/refs/tags/v$(QRENCODE_VERSION).$(QRENCODE_SUFFIX)
QRENCODE_SOURCE		:= $(SRCDIR)/$(QRENCODE).$(QRENCODE_SUFFIX)
QRENCODE_DIR		:= $(BUILDDIR)/$(QRENCODE)
QRENCODE_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

QRENCODE_CONF_TOOL	:= autoconf
QRENCODE_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-thread-safety \
	--disable-rpath \
	--disable-gprof \
	--disable-gcov \
	--disable-mudflap \
	--disable-asan \
	--$(call ptx/wwo,PTXCONF_QRENCODE_TOOLS)-png \
	--$(call ptx/wwo,PTXCONF_QRENCODE_TOOLS)-tools \
	--without-tests

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/qrencode.targetinstall:
	@$(call targetinfo)

	@$(call install_init, qrencode)
	@$(call install_fixup, qrencode,PRIORITY,optional)
	@$(call install_fixup, qrencode,SECTION,base)
	@$(call install_fixup, qrencode,AUTHOR,"Roland Hieber <r.hieber@pengutronix.de>")
	@$(call install_fixup, qrencode,DESCRIPTION,missing)

	@$(call install_lib, qrencode, 0, 0, 0644, libqrencode)

ifdef PTXCONF_QRENCODE_TOOLS
	@$(call install_copy, qrencode, 0, 0, 0755, -, /usr/bin/qrencode)
endif

	@$(call install_finish, qrencode)

	@$(call touch)

# vim: ft=make ts=8 noet tw=80
