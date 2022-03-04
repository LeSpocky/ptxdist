# -*-makefile-*-
#
# Copyright (C) 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

$(STATEDIR)/%.targetinstall:
	@$(call targetinfo)
	@$(call touch)

$(STATEDIR)/%.targetinstall.post:
	@$(call targetinfo)
	@$(call touch)

ptx/image-install = \
	$(call world/env, $(1)) \
	pkg_file="$(strip $(2))" \
	pkg_image="$(strip $(3))" \
	ptxd_make_image_install

ptx/image-install-link = \
	$(call world/env, $(1)) \
	pkg_file="$(strip $(2))" \
	pkg_image="$(strip $(3))" \
	ptxd_make_image_install_link

# vim: syntax=make
