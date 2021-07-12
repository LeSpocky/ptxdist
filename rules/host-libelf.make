# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBELF) += host-libelf

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LIBELF_CONF_TOOL	:= autoconf
HOST_LIBELF_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--enable-deterministic-archives \
	--disable-thread-safety \
	--disable-debugpred \
	--disable-gprof \
	--disable-gcov \
	--disable-sanitize-undefined \
	--disable-valgrind \
	--disable-valgrind-annotations \
	--disable-install-elfh \
	--disable-tests-rpath \
	--enable-textrelcheck \
	--enable-symbol-versioning \
	--disable-nls \
	--disable-rpath \
	--disable-libdebuginfod \
	--disable-debuginfod \
	--with-zlib \
	--without-bzlib \
	--without-lzma \
	--without-zstd \
	--without-biarch

# vim: syntax=make
