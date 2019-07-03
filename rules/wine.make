# -*-makefile-*-
#
# Copyright (C) 2007, 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_MINGW)-$(PTXCONF_WINE) += wine

#
# Paths and names
#
WINE_VERSION	:= 1.0.1
WINE_MD5	:=
WINE		:= wine-$(WINE_VERSION)
WINE_SUFFIX	:= tar.bz2
WINE_URL	:= $(call ptx/mirror, SF, wine/$(WINE).$(WINE_SUFFIX))
WINE_SOURCE	:= $(SRCDIR)/$(WINE).$(WINE_SUFFIX)
WINE_DIR	:= $(BUILDDIR)/$(WINE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/wine.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/wine.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wine.install:
	@$(call targetinfo)
	install -m644 $(WINE_DIR)/include/usp10.h $(SYSROOT)/usr/include/
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wine.targetinstall:
	@$(call touch)

# vim: syntax=make
