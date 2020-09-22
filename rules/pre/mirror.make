# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptx/mirror = $(foreach mirror,$(PTXCONF_SETUP_$(strip $(1))MIRROR),$(mirror)/$(strip $(2)))

ptx/mirror-pypi = $(foreach mirror, $(call ptx/mirror,PYPI,$(shell echo $(1) | head -c1)/$(strip $(1))/$(strip $(2))),$(mirror))

# vim: syntax=make
