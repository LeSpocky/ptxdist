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
WAFFLE_VERSION	:= 1.7.2
WAFFLE_MD5	:= e5e9772fe2c1e6267794f7aba08637c8
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

WAFFLE_CONF_TOOL	:= cmake
WAFFLE_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-G Ninja \
	-DVALGRIND_EXECUTABLE= \
	-Dnacl_sdk_path= \
	-Dnacl_version= \
	-Dwaffle_build_examples=OFF \
	-Dwaffle_build_htmldocs=OFF \
	-Dwaffle_build_manpages=OFF \
	-Dwaffle_build_tests=OFF \
	-Dwaffle_has_gbm=$(call ptx/onoff,PTXCONF_WAFFLE_GBM) \
	-Dwaffle_has_glx=$(call ptx/onoff,PTXCONF_WAFFLE_GLX) \
	-Dwaffle_has_nacl=OFF \
	-Dwaffle_has_surfaceless_egl=OFF \
	-Dwaffle_has_wayland=$(call ptx/onoff,PTXCONF_WAFFLE_WAYLAND) \
	-Dwaffle_has_x11_egl=$(call ptx/onoff,PTXCONF_WAFFLE_X11_EGL) \
	-Dwaffle_xsltproc=

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
