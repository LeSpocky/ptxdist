# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FLEX) += flex

#
# Paths and names
#
FLEX_VERSION	:= 2.6.4
FLEX_MD5	:= 2882e3179748cc9f9c23ec593d6adc8d
FLEX		:= flex-$(FLEX_VERSION)
FLEX_SUFFIX	:= tar.gz
FLEX_URL	:= https://github.com/westes/flex/releases/download/v$(FLEX_VERSION)/$(FLEX).$(FLEX_SUFFIX)
FLEX_SOURCE	:= $(SRCDIR)/$(FLEX).$(FLEX_SUFFIX)
FLEX_DIR	:= $(BUILDDIR)/$(FLEX)
FLEX_LICENSE	:= BSD-2-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
FLEX_CONF_TOOL	:= autoconf
FLEX_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls \
	--disable-rpath \
	--disable-warnings \
	--enable-libfl \
	--disable-bootstrap

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

FLEX_MAKE_OPT	:= \
	SUBDIRS=src

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

FLEX_INSTALL_OPT	:= \
	$(FLEX_MAKE_OPT) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/flex.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  flex)
	@$(call install_fixup, flex,PRIORITY,optional)
	@$(call install_fixup, flex,SECTION,base)
	@$(call install_fixup, flex,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, flex,DESCRIPTION,missing)

	@$(call install_lib, flex, 0, 0, 0644, libfl)

	@$(call install_finish, flex)

	@$(call touch)

# vim: syntax=make
