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
PACKAGES-$(PTXCONF_LIBCACA) += libcaca

#
# Paths and names
#
LIBCACA_VERSION	:= 0.99.beta19
LIBCACA_MD5	:= a3d4441cdef488099f4a92f4c6c1da00
LIBCACA		:= libcaca-$(LIBCACA_VERSION)
LIBCACA_SUFFIX	:= tar.gz
LIBCACA_URL	:= http://caca.zoy.org/files/libcaca/$(LIBCACA).$(LIBCACA_SUFFIX)
LIBCACA_SOURCE	:= $(SRCDIR)/$(LIBCACA).$(LIBCACA_SUFFIX)
LIBCACA_DIR	:= $(BUILDDIR)/$(LIBCACA)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBCACA_CONF_ENV := \
	$(CROSS_ENV) \
	CONFIG_SHELL=bash

#
# autoconf
#
LIBCACA_CONF_TOOL := autoconf
LIBCACA_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-kernel \
	--disable-slang \
	--$(call ptx/endis, PTXCONF_LIBCACA_NCURSES)-ncurses \
	--disable-win32 \
	--disable-conio \
	--$(call ptx/endis, PTXCONF_LIBCACA_X11)-x11 \
	--disable-gl \
	--disable-cocoa \
	--disable-network \
	--disable-vga \
	--disable-csharp \
	--disable-java \
	--$(call ptx/endis, PTXCONF_LIBCACA_CXX)-cxx \
	--disable-python \
	--disable-ruby \
	--disable-imlib2 \
	--disable-debug \
	--disable-profiling \
	--disable-plugins \
	--disable-doc \
	--disable-cppunit \
	--disable-zzuf \
	--$(call ptx/wwo, PTXCONF_LIBCACA_X11)-x

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libcaca.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libcaca)
	@$(call install_fixup, libcaca,PRIORITY,optional)
	@$(call install_fixup, libcaca,SECTION,base)
	@$(call install_fixup, libcaca,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libcaca,DESCRIPTION,missing)

	@$(call install_lib, libcaca, 0, 0, 0644, libcaca)

ifdef PTXCONF_LIBCACA_CXX
	@$(call install_lib, libcaca, 0, 0, 0644, libcaca++)
endif
	@$(call install_finish, libcaca)

	@$(call touch)

# vim: syntax=make
