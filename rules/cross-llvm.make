# -*-makefile-*-
#
# Copyright (C) 2024 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
CROSS_PACKAGES-$(PTXCONF_CROSS_LLVM) += cross-llvm

#
# Paths and names
#

CROSS_LLVM_CMAKE_MD5		 = $(LLVM_CMAKE_MD5)
CROSS_LLVM_CMAKE_URL		 = $(LLVM_CMAKE_URL)
CROSS_LLVM_CMAKE_SOURCE		 = $(LLVM_CMAKE_SOURCE)
CROSS_LLVM_CMAKE_DIR		 = $(CROSS_BUILDDIR)/$(CROSS_LLVM)/cmake

CROSS_LLVM_PARTS		+= CROSS_LLVM_CMAKE

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CROSS_LLVM_CONF_ENV	:= \
	$(HOST_ENV)

#
# cmake
#
CROSS_LLVM_CONF_TOOL	:= cmake
CROSS_LLVM_CONF_OPT	 =  \
	$(HOST_CROSS_CMAKE_OPT) \
	$(call LLVM_SHARED_CONF_OPT,ON,)

CROSS_LLVM_MAKE_OPT	:= \
	llvm-config \
	llvm-tblgen

CROSS_LLVM_INSTALL_OPT	:= \
	install-llvm-config

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cross-llvm.install:
	@$(call targetinfo)
	@$(call world/install, CROSS_LLVM)
	@install -vD -m755 $(CROSS_LLVM_DIR)-build/bin/llvm-tblgen \
		$(CROSS_LLVM_PKGDIR)/usr/bin/llvm-tblgen
	@mv -v $(CROSS_LLVM_PKGDIR)/usr/bin/llvm-config \
		$(CROSS_LLVM_PKGDIR)/usr/bin/llvm-config.orig
	@$(call touch)

# vim: syntax=make
