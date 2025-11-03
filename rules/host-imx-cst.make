# -*-makefile-*-
#
# Copyright (C) 2014, 2015, 2016 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_IMX_CST) += host-imx-cst

#
# Paths and names
#
HOST_IMX_CST_VERSION	:= 3.4.1
HOST_IMX_CST_MD5	:= 72aeb8e0394c3117c5a19da0e7e4fa84
HOST_IMX_CST		:= cst-$(HOST_IMX_CST_VERSION)
HOST_IMX_CST_MOD	:= +dfsg.orig
HOST_IMX_CST_SUFFIX	:= tar.xz
HOST_IMX_CST_URL	:= https://snapshot.debian.org/archive/debian/20251014T030053Z/pool/main/i/imx-code-signing-tool/imx-code-signing-tool_$(HOST_IMX_CST_VERSION)$(HOST_IMX_CST_MOD).$(HOST_IMX_CST_SUFFIX)
HOST_IMX_CST_SOURCE	:= $(SRCDIR)/$(HOST_IMX_CST).$(HOST_IMX_CST_SUFFIX)
HOST_IMX_CST_DIR	:= $(HOST_BUILDDIR)/$(HOST_IMX_CST)
HOST_IMX_CST_LICENSE	:= BSD-3-Clause AND (OpenSSL OR Apache-2.0) AND custom
HOST_IMX_CST_LICENSE_FILES := \
	file://Software_Content_Register_CST.txt;startline=5;endline=8;md5=58eeb2145e365237c49d5e91f6b10f7d \
	file://code/front_end/src/cst.c;startline=1;endline=5;md5=d3dc6d769e75ac1dd16b77d9ab467521 \
	file://LICENSE.bsd3;md5=14aba05f9fa6c25527297c8aac95fcf6 \
	file://LICENSE.openssl;md5=3441526b1df5cc01d812c7dfc218cea6 \
	file://LICENSE.hidapi;md5=e0ea014f523f64f0adb13409055ee59e


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_IMX_CST_CONF := NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

HOST_IMX_CST_ARCH := \
	linux$(call ptx/ifeq, GNU_BUILD, x86_64-%, 64, 32)

HOST_IMX_CST_MAKE_ENV := \
	$(HOST_ENV) \
	OPENSSL_PATH="$(PTXDIST_SYSROOT_HOST)/usr/lib/"

HOST_IMX_CST_MAKE_OPT := \
	YACC=bison

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

HOST_IMX_CST_PROGS := \
	cst \
	srktool \
	mac_dump

$(STATEDIR)/host-imx-cst.install:
	@$(call targetinfo)
	@$(foreach prog, $(HOST_IMX_CST_PROGS), \
		install -v -m0755 -D $(HOST_IMX_CST_DIR)/build/$(HOST_IMX_CST_ARCH)/bin/$(prog) \
		$(HOST_IMX_CST_PKGDIR)/usr/bin/$(prog)$(ptx/nl))
	@$(call touch)

# vim: syntax=make
