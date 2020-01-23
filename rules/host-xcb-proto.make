# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_XCB_PROTO) += host-xcb-proto

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XCB_PROTO_CONF_ENV		:= \
	$(HOST_ENV) \
	ac_cv_path_PYTHON=python3

#
# autoconf
#
HOST_XCB_PROTO_CONF_TOOL	:= autoconf
# without this special prefix the xcb-proto.pc is broken
HOST_XCB_PROTO_CONF_OPT		:= \
	--prefix=/.

# vim: syntax=make
