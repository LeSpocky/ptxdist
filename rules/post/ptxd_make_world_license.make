# -*-makefile-*-
#
# Copyright (C) 2011-2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

world/license-part = \
	$(call world/env, $(1)) \
	pkg_main_PKG=$(strip $(2)) \
	ptxd_make_world_report_yaml_fragment

#
# world/license
#
world/license = \
	$(foreach part, $($(strip $(1))_PARTS),$(call world/license-part,$(part),$(1))$(ptx/nl)) \
	$(call world/env, $(1)) \
	ptxd_make_world_license

#
# image/license
#
image/license = \
	$(call world/image/env, $(1)) \
	ptxd_make_world_license

$(STATEDIR)/image-%.report:
	@$(call targetinfo)
	@$(call image/license, $(PTX_MAP_TO_PACKAGE_image-$(*)))
	@$(call touch)

$(STATEDIR)/%.report:
	@$(call targetinfo)
	@$(call world/license, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call touch)

#
# world/fast-report
#
world/fast-report = \
	$(call world/env, $(1)) \
	ptxd_make_world_fast_report

#
# image/fast-report
#
image/fast-report = \
	$(call world/image/env, $(1)) \
	ptxd_make_world_fast_report

$(STATEDIR)/image-%.fast-report:
	@$(call targetinfo)
	@$(call image/fast-report, $(PTX_MAP_TO_PACKAGE_image-$(*)))
	@$(call touch)

$(STATEDIR)/%.fast-report:
	@$(call targetinfo)
	@$(call world/fast-report, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call touch)

# create a "release" of all required information including licenses, sources and patches

world/release = \
	$(call world/env, $(1)) \
	ptxd_make_world_release

$(STATEDIR)/%.release:
	@$(call targetinfo)
	@$(call world/release, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call touch)


# vim: syntax=make
