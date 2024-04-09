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
PACKAGES-$(PTXCONF_DUKTAPE) += duktape

#
# Paths and names
#
DUKTAPE_VERSION		:= 2.7.0
DUKTAPE_MD5		:= b3200b02ab80125b694bae887d7c1ca6
DUKTAPE			:= duktape-$(DUKTAPE_VERSION)
DUKTAPE_SUFFIX		:= tar.xz
DUKTAPE_URL		:= https://github.com/svaarala/duktape/releases/download/v$(DUKTAPE_VERSION)/$(DUKTAPE).$(DUKTAPE_SUFFIX)
DUKTAPE_SOURCE		:= $(SRCDIR)/$(DUKTAPE).$(DUKTAPE_SUFFIX)
DUKTAPE_DIR		:= $(BUILDDIR)/$(DUKTAPE)
DUKTAPE_LICENSE		:= MIT
DUKTAPE_LICENSE_FILES	:= \
	file://LICENSE.txt;md5=3b7825df97b52f926fc71300f7880408


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DUKTAPE_CONF_TOOL	:= NO

DUKTAPE_MAKE_ENV	:= \
	$(CROSS_ENV) \
	INSTALL_PREFIX=/usr

DUKTAPE_MAKE_OPT	:= \
	-f Makefile.sharedlibrary

DUKTAPE_INSTALL_OPT	:= \
	$(DUKTAPE_MAKE_OPT) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/duktape.targetinstall:
	@$(call targetinfo)

	@$(call install_init, duktape)
	@$(call install_fixup, duktape,PRIORITY,optional)
	@$(call install_fixup, duktape,SECTION,base)
	@$(call install_fixup, duktape,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, duktape,DESCRIPTION,missing)

	@$(call install_lib, duktape, 0, 0, 0644, libduktape)

	@$(call install_finish, duktape)

	@$(call touch)

# vim: syntax=make
