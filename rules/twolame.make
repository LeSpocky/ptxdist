# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TWOLAME) += twolame

#
# Paths and names
#
TWOLAME_VERSION	:= 0.4.0
TWOLAME_SHA256	:= cc35424f6019a88c6f52570b63e1baf50f62963a3eac52a03a800bb070d7c87d
TWOLAME		:= twolame-$(TWOLAME_VERSION)
TWOLAME_SUFFIX	:= tar.gz
TWOLAME_URL	:= $(call ptx/mirror, SF, twolame/$(TWOLAME).$(TWOLAME_SUFFIX))
TWOLAME_SOURCE	:= $(SRCDIR)/$(TWOLAME).$(TWOLAME_SUFFIX)
TWOLAME_DIR	:= $(BUILDDIR)/$(TWOLAME)
TWOLAME_LICENSE	:= LGPL-2.1-or-later
TWOLAME_LICENSE_FILES	:= \
	file://COPYING;md5=ade9a053df81f5b9408d2f4f5546df86 \
	file://libtwolame/twolame.c;startline=7;endline=19;md5=2a8e676116ecb4efec3a23e7f05d3934

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
TWOLAME_CONF_TOOL	:= autoconf
TWOLAME_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--disable-sndfile

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/twolame.targetinstall:
	@$(call targetinfo)

	@$(call install_init, twolame)
	@$(call install_fixup, twolame,PRIORITY,optional)
	@$(call install_fixup, twolame,SECTION,base)
	@$(call install_fixup, twolame,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, twolame,DESCRIPTION,missing)

	@$(call install_lib, twolame, 0, 0, 0644, libtwolame)

	@$(call install_finish, twolame)

	@$(call touch)

# vim: syntax=make
