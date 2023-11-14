# -*-makefile-*-
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GRAPHITE2) += host-graphite2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
HOST_GRAPHITE2_CONF_TOOL	:= cmake
HOST_GRAPHITE2_CONF_OPT	:=  \
	$(HOST_CMAKE_OPT) \
	-DCMAKE_DISABLE_FIND_PACKAGE_Freetype=ON

# vim: syntax=make
