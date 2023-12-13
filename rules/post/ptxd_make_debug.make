# -*-makefile-*-
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

dump-hash-%:
	@cat $(PTXDIST_TEMPDIR)/pkghash-$(PTX_MAP_TO_PACKAGE_$*)

dump-srchash-%:
	@cat $(PTXDIST_TEMPDIR)/pkghash-$(PTX_MAP_TO_PACKAGE_$*)_EXTRACT

# vim: syntax=make
