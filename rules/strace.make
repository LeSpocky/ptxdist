# -*-makefile-*-
#
# Copyright (C) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
#               2003-2008 by Pengutronix e.K., Hildesheim, Germany
#               2009, 2010, 2012 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_STRACE) += strace

#
# Paths and names
#
STRACE_VERSION	:= 6.12
STRACE_MD5	:= 6b774465c06b0dd01efc00a2db1341c2
STRACE		:= strace-$(STRACE_VERSION)
STRACE_SUFFIX	:= tar.xz
STRACE_URL	:= https://strace.io/files/$(STRACE_VERSION)/$(STRACE).$(STRACE_SUFFIX)
STRACE_SOURCE	:= $(SRCDIR)/$(STRACE).$(STRACE_SUFFIX)
STRACE_DIR	:= $(BUILDDIR)/$(STRACE)
STRACE_LICENSE	:= LGPL-2.1-or-later AND GPL-2.0-only WITH Linux-syscall-note
STRACE_LICENSE_FILES := \
	file://COPYING;md5=2433d82e1432a76dc3eadd9002bfe304\
	file://bundled/linux/COPYING;md5=391c7a5bbfb151ad3dbe0a7fb5791a46 \
	file://bundled/linux/GPL-2.0;md5=e6a75371ba4d16749254a51215d13f97 \
	file://LGPL-2.1-or-later;md5=9e4c7a7a5be83d7f3da645ac5d466052

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

STRACE_CONF_TOOL	:= autoconf
STRACE_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-code-coverage \
	--enable-bundled=check \
	--disable-arm-oabi \
	--disable-gcc-Werror \
	--disable-stacktrace \
	--disable-mpers \
	--enable-install-tests=no \
	--disable-valgrind \
	--disable-valgrind-memcheck \
	--disable-valgrind-helgrind \
	--disable-valgrind-drd \
	--disable-valgrind-sgcheck \
	--without-gcov \
	--without-libdw \
	--without-libunwind \
	--without-libiberty \
	--without-libselinux

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/strace.targetinstall:
	@$(call targetinfo)

	@$(call install_init, strace)
	@$(call install_fixup, strace,PRIORITY,optional)
	@$(call install_fixup, strace,SECTION,base)
	@$(call install_fixup, strace,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, strace,DESCRIPTION,missing)

	@$(call install_copy, strace, 0, 0, 0755, -, /usr/bin/strace)

	@$(call install_finish, strace)

	@$(call touch)

# vim: syntax=make
