# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

finish =					\
	$(call _touch_opt_output,$(@))		\
	echo "finished target $(notdir $(@))"

# vim: syntax=make
