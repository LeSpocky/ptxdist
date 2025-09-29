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
LIBPWM_VERSION		:= 1.0-rc2
LIBPWM_MD5		:= ccf05e263bd26418311e0e93848b3a71
LIBPWM			:= libpwm-$(LIBPWM_VERSION)
LIBPWM_SUFFIX		:= tar.xz
LIBPWM_URL		:= $(call ptx/mirror, KERNEL, kernel/people/ukleinek/libpwm/libpwm-$(LIBPWM_VERSION).tar.xz)
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

ifdef PTXCONF_KERNEL_HEADER
LIBPWM_CPPFLAGS := -isystem $(KERNEL_HEADERS_INCLUDE_DIR)
endif

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
	@$(call install_copy, libpwm, 0, 0, 0755, -, /usr/bin/pwmround)
	@$(call install_copy, libpwm, 0, 0, 0755, -, /usr/bin/pwmset)
	@$(call install_copy, libpwm, 0, 0, 0755, -, /usr/bin/pwmtestperf)

	@$(call install_finish, libpwm)

	@$(call touch)

# vim: syntax=make
