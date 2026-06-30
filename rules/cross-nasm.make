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
CROSS_NASM_VERSION	:= 3.02
ifdef PTXCONF_ARCH_X86
CROSS_NASM_SHA256	:= 87336eba53b4acfe917424ab5d500d2b0054d9f5148d35c2273ccf2cfb712f0d
CROSS_NASM		:= nasm-$(CROSS_NASM_VERSION)
CROSS_NASM_SUFFIX	:= tar.xz
CROSS_NASM_URL		:= \
	https://www.nasm.us/pub/nasm/releasebuilds/$(CROSS_NASM_VERSION)/$(CROSS_NASM).$(CROSS_NASM_SUFFIX) \
	https://snapshot.debian.org/archive/debian/20250401T023134Z/pool/main/n/nasm/nasm_$(CROSS_NASM_VERSION).orig.$(CROSS_NASM_SUFFIX)
CROSS_NASM_SOURCE	:= $(SRCDIR)/$(CROSS_NASM).$(CROSS_NASM_SUFFIX)
CROSS_NASM_DIR		:= $(CROSS_BUILDDIR)/$(CROSS_NASM)
CROSS_NASM_LICENSE	:= BSD-2-Clause
CROSS_NASM_LICENSE_FILES := \
	file://LICENSE;md5=6178dc4f5355e40552448080e67a214b

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
