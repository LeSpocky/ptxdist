# -*-makefile-*-
#
# Copyright (C) 2024 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_UNIFDEF) += host-unifdef

#
# Paths and names
#
HOST_UNIFDEF_VERSION		:= 2.12
HOST_UNIFDEF_MD5		:= ae8c0b3b4c43c1f6bc5f32412a820818
HOST_UNIFDEF			:= unifdef-$(HOST_UNIFDEF_VERSION)
HOST_UNIFDEF_SUFFIX		:= tar.xz
HOST_UNIFDEF_URL		:= https://dotat.at/prog/unifdef/$(HOST_UNIFDEF).$(HOST_UNIFDEF_SUFFIX)
HOST_UNIFDEF_SOURCE		:= $(SRCDIR)/$(HOST_UNIFDEF).$(HOST_UNIFDEF_SUFFIX)
HOST_UNIFDEF_DIR		:= $(HOST_BUILDDIR)/$(HOST_UNIFDEF)
HOST_UNIFDEF_LICENSE		:= BSD-2-Clause
HOST_UNIFDEF_LICENSE_FILES	:= \
	file://COPYING;md5=3498caf346f6b77934882101749ada23

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_UNIFDEF_CONF_TOOL	:= NO

HOST_UNIFDEF_MAKE_ENV	:= \
	$(HOST_ENV) \
	HOME=/usr

# vim: syntax=make
