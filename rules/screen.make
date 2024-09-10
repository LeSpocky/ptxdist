# -*-makefile-*-
#
# Copyright (C) 2006 by Sascha Hauer
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SCREEN) += screen

#
# Paths and names
#
SCREEN_VERSION		:= 5.0.0
SCREEN_MD5		:= befc115989242ed4bceeff8d8bfeb4e6
SCREEN			:= screen-$(SCREEN_VERSION)
SCREEN_SUFFIX		:= tar.gz
SCREEN_URL		:= $(call ptx/mirror, GNU, screen/$(SCREEN).$(SCREEN_SUFFIX))
SCREEN_SOURCE		:= $(SRCDIR)/$(SCREEN).$(SCREEN_SUFFIX)
SCREEN_DIR		:= $(BUILDDIR)/$(SCREEN)
SCREEN_LICENSE		:= GPL-2.0-or-later
SCREEN_LICENSE_FILES	:= \
	file://COPYING;md5=c678957b0c8e964aa6c70fd77641a71e

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
SCREEN_CONF_TOOL := autoconf
SCREEN_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_GLOBAL_PAM)-pam \
	--enable-utmp \
	--disable-telnet \
	--with-system_screenrc=/etc/screenrc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/screen.targetinstall:
	@$(call targetinfo)

	@$(call install_init, screen)
	@$(call install_fixup, screen,PRIORITY,optional)
	@$(call install_fixup, screen,SECTION,base)
	@$(call install_fixup, screen,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, screen,DESCRIPTION,missing)

	@$(call install_copy, screen, 0, 0, 0755, \
		$(SCREEN_PKGDIR)/usr/bin/screen-$(SCREEN_VERSION), \
		/usr/bin/screen)

ifdef PTXCONF_SCREEN_ETC_SCREENRC
	@$(call install_alternative, screen, 0, 0, 0644, /etc/screenrc, n)
endif

	@$(call install_finish, screen)

	@$(call touch)

# vim: syntax=make
