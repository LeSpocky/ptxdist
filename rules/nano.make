# -*-makefile-*-
#
# Copyright (C) 2004 by Robert Schwebel
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NANO) += nano

#
# Paths and names
#
NANO_VERSION		:= 8.0
NANO_MD5		:= e8561ba24e7495b766b1d815cd024e77
NANO			:= nano-$(NANO_VERSION)
NANO_SUFFIX		:= tar.gz
NANO_URL		:= https://www.nano-editor.org/dist/v$(basename $(NANO_VERSION))/$(NANO).$(NANO_SUFFIX)
NANO_SOURCE		:= $(SRCDIR)/$(NANO).$(NANO_SUFFIX)
NANO_DIR		:= $(BUILDDIR)/$(NANO)
NANO_LICENSE		:= GPL-3.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NANO_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_header_magic_h=no \
	ac_cv_lib_magic_magic_open=no

#
# autoconf
#
NANO_CONF_TOOL	:= autoconf
NANO_CONF_OPT	:= \
	--$(call ptx/endis,PTXCONF_NANO_HELPTEXT)-help \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-threads=posix \
	--disable-nls \
	--disable-rpath \
	--disable-browser \
	--enable-color \
	--enable-comment \
	--disable-extra \
	--disable-formatter \
	--enable-histories \
	--enable-justify \
	--disable-libmagic \
	--disable-linter \
	--enable-linenumbers \
	--disable-mouse \
	--enable-multibuffer \
	--enable-nanorc \
	--disable-operatingdir \
	--disable-speller \
	--enable-tabcomp \
	--disable-wordcomp \
	--enable-wrapping \
	--disable-debug \
	--disable-tiny \
	--disable-utf8 \
	--disable-altrcname \
	--$(call ptx/endis, PTXDIST_Y2038)-year2038 \
	--without-included-regex

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nano.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nano)
	@$(call install_fixup, nano,PRIORITY,optional)
	@$(call install_fixup, nano,SECTION,base)
	@$(call install_fixup, nano,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, nano,DESCRIPTION,missing)

	@$(call install_copy, nano, 0, 0, 0755, -, /usr/bin/nano)
	@$(call install_finish, nano)

	@$(call touch)

# vim: syntax=make
