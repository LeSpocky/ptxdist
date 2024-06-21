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
	--disable-c++ \
	--enable-threads=posix \
	--disable-more-warnings \
	--disable-static \
	--disable-nls \
	--disable-rpath \
	--enable-cross-guesses=conservative \
	--enable-relocatable \
	--disable-libasprintf \
	--disable-curses \
	--enable-namespacing \
	--disable-openmp \
	--disable-acl \
	--disable-xattr \
	--without-included-gettext \
	--with-included-libunistring \
	--with-included-libxml \
	--with-included-regex \
	--without-emacs \
	--without-lispdir \
	--without-git \
	--without-cvs \
	--without-bzip2 \
	--without-xz

# vim: syntax=make
