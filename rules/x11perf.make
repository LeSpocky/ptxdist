# -*-makefile-*-
#
# Copyright (C) 2024 by Lucas Stach <l.stach@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_X11PERF) += x11perf

#
# Paths and names
#
X11PERF_VERSION		:= 1.7.0
X11PERF_SHA256		:= 24f80d84b0e96171a998932ff007698fd1776da9975ed42e51d57b9cfca91828
X11PERF			:= x11perf-$(X11PERF_VERSION)
X11PERF_SUFFIX		:= tar.xz
X11PERF_URL		:= https://www.x.org/releases/individual/test/$(X11PERF).$(X11PERF_SUFFIX)
X11PERF_SOURCE		:= $(SRCDIR)/$(X11PERF).$(X11PERF_SUFFIX)
X11PERF_DIR		:= $(BUILDDIR)/$(X11PERF)
X11PERF_LICENSE		:= MIT
X11PERF_LICENSE_FILES	:= file://COPYING;md5=428ca4d67a41fcd4fc3283dce9bbda7e

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------
X11PERF_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/x11perf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, x11perf)
	@$(call install_fixup, x11perf,PRIORITY,optional)
	@$(call install_fixup, x11perf,SECTION,base)
	@$(call install_fixup, x11perf,AUTHOR,"Lucas Stach <l.stach@pengutronix.de>")
	@$(call install_fixup, x11perf,DESCRIPTION,missing)

	@$(call install_copy, x11perf, 0, 0, 0755, -, /usr/bin/x11perf)

	@$(call install_finish, x11perf)

	@$(call touch)
