# -*-makefile-*-
#
# Copyright (C) 2006-2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#                            Pengutronix <info@pengutronix.de>, Germany
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GLIB) += glib

#
# Paths and names
#
GLIB_VERSION	:= 2.78.3
GLIB_MD5	:= d93fb5bf93a14a2aa0578b97c349e5b9
GLIB		:= glib-$(GLIB_VERSION)
GLIB_SUFFIX	:= tar.xz
GLIB_URL	:= $(call ptx/mirror, GNOME, glib/$(basename $(GLIB_VERSION))/$(GLIB).$(GLIB_SUFFIX))
GLIB_SOURCE	:= $(SRCDIR)/$(GLIB).$(GLIB_SUFFIX)
GLIB_DIR	:= $(BUILDDIR)/$(GLIB)
GLIB_LICENSE	:= LGPL-2.1-or-later
GLIB_LICENSE_FILES := \
	file://glib/glib.h;startline=1;endline=18;md5=c97f6829778db537db59d1ce41090b51 \
	file://LICENSES/LGPL-2.1-or-later.txt;md5=41890f71f740302b785c27661123bff5

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GLIB_MESON_CROSS_FILE := $(call ptx/get-alternative, config/meson, glib-cross-file.meson)
#
# meson
#
GLIB_CONF_TOOL	:= meson
GLIB_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dbsymbolic_functions=true \
	-Ddtrace=false \
	-Dforce_posix_threads=true \
	-Dglib_assert=true \
	-Dglib_checks=true \
	-Dglib_debug=enabled \
	-Dgtk_doc=false \
	-Dinstalled_tests=false \
	-Dlibelf=disabled \
	-Dlibmount=$(call ptx/endis, PTXCONF_GLIB_LIBMOUNT)d \
	-Dman=false \
	-Dnls=disabled \
	-Doss_fuzz=disabled \
	-Dselinux=disabled \
	-Dsysprof=disabled \
	-Dsystemtap=false \
	-Dtests=false \
	-Dxattr=false \
	\
	--cross-file $(GLIB_MESON_CROSS_FILE)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/glib.install.post:
	@$(call targetinfo)
	@sed -i 's;^bindir=.*;bindir=$(PTXDIST_SYSROOT_HOST)/usr/bin;' \
		 $(GLIB_PKGDIR)/usr/lib/pkgconfig/gio-2.0.pc
	@sed -i "s;'/usr;'$(SYSROOT)/usr;" \
		$(GLIB_PKGDIR)/usr/share/gdb/auto-load/usr/lib/libglib-2.0.so*-gdb.py \
		$(GLIB_PKGDIR)/usr/share/gdb/auto-load/usr/lib/libgobject-2.0.so*-gdb.py
	@$(call world/install.post, GLIB)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/glib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, glib)
	@$(call install_fixup, glib,PRIORITY,optional)
	@$(call install_fixup, glib,SECTION,base)
	@$(call install_fixup, glib,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, glib,DESCRIPTION,missing)

	@$(call install_copy, glib, 0, 0, 0755, /usr/lib/gio/modules)

	@$(foreach lib, libgio-2.0 libglib-2.0 libgmodule-2.0 libgobject-2.0 libgthread-2.0, \
		$(call install_lib, glib, 0, 0, 0644, $(lib))$(ptx/nl))

ifdef PTXCONF_GLIB_GDBUS
	@$(call install_copy, glib, 0, 0, 0755, -, /usr/bin/gdbus)
endif
	@$(call install_finish, glib)

	@$(call touch)

# vim: syntax=make
