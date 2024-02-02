# -*-makefile-*-
#
# Copyright (C) 2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPUS) += opus

#
# Paths and names
#
OPUS_VERSION	:= 1.4
OPUS_MD5	:= 0d89c15268c5c5984f583d7997d2a148
OPUS		:= opus-$(OPUS_VERSION)
OPUS_SUFFIX	:= tar.gz
OPUS_URL	:= http://downloads.xiph.org/releases/opus/$(OPUS).$(OPUS_SUFFIX)
OPUS_SOURCE	:= $(SRCDIR)/$(OPUS).$(OPUS_SUFFIX)
OPUS_DIR	:= $(BUILDDIR)/$(OPUS)
OPUS_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
OPUS_CONF_TOOL	:= autoconf
OPUS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--$(call ptx/disen, PTXCONF_HAS_HARDFLOAT)-fixed-point \
	--disable-fixed-point-debug \
	--enable-float-api \
	--disable-custom-modes \
	--enable-float-approx \
	--enable-asm \
	--enable-rtcd \
	--enable-intrinsics \
	--disable-assertions \
	--enable-hardening \
	--disable-fuzzing \
	--disable-check-asm \
	--disable-doc \
	--disable-extra-programs \
	--enable-rfc8251

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/opus.targetinstall:
	@$(call targetinfo)

	@$(call install_init, opus)
	@$(call install_fixup, opus,PRIORITY,optional)
	@$(call install_fixup, opus,SECTION,base)
	@$(call install_fixup, opus,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, opus,DESCRIPTION,missing)

	@$(call install_lib, opus, 0, 0, 0644, libopus)

	@$(call install_finish, opus)

	@$(call touch)

# vim: syntax=make
