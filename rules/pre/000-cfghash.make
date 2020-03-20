# -*-makefile-*-
#
# Copyright (C) 2020 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# add an arbitrary string to the <PKG>_CFGHASH source
# If the string changes, then the package will be rebuilt
#
define ptx/cfghash
$(file >>$(PTXDIST_TEMPDIR)/pkghash-$(strip $(1)),$(strip $(2)))
endef

define ptx/cfghash-file
$(file >>$(PTXDIST_TEMPDIR)/pkghash.list,CONFIG: $(strip $(1)) $(strip $(2)))
endef

# vim: syntax=make
