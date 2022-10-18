# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GETTEXT) += host-gettext

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_GETTEXT_CONF_TOOL := autoconf
HOST_GETTEXT_CONF_OPT := \
	$(HOST_AUTOCONF) \
	--disable-java \
	--disable-csharp \
	--enable-threads=posix \
	--disable-static \
	--disable-nls \
	--disable-rpath \
	--disable-c++ \
	--enable-cross-guesses=conservative \
	--enable-relocatable \
	--disable-libasprintf \
	--disable-curses \
	--enable-namespacing \
	--disable-openmp \
	--disable-acl \
	--with-included-libunistring \
	--with-included-libxml \
	--with-included-regex \
	--without-emacs \
	--without-git \
	--without-cvs \
	--without-bzip2 \
	--without-xz

# vim: syntax=make
