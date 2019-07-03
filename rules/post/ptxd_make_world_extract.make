# -*-makefile-*-
#
# Copyright (C) 2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

world/srchash = \
	+$(call world/env, $1) \
	ptxd_make_world_hash srchash

$(STATEDIR)/%.srchash:
	@$(call targetinfo)
	@$(call world/srchash, $(PTX_MAP_TO_PACKAGE_$(basename $(*))))
	@$(call touch)

#
# extract
#
# Extract a source archive into a directory. This stage is
# skipped if $1_URL points to a local directory instead of
# an archive or online URL.
#
# $1: Packet label; we extract $1_SOURCE
# $2: dir to extract into; if $2 is not given we extract to $(BUILDDIR)
#
extract = \
	$(call world/env, $(1)) \
	pkg_deprecated_extract_dir="$(call ptx/escape, $(strip $(2)))" \
	ptxd_make_world_extract

world/patchin/post = \
	$(call world/env, $(1)) \
	ptxd_make_world_patchin_post

$(STATEDIR)/%.extract:
	@$(call targetinfo)
	@$(call clean, $($(PTX_MAP_TO_PACKAGE_$(*))_DIR))
	@$(call extract, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call patchin, $(PTX_MAP_TO_PACKAGE_$(*)), $($(PTX_MAP_TO_PACKAGE_$(*))_DIR))
	@$(call touch)

$(STATEDIR)/%.extract.post:
	@$(call targetinfo)
	@$(call world/patchin/post, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call touch)

# vim: syntax=make
