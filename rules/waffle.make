# -*-makefile-*-
#
# Copyright (C) 2016 by Lucas Stach <l.stach@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WAFFLE) += waffle

#
# Paths and names
#
WAFFLE_VERSION	:= 1.8.1
WAFFLE_MD5	:= 96de2ce2ad25ec0b53a26f4e5665c391
WAFFLE		:= waffle-$(WAFFLE_VERSION)
WAFFLE_SUFFIX	:= tar.xz
WAFFLE_URL	:= https://mesa.pages.freedesktop.org/waffle/files/release/$(WAFFLE)/$(WAFFLE).$(WAFFLE_SUFFIX)
WAFFLE_SOURCE	:= $(SRCDIR)/$(WAFFLE).$(WAFFLE_SUFFIX)
WAFFLE_DIR	:= $(BUILDDIR)/$(WAFFLE)
WAFFLE_LICENSE	:= BSD-2-Clause
WAFFLE_LICENSE_FILES := \
	file://LICENSE.txt;md5=4c5154407c2490750dd461c50ad94797

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

WAFFLE_CONF_TOOL	:= meson
WAFFLE_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dbuild-examples=false \
	-Dbuild-htmldocs=false \
	-Dbuild-manpages=false \
	-Dbuild-tests=false \
	-Dgbm=$(call ptx/endis,PTXCONF_WAFFLE_GBM)d \
	-Dglx=$(call ptx/endis,PTXCONF_WAFFLE_GLX)d \
	-Dnacl=false \
	-Dsurfaceless_egl=disabled \
	-Dwayland=$(call ptx/endis,PTXCONF_WAFFLE_WAYLAND)d \
	-Dx11_egl=$(call ptx/endis,PTXCONF_WAFFLE_X11_EGL)d

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/waffle.targetinstall:
	@$(call targetinfo)

	@$(call install_init, waffle)
	@$(call install_fixup, waffle,PRIORITY,optional)
	@$(call install_fixup, waffle,SECTION,base)
	@$(call install_fixup, waffle,AUTHOR,"Lucas Stach <l.stach@pengutronix.de>")
	@$(call install_fixup, waffle,DESCRIPTION,missing)

	@$(call install_lib, waffle, 0, 0, 0644, libwaffle-1)
	@$(call install_copy, waffle, 0, 0, 0755, -, /usr/bin/wflinfo)

	@$(call install_finish, waffle)

	@$(call touch)

# vim: syntax=make
