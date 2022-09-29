# -*-makefile-*-
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# world/install
#
world/install = \
	$(call world/env, $(1)) \
	ptxd_make_world_install

#
# world/install.pack
#
world/install.pack = \
	$(call world/env, $1) \
	ptxd_make_world_install_pack

#
# world/install.unpack
#
world/install.unpack = \
	$(call world/env, $1) \
	ptxd_make_world_install_unpack

#
# world/install.post
#
world/install.post = \
	$(call world/env, $1) \
	ptxd_make_world_install_post

install = ptxd_bailout "install is gone, use world/install instead"

$(STATEDIR)/%.install:
	@$(call targetinfo)
	@$(call world/install, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call touch)

$(STATEDIR)/%.install.pack:
	@$(call targetinfo)
	@$(call world/install.pack, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call touch)

$(STATEDIR)/%.install.unpack:
	@$(call targetinfo)
	@$(call world/install.unpack, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call touch)

$(STATEDIR)/%.install.post:
	@$(call targetinfo)
	@$(call world/install.post, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call touch)

# vim: syntax=make
