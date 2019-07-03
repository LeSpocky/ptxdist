# -*-makefile-*-
#
# Copyright (C) 2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

image/fix_permissions	:= $(STATEDIR)/ptx_image_fix_permissions

#
# only run if make goal is "world", i.e. don't run during images_world
#
ifeq ($(MAKECMDGOALS)-$(PTXCONF_FIX_PERMISSIONS)-$(PTXDIST_QUIET),world-y-)
world: $(image/fix_permissions)
endif

$(image/fix_permissions): $(STATEDIR)/world.targetinstall
	@$(call image/env) \
	ptxd_make_image_fix_permissions

# vim: syntax=make
