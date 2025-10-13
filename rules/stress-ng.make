# -*-makefile-*-
#
# Copyright (C) 2018 by Jan Luebbe <jlu@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_STRESS_NG) += stress-ng

#
# Paths and names
#
STRESS_NG_VERSION	:= 0.19.05
STRESS_NG_MD5		:= 476610bc19136bff42cda60cdd0493af
STRESS_NG		:= stress-ng-$(STRESS_NG_VERSION)
STRESS_NG_SUFFIX	:= tar.gz
STRESS_NG_URL		:= https://github.com/ColinIanKing/stress-ng/archive/refs/tags/V$(STRESS_NG_VERSION).$(STRESS_NG_SUFFIX)
STRESS_NG_SOURCE	:= $(SRCDIR)/$(STRESS_NG).$(STRESS_NG_SUFFIX)
STRESS_NG_DIR		:= $(BUILDDIR)/$(STRESS_NG)
STRESS_NG_LICENSE	:= GPL-2.0-or-later
STRESS_NG_LICENSE_FILES	:= file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

STRESS_NG_CONF_TOOL	:= NO

$(STATEDIR)/stress-ng.prepare:
	@$(call targetinfo)
	@mkdir -p $(STRESS_NG_DIR)/configs
	@: > $(STRESS_NG_DIR)/configs/HAVE_LIB_ACL
	@: > $(STRESS_NG_DIR)/configs/HAVE_APPARMOR
	@: > $(STRESS_NG_DIR)/configs/HAVE_LIB_EGL
	@: > $(STRESS_NG_DIR)/configs/HAVE_LIB_GBM
	@: > $(STRESS_NG_DIR)/configs/HAVE_LIB_GLES2
	@: > $(STRESS_NG_DIR)/configs/HAVE_LIB_GMP
	@: > $(STRESS_NG_DIR)/configs/HAVE_LIB_IPSEC_MB
	@: > $(STRESS_NG_DIR)/configs/HAVE_LIB_JUDY
	@: > $(STRESS_NG_DIR)/configs/HAVE_LIB_KMOD
	@: > $(STRESS_NG_DIR)/configs/HAVE_LIB_MD
	@: > $(STRESS_NG_DIR)/configs/HAVE_LIB_MPFR
	@: > $(STRESS_NG_DIR)/configs/HAVE_LIB_SCTP
	@: > $(STRESS_NG_DIR)/configs/HAVE_LIB_LZMA
	@$(call touch)


# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

STRESS_NG_MAKE_ENV	:= $(CROSS_ENV)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/stress-ng.targetinstall:
	@$(call targetinfo)

	@$(call install_init, stress-ng)
	@$(call install_fixup, stress-ng,PRIORITY,optional)
	@$(call install_fixup, stress-ng,SECTION,base)
	@$(call install_fixup, stress-ng,AUTHOR,"Jan Luebbe <jlu@pengutronix.de>")
	@$(call install_fixup, stress-ng,DESCRIPTION,missing)

	@$(call install_copy, stress-ng, 0, 0, 0755, -, /usr/bin/stress-ng)

	@$(call install_finish, stress-ng)

	@$(call touch)

# vim: syntax=make
