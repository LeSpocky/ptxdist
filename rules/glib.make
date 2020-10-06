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
GLIB_VERSION	:= 2.64.4
GLIB_MD5	:= 0a4f67e9a9d729976e2f797e36fc1a57
GLIB		:= glib-$(GLIB_VERSION)
GLIB_SUFFIX	:= tar.xz
GLIB_URL	:= $(call ptx/mirror, GNOME, glib/$(basename $(GLIB_VERSION))/$(GLIB).$(GLIB_SUFFIX))
GLIB_SOURCE	:= $(SRCDIR)/$(GLIB).$(GLIB_SUFFIX)
GLIB_DIR	:= $(BUILDDIR)/$(GLIB)
GLIB_LICENSE	:= LGPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
GLIB_CONF_TOOL	:= meson
GLIB_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dbsymbolic_functions=true \
	-Ddtrace=false \
	-Dfam=false \
	-Dforce_posix_threads=true \
	-Dgtk_doc=false \
	-Diconv=libc \
	-Dinstalled_tests=false \
	-Dinternal_pcre=false \
	-Dlibmount=$(call ptx/endis, PTXCONF_GLIB_LIBMOUNT)d \
	-Dman=false \
	-Dnls=disabled \
	-Dselinux=disabled \
	-Dsystemtap=false \
	-Dxattr=false

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/glib.install.post:
	@$(call targetinfo)
	@sed -i 's;^bindir=.*;bindir=$(PTXDIST_SYSROOT_HOST)/bin;' \
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
