# -*-makefile-*-
#
# Copyright (C) 2007 by Luotao Fu <lfu@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GLIB) += host-glib

#
# Paths and names
#
HOST_GLIB_DIR	= $(HOST_BUILDDIR)/$(GLIB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
HOST_GLIB_CONF_TOOL	:= meson
HOST_GLIB_CONF_OPT	:= \
	$(HOST_MESON_OPT) \
	-Dbsymbolic_functions=true \
	-Ddocumentation=false \
	-Ddtrace=false \
	-Dforce_posix_threads=true \
	-Dglib_assert=true \
	-Dglib_checks=true \
	-Dglib_debug=enabled \
	-Dgtk_doc=false \
	-Dinstalled_tests=false \
	-Dintrospection=disabled \
	-Dlibelf=disabled \
	-Dlibmount=disabled \
	-Dman-pages=disabled \
	-Dmultiarch=false \
	-Dnls=disabled \
	-Doss_fuzz=disabled \
	-Dselinux=disabled \
	-Dsysprof=disabled \
	-Dsystemtap=false \
	-Dtests=false \
	-Dxattr=false

$(STATEDIR)/host-glib.install.post:
	@$(call targetinfo)
	@mkdir -p $(HOST_GLIB_PKGDIR)/usr/share/glib-2.0/gettext
	@$(call world/install.post, HOST_GLIB)
	@sed -i "s:'/usr/share':'$(PTXDIST_SYSROOT_HOST)/usr/share':" "$(PTXDIST_SYSROOT_HOST)/usr/bin/gdbus-codegen"
	@sed -i -e 's:^prefix=.*:prefix=$(PTXDIST_SYSROOT_HOST)/usr:' \
		-e 's:^\(datarootdir\|datadir\)=.*:\1=$(PTXDIST_SYSROOT_HOST)/usr/share:' \
		$(PTXDIST_SYSROOT_HOST)/usr/bin/glib-gettextize
	@$(call touch)

# vim: syntax=make
