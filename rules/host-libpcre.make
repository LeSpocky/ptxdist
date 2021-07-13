# -*-makefile-*-
#
# Copyright (C) 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBPCRE) += host-libpcre

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
# Note: the --enable-newline-* options are broken. Only one should be used
HOST_LIBPCRE_CONF_TOOL := autoconf
HOST_LIBPCRE_CONF_OPT :=\
	 $(HOST_AUTOCONF) \
	--enable-pcre8 \
	--enable-pcre16 \
	--enable-pcre32 \
	--disable-cpp \
	--disable-jit \
	--enable-pcregrep-jit \
	--disable-rebuild-chartables \
	--enable-utf \
	--enable-unicode-properties \
	--enable-newline-is-lf \
	--disable-bsr-anycrlf \
	--disable-ebcdic \
	--disable-ebcdic-nl25 \
	--enable-stack-for-recursion \
	--disable-pcregrep-libz \
	--disable-pcregrep-libbz2 \
	--disable-pcretest-libedit \
	--disable-pcretest-libreadline \
	--disable-valgrind \
	--disable-coverage \
	--with-pcregrep-bufsize=20480 \
	--with-posix-malloc-threshold=10 \
	--with-link-size=2 \
	--with-parens-nest-limit=250 \
	--with-match-limit=10000000 \
	--with-match-limit-recursion=10000000

# vim: syntax=make
