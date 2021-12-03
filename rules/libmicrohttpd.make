# -*-makefile-*-
#
# Copyright (C) 2008, 2009 by Erwin Rol
# Copyright (C) 2016 by Juergen Borleis
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBMICROHTTPD) += libmicrohttpd

#
# Paths and names
#
LIBMICROHTTPD_VERSION	:= 0.9.66
LIBMICROHTTPD_MD5	:= ce4050e75cc40d68506e2b403e1a76f9
LIBMICROHTTPD		:= libmicrohttpd-$(LIBMICROHTTPD_VERSION)
LIBMICROHTTPD_SUFFIX	:= tar.gz
LIBMICROHTTPD_URL	:= $(call ptx/mirror, GNU, libmicrohttpd/$(LIBMICROHTTPD).$(LIBMICROHTTPD_SUFFIX))
LIBMICROHTTPD_SOURCE	:= $(SRCDIR)/$(LIBMICROHTTPD).$(LIBMICROHTTPD_SUFFIX)
LIBMICROHTTPD_DIR	:= $(BUILDDIR)/$(LIBMICROHTTPD)

LIBMICROHTTPD_LICENSE_FILES := \
	file://README;startline=10;endline=11;md5=c6f1444a4efd67e04f3452dc1e97c24d \
	file://COPYING;md5=57d09285feac8a64efa878e692b14f36
ifdef PTXCONF_LIBMICROHTTPD_HTTPS
LIBMICROHTTPD_LICENSE	:= LGPL-2.1-only
else
LIBMICROHTTPD_LICENSE	:= LGPL-2.1-only OR GPL-2.0-only WITH eCos-exception-2.0
LIBMICROHTTPD_LICENSE_FILES += \
	file://doc/ecos.texi;md5=2f39d254e3e5ed800a68ed0fc265b8a1
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBMICROHTTPD_CONF_TOOL	:= autoconf
LIBMICROHTTPD_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-nls \
	--disable-rpath \
	--disable-thread-names \
	--disable-doc \
	--disable-examples \
	--enable-poll \
	--enable-epoll \
	--enable-itc=eventfd \
	--disable-curl \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-sendfile \
	--$(call ptx/endis, PTXCONF_LIBMICROHTTPD_MESSAGES)-messages \
	--enable-postprocessor \
	--$(call ptx/endis, PTXCONF_LIBMICROHTTPD_HTTPS)-https \
	--enable-bauth \
	--disable-dauth \
	--disable-httpupgrade \
	--disable-coverage \
	--enable-asserts \
	--disable-experimental

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmicrohttpd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmicrohttpd)
	@$(call install_fixup, libmicrohttpd,PRIORITY,optional)
	@$(call install_fixup, libmicrohttpd,SECTION,base)
	@$(call install_fixup, libmicrohttpd,AUTHOR,"Erwin Rol <erwin@erwinrol.com>")
	@$(call install_fixup, libmicrohttpd,DESCRIPTION,"embedded HTTP server functionality")

	@$(call install_lib, libmicrohttpd, 0, 0, 0644, libmicrohttpd)

	@$(call install_finish, libmicrohttpd)

	@$(call touch)

# vim: syntax=make
