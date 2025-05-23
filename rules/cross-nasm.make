# -*-makefile-*-
#
# Copyright (C) 2003 by Dan Kegel http://kegel.com
#               2006-2009 by Marc Kleine-Bude <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
CROSS_PACKAGES-$(PTXCONF_CROSS_NASM) += cross-nasm

#
# Paths and names
#
CROSS_NASM_VERSION	:= 2.16.03
ifdef PTXCONF_ARCH_X86
CROSS_NASM_MD5		:= 2b8c72c52eee4f20085065e68ac83b55
CROSS_NASM		:= nasm-$(CROSS_NASM_VERSION)
CROSS_NASM_SUFFIX	:= tar.xz
CROSS_NASM_URL		:= \
	http://www.nasm.us/pub/nasm/releasebuilds/$(CROSS_NASM_VERSION)/$(CROSS_NASM).$(CROSS_NASM_SUFFIX) \
	https://snapshot.debian.org/archive/debian/20250401T023134Z/pool/main/n/nasm/nasm_$(CROSS_NASM_VERSION).orig.$(CROSS_NASM_SUFFIX)
CROSS_NASM_SOURCE	:= $(SRCDIR)/$(CROSS_NASM).$(CROSS_NASM_SUFFIX)
CROSS_NASM_DIR		:= $(CROSS_BUILDDIR)/$(CROSS_NASM)
CROSS_NASM_LICENSE	:= BSD-2-Clause
CROSS_NASM_LICENSE_FILES := \
	file://LICENSE;md5=90904486f8fbf1861cf42752e1a39efe

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
CROSS_NASM_CONF_TOOL := autoconf
CROSS_NASM_INSTALL_OPT := INSTALLROOT="$(CROSS_NASM_PKGDIR)" install

else
CROSS_NASM_LICENSE      := ignore
endif

# vim: syntax=make
