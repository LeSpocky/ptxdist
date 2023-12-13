# -*-makefile-*-
#
# Copyright (C) 2013 by Michael Grzeschik <mgr@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_KEYUTILS) += keyutils

#
# Paths and names
#
KEYUTILS_VERSION	:= 1.6.3
KEYUTILS_MD5		:= 6b70b2b381c1b6d9adfaf66d5d3e7c00
KEYUTILS		:= keyutils-$(KEYUTILS_VERSION)
KEYUTILS_SUFFIX		:= tar.gz
KEYUTILS_URL		:= https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git/snapshot/$(KEYUTILS).$(KEYUTILS_SUFFIX)
KEYUTILS_SOURCE		:= $(SRCDIR)/$(KEYUTILS).$(KEYUTILS_SUFFIX)
KEYUTILS_DIR		:= $(BUILDDIR)/$(KEYUTILS)
KEYUTILS_LICENSE	:= GPL-2.0-or-later AND LGPL-2.1-or-later
KEYUTILS_LICENSE_FILES	:= \
	file://keyctl.c;startline=1;endline=10;md5=0b1fcf840ca0484f208ebf00b1d87a74 \
	file://LICENCE.GPL;md5=5f6e72824f5da505c1f4a7197f004b45 \
	file://keyutils.c;startline=1;endline=10;md5=944d046e96ff177131a078ba3957e2c7 \
	file://LICENCE.LGPL;md5=7d1cacaa3ea752b72ea5e525df54a21f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

KEYUTILS_CONF_TOOL := NO
KEYUTILS_MAKE_OPT := \
	$(CROSS_ENV_CC) \
	CFLAGS="-O2 -g3 -Wall" \
	BUILDFOR="" \
	BINDIR=/usr/bin \
	SBINDIR=/usr/sbin \
	LIBDIR=/usr/lib \
	USRLIBDIR=/usr/lib

KEYUTILS_INSTALL_OPT := \
	$(KEYUTILS_MAKE_OPT) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/keyutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, keyutils)
	@$(call install_fixup, keyutils,PRIORITY,optional)
	@$(call install_fixup, keyutils,SECTION,base)
	@$(call install_fixup, keyutils,AUTHOR,"Michael Grzeschik <mgr@pengutronix.de>")
	@$(call install_fixup, keyutils,DESCRIPTION,missing)

	@$(call install_lib, keyutils, 0, 0, 0644, libkeyutils)

	@$(call install_alternative, keyutils, 0, 0, 0644, /etc/request-key.conf)
	@$(call install_copy, keyutils, 0, 0, 0755, -, /usr/sbin/key.dns_resolver)
	@$(call install_copy, keyutils, 0, 0, 0755, -, /usr/sbin/request-key)
	@$(call install_copy, keyutils, 0, 0, 0755, -, /usr/bin/keyctl)

	@$(call install_finish, keyutils)

	@$(call touch)

# vim: syntax=make
