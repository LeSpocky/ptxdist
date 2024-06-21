# -*-makefile-*-
#
# Copyright (C) 2003-2008 by Robert Schwebel <r.schwebel@pengutronix.de>
#                            Pengutronix <info@pengutronix.de>, Germany
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GETTEXT) += gettext

#
# Paths and names
#
GETTEXT_VERSION	:= 0.22.5
GETTEXT_MD5	:= 3ae5580599d84be93e6213930facb2db
GETTEXT		:= gettext-$(GETTEXT_VERSION)
GETTEXT_SUFFIX	:= tar.xz
GETTEXT_URL	:= $(call ptx/mirror, GNU, gettext/$(GETTEXT).$(GETTEXT_SUFFIX))
GETTEXT_SOURCE	:= $(SRCDIR)/$(GETTEXT).$(GETTEXT_SUFFIX)
GETTEXT_DIR	:= $(BUILDDIR)/$(GETTEXT)
GETTEXT_LICENSE	:= GPL-3.0-or-later AND LGPL-2.1-or-later
GETTEXT_LICENSE_FILES := \
	file://COPYING;md5=c678957b0c8e964aa6c70fd77641a71e \
	file://gettext-runtime/intl/COPYING.LIB;md5=a4b192f7208753fc0fc8d88c733e6106 \

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
GETTEXT_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-java \
	--disable-csharp \
	--enable-c++ \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-threads=posix \
	--disable-more-warnings \
	--enable-static \
	--disable-nls \
	--disable-rpath \
	--enable-cross-guesses=conservative \
	--disable-relocatable \
	--enable-libasprintf \
	--$(call ptx/endis, PTXDIST_Y2038)-year2038 \
	--disable-curses \
	--enable-namespacing \
	--disable-openmp \
	--disable-acl \
	--disable-xattr \
	--without-included-gettext \
	--with-included-libunistring \
	--without-included-libxml \
	--with-included-regex \
	--without-emacs \
	--without-lispdir \
	--without-git \
	--without-cvs \
	--without-bzip2 \
	--without-xz

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gettext.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gettext)
	@$(call install_fixup, gettext,PRIORITY,optional)
	@$(call install_fixup, gettext,SECTION,base)
	@$(call install_fixup, gettext,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gettext,DESCRIPTION,missing)

ifdef PTXCONF_GETTEXT_ENVSUBST
	@$(call install_copy, gettext, 0, 0, 0755, -, /usr/bin/envsubst)
endif

ifdef PTXCONF_GETTEXT_TOOLS
	@$(call install_copy, gettext, 0, 0, 0755, -, /usr/bin/xgettext)
	@$(call install_copy, gettext, 0, 0, 0755, -, /usr/bin/gettext)
endif

ifdef PTXCONF_GETTEXT_LIBS
	@$(call install_lib, gettext, 0, 0, 0644, libgettextlib-$(GETTEXT_VERSION))
	@$(call install_lib, gettext, 0, 0, 0644, libasprintf)
	@$(call install_lib, gettext, 0, 0, 0644, libgettextpo)
	@$(call install_lib, gettext, 0, 0, 0644, libgettextsrc-$(GETTEXT_VERSION))
	@$(call install_lib, gettext, 0, 0, 0644, libtextstyle)
endif

	@$(call install_finish, gettext)

	@$(call touch)

# vim: syntax=make
