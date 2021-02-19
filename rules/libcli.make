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
PACKAGES-$(PTXCONF_LIBCLI) += libcli

#
# Paths and names
#
LIBCLI_VERSION		:= 1.10.5
LIBCLI_MD5		:= bc821296855d28917b294b83b27e82ee
LIBCLI			:= libcli-$(LIBCLI_VERSION)
LIBCLI_SUFFIX		:= tar.gz
LIBCLI_URL		:= https://github.com/dparrish/libcli/archive/V$(LIBCLI_VERSION).$(LIBCLI_SUFFIX)
LIBCLI_SOURCE		:= $(SRCDIR)/$(LIBCLI).$(LIBCLI_SUFFIX)
LIBCLI_DIR		:= $(BUILDDIR)/$(LIBCLI)
LIBCLI_LICENSE		:= LGPL-2.1-only
LIBCLI_LICENSE_FILES	:= file://COPYING;md5=cb8aedd3bced19bd8026d96a8b6876d7

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBCLI_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

LIBCLI_MAKE_OPT		:= \
	$(CROSS_ENV_PROGS) \
	PREFIX=/usr \
	STATIC_LIB=0

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

LIBCLI_INSTALL_OPT	:= \
	$(LIBCLI_MAKE_OPT) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libcli.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libcli)
	@$(call install_fixup, libcli,PRIORITY,optional)
	@$(call install_fixup, libcli,SECTION,base)
	@$(call install_fixup, libcli,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libcli,DESCRIPTION,missing)

	@$(call install_lib, libcli, 0, 0, 0644, libcli)

	@$(call install_finish, libcli)

	@$(call touch)

# vim: syntax=make
