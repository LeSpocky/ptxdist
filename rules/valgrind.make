# -*-makefile-*-
#
# Copyright (C) 2005 by Shahar Livne <shahar@livnex.com>
#               2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_VALGRIND) += valgrind
PACKAGES-$(PTXCONF_ARCH_PPC)-$(PTXCONF_VALGRIND) += valgrind
PACKAGES-$(PTXCONF_ARCH_ARM_V6)-$(PTXCONF_VALGRIND) += valgrind
PACKAGES-$(PTXCONF_ARCH_ARM64)-$(PTXCONF_VALGRIND) += valgrind

#
# Paths and names
#
VALGRIND_VERSION	:= 3.26.0
VALGRIND_MD5		:= 856da1bc568212df6df502295a0439c0
VALGRIND		:= valgrind-$(VALGRIND_VERSION)
VALGRIND_SUFFIX		:= tar.bz2
VALGRIND_URL		:= https://sourceware.org/pub/valgrind/$(VALGRIND).$(VALGRIND_SUFFIX)
VALGRIND_SOURCE		:= $(SRCDIR)/$(VALGRIND).$(VALGRIND_SUFFIX)
VALGRIND_DIR		:= $(BUILDDIR)/$(VALGRIND)
VALGRIND_LICENSE	:= GPL-3.0-or-later
VALGRIND_LICENSE_FILES	:= \
	file://callgrind/main.c;startline=11;endline=29;md5=fe8226d12ff76de4dd8e5e71abed2056 \
	file://COPYING;md5=1ebbd3e34237af26da5dc08a4e440464

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ifdef KERNEL_VERSION
VALGRIND_KERNEL_VERSION := $(KERNEL_VERSION)
endif

ifdef KERNEL_HEADER_VERSION
VALGRIND_KERNEL_VERSION := $(KERNEL_HEADER_VERSION)
endif

VALGRIND_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_host=$(patsubst arm-v7a%,armv7a-unknown%,$(PTXCONF_GNU_TARGET)) \
	valgrind_cv_sys_kernel_version=$(VALGRIND_KERNEL_VERSION)

ifdef PTXCONF_VALGRIND
ifeq ($(VALGRIND_KERNEL_VERSION),)
$(call ptx/error, Linux kernel version required in order to make valgrind work!)
$(call ptx/error, Define a platform kernel or the kernel headers.)
endif
endif

#
# autoconf
#
VALGRIND_CONF_TOOL	:= autoconf
VALGRIND_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-only64bit \
	--disable-only32bit \
	--disable-inner \
	--disable-ubsan \
	--disable-lto \
	--enable-tls \
	--without-mpicc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/valgrind.targetinstall:
	@$(call targetinfo)

	@$(call install_init, valgrind)
	@$(call install_fixup, valgrind,PRIORITY,optional)
	@$(call install_fixup, valgrind,SECTION,base)
	@$(call install_fixup, valgrind,AUTHOR,"Shahar Livne <shahar@livnex.com>")
	@$(call install_fixup, valgrind,DESCRIPTION,missing)

	@$(call install_copy, valgrind, 0, 0, 0755, -, /usr/bin/valgrind)

	@$(call install_tree, valgrind, 0, 0, -, /usr/libexec/valgrind)

	@$(call install_finish, valgrind)

	@$(call touch)

# vim: syntax=make
