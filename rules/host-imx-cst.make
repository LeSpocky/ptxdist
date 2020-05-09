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
HOST_IMX_CST_VERSION	:= 3.1.0
HOST_IMX_CST_MD5	:= 89a2d6c05253c4de9a1bf9d5710bb7ae
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
	@echo "*    https://www.nxp.com/webapp/sps/download/license.jsp?colCode=IMX_CST_TOOL"
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

$(STATEDIR)/host-imx-cst.compile:
	@$(call targetinfo)
	cd $(HOST_IMX_CST_DIR)/code/back_end/src && \
		$(HOSTCC) \
		-Wall -O2 -g3 -o ../../../$(HOST_IMX_CST_ARCH)/bin/cst \
		-I ../hdr -L ../../../$(HOST_IMX_CST_ARCH)/lib *.c -lfrontend -lcrypto
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

HOST_IMX_CST_PROGS := \
	cst \
	srktool \
	x5092wtls

HOST_IMX_CST_LIBS := \
	libfrontend.a

$(STATEDIR)/host-imx-cst.install:
	@$(call targetinfo)
	@$(foreach prog, $(HOST_IMX_CST_PROGS), \
		install -v -m0755 -D $(HOST_IMX_CST_DIR)/$(HOST_IMX_CST_ARCH)/bin/$(prog) \
		$(HOST_IMX_CST_PKGDIR)/bin/$(prog)$(ptx/nl))
	@$(foreach lib, $(HOST_IMX_CST_LIBS), \
		install -v -m0644 -D $(HOST_IMX_CST_DIR)/$(HOST_IMX_CST_ARCH)/lib/$(lib) \
		$(HOST_IMX_CST_PKGDIR)/lib/imx-cst/$(lib)$(ptx/nl))
	@$(call touch)

# vim: syntax=make
