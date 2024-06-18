# -*-makefile-*-
#
# Copyright (C) 2024 by Uwe Kleine-Koenig <u.kleine-koenig@baylibre.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBPWM) += libpwm

#
# Paths and names
#
LIBPWM_VERSION		:= 2024-04-09-gf7a7496fcb9d
LIBPWM_MD5		:= 432a7dcb3a71449d6e07c805788a721b
LIBPWM			:= libpwm-$(LIBPWM_VERSION)
LIBPWM_SUFFIX		:= tar.gz
LIBPWM_URL		:= https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.git/snapshot/$(LIBPWM_VERSION).$(LIBPWM_SUFFIX)
LIBPWM_SOURCE		:= $(SRCDIR)/$(LIBPWM).$(LIBPWM_SUFFIX)
LIBPWM_DIR		:= $(BUILDDIR)/$(LIBPWM)
LIBPWM_BUILD_OOT	:= YES
LIBPWM_LICENSE		:= LGPL-2.1-only AND 0BSD
LIBPWM_LICENSE_FILES	:= file://COPYING;md5=41d65f310284fe1f2945ea9c57f297c7

#
# autoconf
#
LIBPWM_CONF_TOOL	:= autoconf
LIBPWM_CONF_OPT		:= $(CROSS_AUTOCONF_USR)

LIBPWM_CPPFLAGS := -isystem $(KERNEL_HEADERS_INCLUDE_DIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libpwm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libpwm)
	@$(call install_fixup, libpwm, PRIORITY, optional)
	@$(call install_fixup, libpwm, SECTION, base)
	@$(call install_fixup, libpwm, AUTHOR, "Uwe Kleine-Koenig <u.kleine-koenig@baylibre.com>")
	@$(call install_fixup, libpwm, DESCRIPTION, missing)

	@$(call install_lib, libpwm, 0, 0, 0644, libpwm)
	@$(call install_copy, libpwm, 0, 0, 0755, -, /usr/bin/pwmtest)
	@$(call install_copy, libpwm, 0, 0, 0755, -, /usr/bin/pwmtestperf)

	@$(call install_finish, libpwm)

	@$(call touch)

# vim: syntax=make
