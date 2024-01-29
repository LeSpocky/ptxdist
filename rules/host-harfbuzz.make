# -*-makefile-*-
#
# Copyright (C) 2020 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_HARFBUZZ) += host-harfbuzz

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_HARFBUZZ_CONF_TOOL	:= meson
HOST_HARFBUZZ_CONF_OPT	:=  \
	 $(HOST_MESON_OPT) \
	-Dbenchmark=disabled \
	-Dcairo=disabled \
	-Dchafa=disabled \
	-Dcoretext=disabled \
	-Ddirectwrite=disabled \
	-Ddoc_tests=false \
	-Ddocs=disabled \
	-Dexperimental_api=false \
	-Dfreetype=enabled \
	-Dfuzzer_ldflags="" \
	-Dgdi=disabled \
	-Dglib=enabled \
	-Dgobject=disabled \
	-Dgraphite=disabled \
	-Dgraphite2=$(call ptx/endis, PTXCONF_HOST_HARFBUZZ_GRAPHITE)d \
	-Dicu=$(call ptx/endis, PTXCONF_HOST_HARFBUZZ_ICU)d \
	-Dicu_builtin=false \
	-Dintrospection=disabled \
	-Dragel_subproject=false \
	-Dtests=disabled \
	-Dutilities=disabled \
	-Dwasm=disabled

# vim: syntax=make
