# -*-makefile-*-
#
# Copyright (C) 2006 by Juergen Beisert
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#

#
HOST_PACKAGES-$(PTXCONF_HOST_MKELFIMAGE) += host-mkelfimage

#
# Paths and names
#
HOST_MKELFIMAGE_VERSION	:= 2.7
HOST_MKELFIMAGE_MD5	:= e505cb87e9c0cdc44cf03d2c4ea8c74b
HOST_MKELFIMAGE		:= mkelfimage_$(HOST_MKELFIMAGE_VERSION)
HOST_MKELFIMAGE_SUFFIX	:= orig.tar.gz
HOST_MKELFIMAGE_URL	:= http://snapshot.debian.org/archive/debian/20070731T000000Z/pool/main/m/mkelfimage/$(HOST_MKELFIMAGE).$(HOST_MKELFIMAGE_SUFFIX)
HOST_MKELFIMAGE_SOURCE	:= $(SRCDIR)/$(HOST_MKELFIMAGE).$(HOST_MKELFIMAGE_SUFFIX)
HOST_MKELFIMAGE_DIR	:= $(HOST_BUILDDIR)/$(HOST_MKELFIMAGE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_MKELFIMAGE_CONF_TOOL	:= autoconf

# vim: syntax=make
