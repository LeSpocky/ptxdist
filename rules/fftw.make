# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FFTW) += fftw

#
# Paths and names
#
FFTW_VERSION	:= 3.2.2
FFTW_MD5	:= b616e5c91218cc778b5aa735fefb61ae
FFTW		:= fftw-$(FFTW_VERSION)
FFTW_SUFFIX	:= tar.gz
FFTW_SOURCE	:= $(SRCDIR)/$(FFTW).$(FFTW_SUFFIX)
FFTW_DIR	:= $(BUILDDIR)/$(FFTW)
FFTW_URL	:= \
	http://www.fftw.org/$(FFTW).$(FFTW_SUFFIX) \
	ftp://ftp.fftw.org/pub/fftw/old/$(FFTW).$(FFTW_SUFFIX)
FFTW_LICENSE	:= GPL-2.0-or-later
FFTW_LICENSE_FILES	:= \
	file://COPYRIGHT;md5=f19d163a5d9bc582a8ba578f591eab80 \
	file://COPYING;md5=59530bdf33659b29e73d4adb9f9f6552

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FFTW_PATH	:= PATH=$(CROSS_PATH)
FFTW_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
FFTW_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fftw.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fftw)
	@$(call install_fixup, fftw,PRIORITY,optional)
	@$(call install_fixup, fftw,SECTION,base)
	@$(call install_fixup, fftw,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, fftw,DESCRIPTION,missing)

	@$(call install_lib, fftw, 0, 0, 0644, libfftw3)

	@$(call install_finish, fftw)

	@$(call touch)

# vim: syntax=make
