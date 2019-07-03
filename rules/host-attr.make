# -*-makefile-*-
#
# Copyright (C) 2009 by Carsten Schlote <c.schlote@konzeptpark.de>
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_ATTR) += host-attr

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_ATTR_CONF_ENV := \
	$(HOST_ENV) \
	ac_cv_path_MSGFMT=: \
	ac_cv_path_MSGMERGE=: \
	ac_cv_path_XGETTEXT=: \
	CONFIG_SHELL=bash

# no ':=' here
HOST_ATTR_INSTALL_OPT = \
	DIST_ROOT=$(HOST_ATTR_PKGDIR) \
	install \
	install-lib \
	install-dev

HOST_ATTR_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--libexecdir=/lib \
	--enable-shared

# vim: syntax=make
