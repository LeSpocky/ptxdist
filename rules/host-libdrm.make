# -*-makefile-*-
#
# Copyright (C) 2025 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBDRM) += host-libdrm

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBDRM_CONF_TOOL := meson
HOST_LIBDRM_CONF_OPT := \
	$(HOST_MESON_OPT) \
	$(patsubst %,-D%=disabled,$(LIBDRM_BACKENDSC-y)) \
	$(patsubst %,-D%=disabled,$(LIBDRM_BACKENDSC-)) \
	-Dcairo-tests=disabled \
	-Dfreedreno-kgsl=false \
	-Dman-pages=disabled \
	-Dvalgrind=disabled \
	-Dinstall-test-programs=false \
	-Dtests=false \
	-Dudev=false

# vim: syntax=make
