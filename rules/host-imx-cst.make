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
HOST_IMX_CST_MD5	:= b23ed5983734d4812fcf1da33eac8f31
HOST_IMX_CST		:= cst-$(HOST_IMX_CST_VERSION)
HOST_IMX_CST_SUFFIX	:= tgz
HOST_IMX_CST_SOURCE	:= $(SRCDIR)/$(HOST_IMX_CST).$(HOST_IMX_CST_SUFFIX)
HOST_IMX_CST_DIR	:= $(HOST_BUILDDIR)/$(HOST_IMX_CST)
HOST_IMX_CST_LICENSE	:= proprietary

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_IMX_CST_SOURCE):
	@$(call targetinfo)
	@echo "************************************************************************"
	@echo "*"
	@echo "* Due to license restrictions please download version $(HOST_IMX_CST_VERSION) manually from:"
	@echo "*"
	@echo "*    https://www.nxp.com/webapp/sps/download/license.jsp?colCode=IMX_CST_TOOL_NEW"
	@echo "*"
	@echo "* and place it into the source directory as:"
	@echo "*"
	@echo "*    $(HOST_IMX_CST_SOURCE)"
	@echo "*"
	@echo "*"
	@echo "************************************************************************"
	@echo
	@exit 1

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
