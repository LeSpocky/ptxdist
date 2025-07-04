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
HOST_PACKAGES-$(PTXCONF_HOST_GENIMAGE) += host-genimage

#
# Paths and names
#
HOST_GENIMAGE_VERSION	:= 19
HOST_GENIMAGE_MD5	:= 4fd0557117d5fca3cb40ea944be45abd
HOST_GENIMAGE		:= genimage-$(HOST_GENIMAGE_VERSION)
HOST_GENIMAGE_SUFFIX	:= tar.xz
HOST_GENIMAGE_URL	:= https://www.pengutronix.de/software/genimage/download/$(HOST_GENIMAGE).$(HOST_GENIMAGE_SUFFIX)
HOST_GENIMAGE_SOURCE	:= $(SRCDIR)/$(HOST_GENIMAGE).$(HOST_GENIMAGE_SUFFIX)
HOST_GENIMAGE_DIR	:= $(HOST_BUILDDIR)/$(HOST_GENIMAGE)
HOST_GENIMAGE_LICENSE	:= GPL-2.0-only
HOST_GENIMAGE_LICENSE_FILES := \
	file://COPYING;md5=570a9b3749dd0463a1778803b12a6dce \
	file://genimage.c;startline=2;endline=14;md5=e6631e61d58cfd63d650cf93672ebd6c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_GENIMAGE_CONF_TOOL	:= autoconf
HOST_GENIMAGE_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--enable-largefile

# vim: syntax=make
