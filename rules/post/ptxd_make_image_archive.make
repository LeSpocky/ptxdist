# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

image/archive = \
	$(call world/image/env, $(1)) \
	ptxd_make_image_archive

# vim: syntax=make
