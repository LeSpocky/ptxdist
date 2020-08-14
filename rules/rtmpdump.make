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
PACKAGES-$(PTXCONF_RTMPDUMP) += rtmpdump

#
# Paths and names
#
# No tags: use a fake descriptive commit-ish to include the date
RTMPDUMP_VERSION	:= 2019-03-30-0-gc5f04a58fc2a
RTMPDUMP_MD5		:= d782da2c8b6e7d5eb4f7688b35c2ee89
RTMPDUMP		:= rtmpdump-$(RTMPDUMP_VERSION)
RTMPDUMP_SUFFIX		:= tar.xz
RTMPDUMP_URL		:= git://git.ffmpeg.org/rtmpdump.git;tag=$(RTMPDUMP_VERSION)
RTMPDUMP_SOURCE		:= $(SRCDIR)/$(RTMPDUMP).$(RTMPDUMP_SUFFIX)
RTMPDUMP_DIR		:= $(BUILDDIR)/$(RTMPDUMP)
RTMPDUMP_LICENSE	:= LGPL-2.1-or-later AND GPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

RTMPDUMP_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

RTMPDUMP_MAKE_ENV	:= \
	$(CROSS_ENV) \
	CROSS_COMPILE=$(COMPILER_PREFIX) \
	XDEF="$(CROSS_CPPFLAGS)" \
	XCFLAGS="$(CROSS_CFLAGS)" \
	XLDFLAGS="$(CROSS_LDFLAGS)"

RTMPDUMP_MAKE_OPT	:= \
	CRYPTO=GNUTLS \
	prefix=/usr

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

RTMPDUMP_INSTALL_OPT	:= \
	$(RTMPDUMP_MAKE_OPT) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rtmpdump.targetinstall:
	@$(call targetinfo)

	@$(call install_init, rtmpdump)
	@$(call install_fixup, rtmpdump,PRIORITY,optional)
	@$(call install_fixup, rtmpdump,SECTION,base)
	@$(call install_fixup, rtmpdump,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, rtmpdump,DESCRIPTION,missing)

	@$(call install_lib, rtmpdump, 0, 0, 0644, librtmp)
	@$(call install_copy, rtmpdump, 0, 0, 0755, -, /usr/bin/rtmpdump)

	@$(call install_finish, rtmpdump)

	@$(call touch)

# vim: syntax=make
