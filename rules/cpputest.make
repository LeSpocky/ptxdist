# -*-makefile-*-
#
# Copyright (C) 2023 by Roland Hieber <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CPPUTEST) += cpputest

#
# Paths and names
#
CPPUTEST_VERSION	:= 3.8
CPPUTEST_SHA256		:= c81dccc5a1bfc7fc6511590c0a61def5f78e3fb19cb8e1f889d8d3395a476456
CPPUTEST		:= cpputest-$(CPPUTEST_VERSION)
CPPUTEST_SUFFIX		:= tar.gz
CPPUTEST_URL		:= https://github.com/cpputest/cpputest/releases/download/v$(CPPUTEST_VERSION)/$(CPPUTEST).$(CPPUTEST_SUFFIX)
CPPUTEST_SOURCE		:= $(SRCDIR)/$(CPPUTEST).$(CPPUTEST_SUFFIX)
CPPUTEST_DIR		:= $(BUILDDIR)/$(CPPUTEST)
CPPUTEST_LICENSE	:= BSD-3-Clause
CPPUTEST_LICENSE_FILES	:= file://COPYING;md5=ce5d5f1fe02bcd1343ced64a06fd4177

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
CPPUTEST_CONF_TOOL	:= autoconf
CPPUTEST_CONF_OPT	:=  \
	$(CROSS_AUTOCONF_USR) \
	--enable-std-c \
	--enable-std-cpp \
	--enable-std-cpp11 \
	--enable-cpputest-flags \
	--enable-memory-leak-detection \
	--enable-extensions \
	--enable-longlong \
	--enable-generate-map-file \
	--enable-coverage

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cpputest.targetinstall:
	@$(call targetinfo)
	@# cpputest is a static library only
	@$(call touch)

# vim: syntax=make
