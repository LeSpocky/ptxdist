# -*-makefile-*-
#
# Copyright (C) 2007 by Sascha Hauer
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#           (C) 2024 by Christian Melki <christian.melki@t2data.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_DTC) += host-dtc

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_DTC_CONF_TOOL := NO

HOST_DTC_MAKE_ENV := \
	$(HOST_ENV)

HOST_DTC_MAKE_OPT := \
	PREFIX=/usr \
	NO_PYTHON=1 \
	NO_VALGRIND=1 \
	NO_YAML=1

HOST_DTC_INSTALL_OPT := \
	$(HOST_DTC_MAKE_OPT) \
	install

# vim: syntax=make
