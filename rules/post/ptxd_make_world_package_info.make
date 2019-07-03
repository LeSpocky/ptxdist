# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PHONY += ptx-package-info bsp-info
ptx-package-info:

world/package-info = \
	$(call world/env, $(1)) \
	ptxd_make_world_package_info

image/package-info = \
	$(call world/image/env, $(1)) \
	ptxd_make_world_package_info

$(STATEDIR)/image-%.package-info: ptx-package-info
	@$(call targetinfo)
	@$(call image/package-info, $(PTX_MAP_TO_PACKAGE_image-$(*)))
	@$(call finish)

$(STATEDIR)/%.package-info: ptx-package-info
	@$(call targetinfo)
	@$(call world/package-info, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call finish)

ptx/bsp-info = \
	$(ptx/env) \
	bsp_images="$(IMAGE_PACKAGES)" \
	ptxd_make_bsp_info

bsp-info:
	@$(call targetinfo)
	@$(call ptx/bsp-info)
	@$(call finish)

# vim: syntax=make
