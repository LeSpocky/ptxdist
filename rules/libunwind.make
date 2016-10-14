# -*-makefile-*-
#
# Copyright (C) 2016 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBUNWIND) += libunwind

#
# Paths and names
#
LIBUNWIND_VERSION	:= 1.1
LIBUNWIND_MD5		:= fb4ea2f6fbbe45bf032cd36e586883ce
LIBUNWIND		:= libunwind-$(LIBUNWIND_VERSION)
LIBUNWIND_SUFFIX	:= tar.gz
LIBUNWIND_URL		:= http://download.savannah.gnu.org/releases/libunwind/$(LIBUNWIND).$(LIBUNWIND_SUFFIX)
LIBUNWIND_SOURCE	:= $(SRCDIR)/$(LIBUNWIND).$(LIBUNWIND_SUFFIX)
LIBUNWIND_DIR		:= $(BUILDDIR)/$(LIBUNWIND)
LIBUNWIND_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBUNWIND_CONF_TOOL	:= autoconf
LIBUNWIND_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-coredump \
	--disable-debug \
	--enable-debug-frame \
	--enable-block-signals \
	--enable-conservative-checks \
	--disable-msabi-support \
	--disable-minidebuginfo

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

LIBUNWIND_ARCH := $(call remove_quotes,$(PTXCONF_ARCH_STRING))
ifdef PTXCONF_ARCH_X86
ifndef PTXCONF_ARCH_X86_64
LIBUNWIND_ARCH := x86
endif
endif

$(STATEDIR)/libunwind.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libunwind)
	@$(call install_fixup, libunwind,PRIORITY,optional)
	@$(call install_fixup, libunwind,SECTION,base)
	@$(call install_fixup, libunwind,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libunwind,DESCRIPTION,missing)

	@$(call install_lib, libunwind, 0, 0, 0644, libunwind)
	@$(call install_lib, libunwind, 0, 0, 0644, libunwind-coredump)
	@$(call install_lib, libunwind, 0, 0, 0644, libunwind-ptrace)
	@$(call install_lib, libunwind, 0, 0, 0644, libunwind-setjmp)
	@$(call install_lib, libunwind, 0, 0, 0644, libunwind-$(LIBUNWIND_ARCH))

	@$(call install_finish, libunwind)

	@$(call touch)

# vim: syntax=make
