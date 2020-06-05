# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifndef PTXCONF_ARCH_ARM64
PACKAGES-$(PTXCONF_JAMVM) += jamvm
endif

#
# Paths and names
#
JAMVM_VERSION	:= 1.5.4
JAMVM_MD5	:= 7654e9657691f5f09c4f481ed4686176
JAMVM		:= jamvm-$(JAMVM_VERSION)
JAMVM_SUFFIX	:= tar.gz
JAMVM_URL	:= $(call ptx/mirror, SF, jamvm/$(JAMVM).$(JAMVM_SUFFIX))
JAMVM_SOURCE	:= $(SRCDIR)/$(JAMVM).$(JAMVM_SUFFIX)
JAMVM_DIR	:= $(BUILDDIR)/$(JAMVM)
JAMVM_LICENSE	:= GPL-2.0-or-later
JAMVM_LICENSE_FILES	:= \
	file://src/jam.c;md5=728ff94e750b0b405946b3f4ef038fac;startline=7;endline=20 \
	file://COPYING;md5=0636e73ff0215e8d672dc4c32c317bb3

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

JAMVM_PATH	:= PATH=$(CROSS_PATH)
JAMVM_ENV 	:= $(CROSS_ENV)

JAMVM_CPPFLAGS = -I$(SYSROOT)/usr/lib/libffi-$(LIBFFI_VERSION)/include
ifdef PTXCONF_ARCH_ARM
JAMVM_CFLAGS := -marm
endif

#
# autoconf
#
JAMVM_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-int-threading \
	--enable-int-direct \
	--enable-int-caching \
	--disable-int-prefetch \
	--enable-runtime-reloc-checks \
	--disable-int-inlining \
	--enable-zip \
	--enable-fast-install \
	--with-classpath-install-dir=/usr

ifdef PTXCONF_JAMVM_USE_LIBFFI
JAMVM_AUTOCONF += --enable-ffi
else
JAMVM_AUTOCONF += --disable-ffi
endif

ifndef PTXCONF_JAMVM_TRACE
JAMVM_AUTOCONF += --disable-trace
endif

ifdef PTXCONF_JAMVM_TRACE_ALL
JAMVM_AUTOCONF += --enable-trace
endif

ifdef PTXCONF_JAMVM_TRACE_GC
JAMVM_AUTOCONF += --enable-tracegc
endif

ifdef PTXCONF_JAMVM_TRACE_ALLOC
JAMVM_AUTOCONF += --enable-tracealloc
endif

ifdef PTXCONF_JAMVM_TRACE_FNLZ
JAMVM_AUTOCONF += --enable-tracefnlz
endif

ifdef PTXCONF_JAMVM_TRACE_DLL
JAMVM_AUTOCONF += --enable-tracedll
endif

ifdef PTXCONF_JAMVM_TRACE_LOCK
JAMVM_AUTOCONF += --enable-tracelock
endif

ifdef PTXCONF_JAMVM_TRACE_THREAD
JAMVM_AUTOCONF += --enable-tracethread
endif

ifdef PTXCONF_JAMVM_TRACE_DIRECT
JAMVM_AUTOCONF += --enable-tracedirect
endif

ifdef PTXCONF_JAMVM_TRACE_INLINING
JAMVM_AUTOCONF += --enable-traceinlining
endif

# FIXME:
# - --enable-int-caching should be disabled on x86_64
# - --enable-int-prefetch should be enabled on powerpc
# - --enable-int-inlining should be enabled on x86_64, i386 and powerpc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/jamvm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, jamvm)
	@$(call install_fixup, jamvm,PRIORITY,optional)
	@$(call install_fixup, jamvm,SECTION,base)
	@$(call install_fixup, jamvm,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, jamvm,DESCRIPTION,missing)

	@$(call install_copy, jamvm, 0, 0, 0755, -, /usr/bin/jamvm)
	@$(call install_copy, jamvm, 0, 0, 0644, -, /usr/share/jamvm/classes.zip)

	@$(call install_lib, jamvm, 0, 0, 0644, libjvm)

	@$(call install_finish, jamvm)

	@$(call touch)

# vim: syntax=make
