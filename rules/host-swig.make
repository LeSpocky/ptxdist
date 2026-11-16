# -*-makefile-*-
#
# Copyright (C) 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SWIG) += host-swig

#
# Paths and names
#
HOST_SWIG_VERSION	:= 4.5.1
HOST_SWIG_SHA256	:= 7fec50b27deddab5455a9633780b6341eddfb96215a7619e93a76eb27178f653
HOST_SWIG		:= swig-$(HOST_SWIG_VERSION)
HOST_SWIG_SUFFIX	:= tar.gz
HOST_SWIG_URL		:= $(call ptx/mirror, SF, swig/swig/$(HOST_SWIG)/$(HOST_SWIG).$(HOST_SWIG_SUFFIX))
HOST_SWIG_SOURCE	:= $(SRCDIR)/$(HOST_SWIG).$(HOST_SWIG_SUFFIX)
HOST_SWIG_DIR		:= $(HOST_BUILDDIR)/$(HOST_SWIG)
HOST_SWIG_LICENSE	:= GPL-3.0-or-later AND BSD-3-Clause AND custom
HOST_SWIG_LICENSE_FILES	:= \
	file://LICENSE;md5=e7807a6282784a7dde4c846626b08fc6 \
	file://LICENSE-GPL;md5=d32239bcb673463ab874e80d47fae504 \
	file://LICENSE-UNIVERSITIES;md5=8ce9dcc8f7c994de4a408b205c72ba08
HOST_SWIG_CVE_PRODUCT	:= swig_project:swig

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SWIG_CONF_TOOL	:= autoconf
HOST_SWIG_DEVPKG	:= NO
HOST_SWIG_CONF_OPT	:= \
	$(HOST_AUTOCONF_SYSROOT) \
	--disable-ccache \
	--disable-cpp11-testing \
	--without-maximum-compile-warnings \
	--with-pcre \
	--with-pcre2-prefix=$(PTXDIST_SYSROOT_HOST)/usr \
	--without-clang-format \
	--without-boost \
	--without-alllang

# vim: syntax=make
