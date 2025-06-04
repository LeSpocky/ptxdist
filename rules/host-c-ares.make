# -*-makefile-*-
#
# Copyright (C) 2018 by Clemens Gruber <clemens.gruber@pqgruber.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_C_ARES) += host-c-ares

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_C_ARES_CONF_TOOL	:= autoconf
HOST_C_ARES_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--enable-warnings \
	--enable-symbol-hiding \
	--disable-tests \
	--enable-cares-threads \
	--disable-code-coverage \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-libgcc \
	--disable-tests-crossbuild \
	--with-random=/dev/urandom

# vim: syntax=make
