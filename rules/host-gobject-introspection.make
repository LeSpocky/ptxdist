# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GOBJECT_INTROSPECTION) += host-gobject-introspection

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_GOBJECT_INTROSPECTION_CONF_TOOL	:= meson
HOST_GOBJECT_INTROSPECTION_CONF_OPT	:= \
	$(HOST_MESON_OPT) \
	-Dbuild_introspection_data=false \
	-Dcairo=disabled \
	-Ddoctool=disabled \
	-Dgtk_doc=false \
	-Dpython=$(SYSTEMPYTHON3)

# vim: syntax=make
