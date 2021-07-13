# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBVORBIS) += libvorbis

#
# Paths and names
#
LIBVORBIS_VERSION	:= 1.3.7
LIBVORBIS_MD5		:= 9b8034da6edc1a17d18b9bc4542015c7
LIBVORBIS		:= libvorbis-$(LIBVORBIS_VERSION)
LIBVORBIS_SUFFIX	:= tar.gz
LIBVORBIS_URL		:= http://downloads.xiph.org/releases/vorbis/$(LIBVORBIS).$(LIBVORBIS_SUFFIX)
LIBVORBIS_SOURCE	:= $(SRCDIR)/$(LIBVORBIS).$(LIBVORBIS_SUFFIX)
LIBVORBIS_DIR		:= $(BUILDDIR)/$(LIBVORBIS)
LIBVORBIS_LICENSE	:= BSD-3-Clause
LIBVORBIS_LICENSE_FILES	:= \
	file://COPYING;md5=73d9c8942c60b846c3bad13cc6c2e520

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBVORBIS_CONF_TOOL	:= autoconf
LIBVORBIS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-docs \
	--disable-examples \
	--disable-oggtest

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libvorbis.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libvorbis)
	@$(call install_fixup, libvorbis,PRIORITY,optional)
	@$(call install_fixup, libvorbis,SECTION,base)
	@$(call install_fixup, libvorbis,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libvorbis,DESCRIPTION,missing)

	@$(call install_lib, libvorbis, 0, 0, 0644, libvorbis)
	@$(call install_lib, libvorbis, 0, 0, 0644, libvorbisenc)
	@$(call install_lib, libvorbis, 0, 0, 0644, libvorbisfile)

	@$(call install_finish, libvorbis)

	@$(call touch)

# vim: syntax=make
