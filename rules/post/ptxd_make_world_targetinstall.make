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

# vim: syntax=make
