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
HOST_PACKAGES-$(PTXCONF_HOST_LIBKMOD) += host-libkmod

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
HOST_LIBKMOD_CONF_TOOL	:= meson
HOST_LIBKMOD_CONF_OPT	:= \
	$(HOST_MESON_OPT) \
	-Dbuild-tests=false \
	-Ddebug-messages=false \
	-Ddocs=false \
	-Dlogging=false \
	-Dmanpages=false \
	-Dopenssl=disabled \
	-Dtools=true \
	-Dzstd=$(call ptx/endis,PTXCONF_HOST_LIBKMOD_ZSTD)d \
	-Dxz=disabled \
	-Dzlib=$(call ptx/endis,PTXCONF_HOST_LIBKMOD_ZLIB)d

# vim: syntax=make
