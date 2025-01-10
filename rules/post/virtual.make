# -*-makefile-*-
#
# Copyright (C) 2003-2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2011 by George McCollister <george.mccollister@gmail.com>
# For further information about the PTXdist project and license conditions
# see the README file.
#

$(STATEDIR)/virtual-cross-tools.install:
	@$(call targetinfo)
	@$(call touch)


$(STATEDIR)/virtual-host-tools.install:
	@$(call targetinfo)
	@$(call touch)
