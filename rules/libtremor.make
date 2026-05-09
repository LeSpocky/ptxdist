# -*-makefile-*-
#
# Copyright (C) 2013 by Markus Pargmann <mpa@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBTREMOR) += libtremor

LIBTREMOR_VERSION	:= 2018-03-19-g7c30a6634619
LIBTREMOR_SHA256	:= caccf340d02fe662e30ede845a13a7390ba8fc99c01e47bbcf38c9a1bb4b138f
LIBTREMOR		:= libtremor-$(LIBTREMOR_VERSION)
LIBTREMOR_SUFFIX	:= tar.gz
LIBTREMOR_URL		:= https://gitlab.xiph.org/xiph/tremor/-/archive/$(LIBTREMOR).$(LIBTREMOR_SUFFIX)
LIBTREMOR_SOURCE	:= $(SRCDIR)/$(LIBTREMOR).$(LIBTREMOR_SUFFIX)
LIBTREMOR_DIR		:= $(BUILDDIR)/$(LIBTREMOR)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBTREMOR_CONF_TOOL	:= autoconf
LIBTREMOR_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static

ifdef PTXCONF_ARCH_ARM
LIBTREMOR_CFLAGS := -Wa,-mimplicit-it=thumb
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libtremor.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libtremor)
	@$(call install_fixup, libtremor,PRIORITY,optional)
	@$(call install_fixup, libtremor,SECTION,base)
	@$(call install_fixup, libtremor,AUTHOR,"Markus Pargmann <mpa@pengutronix.de>")
	@$(call install_fixup, libtremor,DESCRIPTION,missing)

	@$(call install_lib, libtremor, 0, 0, 0644, libvorbisidec)

	@$(call install_finish, libtremor)

	@$(call touch)

# vim: syntax=make
