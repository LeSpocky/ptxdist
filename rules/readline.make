# -*-makefile-*-
#
# Copyright (C) 2004 by Sascha Hauer
#               2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_READLINE) += readline

#
# Paths and names
#
READLINE_VERSION	:= 8.3
READLINE_MD5		:= 25a73bfb2a3ad7146c5e9d4408d9f6cd
READLINE		:= readline-$(READLINE_VERSION)
READLINE_SUFFIX		:= tar.gz
READLINE_URL		:= $(call ptx/mirror, GNU, readline/$(READLINE).$(READLINE_SUFFIX))
READLINE_SOURCE		:= $(SRCDIR)/$(READLINE).$(READLINE_SUFFIX)
READLINE_DIR		:= $(BUILDDIR)/$(READLINE)
READLINE_BUILD_OOT	:= YES
READLINE_LICENSE	:= GPL-3.0-or-later
READLINE_LICENSE_FILES	:= file://COPYING;md5=d32239bcb673463ab874e80d47fae504

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

READLINE_CONF_TOOL	:= autoconf
READLINE_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-multibyte \
	--enable-shared \
	--disable-static\
	--disable-install-examples \
	--enable-bracketed-paste-default \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--$(call ptx/endis, PTXDIST_Y2038)-year2038 \
	--$(call ptx/wwo,PTXCONF_READLINE_NCURSES)-curses \
	--with-shared-termcap-library

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/readline.targetinstall:
	@$(call targetinfo)

	@$(call install_init, readline)
	@$(call install_fixup, readline,PRIORITY,optional)
	@$(call install_fixup, readline,SECTION,base)
	@$(call install_fixup, readline,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, readline,DESCRIPTION,missing)

	@$(call install_lib, readline, 0, 0, 0644, libreadline)
	@$(call install_lib, readline, 0, 0, 0644, libhistory)

ifdef PTXCONF_READLINE_ETC_INPUTRC
	@$(call install_alternative, readline, 0, 0, 0644, /etc/inputrc)
endif
	@$(call install_finish, readline)

	@$(call touch)

# vim: syntax=make
