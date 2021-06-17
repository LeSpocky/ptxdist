# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_ICU) += host-icu

HOST_ICU_SUBDIR	= $(ICU_SUBDIR)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_ICU_CONF_TOOL	:= autoconf
HOST_ICU_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--enable-icu-config \
	--disable-debug \
	--enable-release \
	--disable-strict \
	--enable-shared \
	--disable-static \
	--enable-draft \
	--enable-renaming \
	--disable-tracing \
	--disable-plugins \
	--enable-dyload \
	--disable-rpath \
	--disable-weak-threads \
	--disable-extras \
	--disable-icuio \
	--disable-layoutex \
	--enable-tools \
	--disable-fuzzer \
	--disable-tests \
	--disable-samples

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

# only the build tree is needed for icu
$(STATEDIR)/host-icu.install:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make
