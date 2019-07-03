# -*-makefile-*-
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2011 by George McCollister <george.mccollister@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# $1: xpkg label
# $2: PKG, uppercase pkg name
#
xpkg/env/impl = \
	$(call world/env, $(2))							\
	CROSS_STRIP="$(call ptx/escape,$(CROSS_STRIP))"				\
	CROSS_OBJCOPY="$(call ptx/escape,$(CROSS_OBJCOPY))"			\
	CROSS_READELF="$(call ptx/escape,$(CROSS_READELF))"			\
	pkg_xpkg="$(call ptx/escape,$(1))"					\
	pkg_xpkg_version="$(call ptx/escape,$($(2)_XPKG_VERSION))"

#
# $1: xpkg label
#
xpkg/env = \
	$(call xpkg/env/impl, $(strip $(1)),$(PTX_MAP_TO_PACKAGE_$(notdir $(basename $(basename $(@))))))

# vim: syntax=make
