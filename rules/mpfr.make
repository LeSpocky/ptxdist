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
PACKAGES-$(PTXCONF_MPFR) += mpfr

#
# Paths and names
#
MPFR_VERSION		:= 4.2.1
MPFR_MD5		:= 523c50c6318dde6f9dc523bc0244690a
MPFR			:= mpfr-$(MPFR_VERSION)
MPFR_SUFFIX		:= tar.xz
MPFR_URL		:= https://www.mpfr.org/$(MPFR)/$(MPFR).$(MPFR_SUFFIX)
MPFR_SOURCE		:= $(SRCDIR)/$(MPFR).$(MPFR_SUFFIX)
MPFR_DIR		:= $(BUILDDIR)/$(MPFR)
MPFR_LICENSE		:= LGPL-3.0-or-later
MPFR_LICENSE_FILES	:= \
	file://COPYING;md5=1ebbd3e34237af26da5dc08a4e440464 \
	file://COPYING.LESSER;md5=3000208d539ec061b899bce1d9ce9404


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
MPFR_CONF_TOOL	:= autoconf
MPFR_CONF_OPT	:=  \
	$(CROSS_AUTOCONF_USR) \
	--disable-gmp-internals \
	--disable-assert \
	--disable-logging \
	--enable-thread-safe \
	--disable-shared-cache \
	--disable-warnings \
	--disable-tune-for-coverage \
	--disable-debug-prediction \
	--disable-lto \
	--disable-formally-proven-code

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mpfr.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mpfr)
	@$(call install_fixup, mpfr,PRIORITY,optional)
	@$(call install_fixup, mpfr,SECTION,base)
	@$(call install_fixup, mpfr,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, mpfr,DESCRIPTION,missing)

	@$(call install_lib, mpfr, 0, 0, 0644, libmpfr)

	@$(call install_finish, mpfr)

	@$(call touch)

# vim: syntax=make
