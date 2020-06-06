# -*-makefile-*-
#
# Copyright (C) 2020 by Marian Cichy <m.cichy@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GENGETOPT) += host-gengetopt

#
# Paths and names
#
HOST_GENGETOPT_VERSION	:= 2.23
HOST_GENGETOPT_MD5	:= ea165d618640dbdecb42ae4491337965
HOST_GENGETOPT		:= gengetopt-$(HOST_GENGETOPT_VERSION)
HOST_GENGETOPT_SUFFIX	:= tar.xz
HOST_GENGETOPT_URL	:= https://ftp.gnu.org/gnu/gengetopt/$(HOST_GENGETOPT).$(HOST_GENGETOPT_SUFFIX)
HOST_GENGETOPT_SOURCE	:= $(SRCDIR)/$(HOST_GENGETOPT).$(HOST_GENGETOPT_SUFFIX)
HOST_GENGETOPT_DIR	:= $(HOST_BUILDDIR)/$(HOST_GENGETOPT)
HOST_GENGETOPT_LICENSE	:= GPL-3.0-only
HOST_GENGETOPT_LICENSE_FILES := file://COPYING;md5=ff95bfe019feaf92f524b73dd79e76eb

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_GENGETOPT_CONF_TOOL	:= autoconf
HOST_GENGETOPT_CONF_OPT		:= \
	$(HOST_AUTOCONF) \
	--with-gengen=false \
	--with-gengetopt=false

# vim: syntax=make
