# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSHOUT) += libshout

#
# Paths and names
#
LIBSHOUT_VERSION	:= 2.4.6
LIBSHOUT_MD5		:= 4a66a369a01ce790e578221fa2c8ea60
LIBSHOUT		:= libshout-$(LIBSHOUT_VERSION)
LIBSHOUT_SUFFIX		:= tar.gz
LIBSHOUT_URL		:= http://downloads.xiph.org/releases/libshout/$(LIBSHOUT).$(LIBSHOUT_SUFFIX)
LIBSHOUT_SOURCE		:= $(SRCDIR)/$(LIBSHOUT).$(LIBSHOUT_SUFFIX)
LIBSHOUT_DIR		:= $(BUILDDIR)/$(LIBSHOUT)
LIBSHOUT_LICENSE	:= LGPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBSHOUT_CONF_TOOL	:= autoconf
LIBSHOUT_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-examples \
	--disable-tools \
	--enable-thread \
	--enable-vorbis \
	--$(call ptx/endis, PTXCONF_LIBSHOUT_THEORA)-theora \
	--$(call ptx/endis, PTXCONF_LIBSHOUT_SPEEX)-speex

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libshout.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libshout)
	@$(call install_fixup, libshout,PRIORITY,optional)
	@$(call install_fixup, libshout,VERSION,$(LIBSHOUT_VERSION))
	@$(call install_fixup, libshout,SECTION,base)
	@$(call install_fixup, libshout,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libshout,DEPENDS,)
	@$(call install_fixup, libshout,DESCRIPTION,missing)

	@$(call install_lib, libshout, 0, 0, 0755, libshout)

	@$(call install_finish, libshout)

	@$(call touch)

# vim: syntax=make
