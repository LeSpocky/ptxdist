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
RTMPDUMP_VERSION	:= 2021-02-19-gf1b83c10d8be
RTMPDUMP_MD5		:= 33390d59c4eac5ae34ac155804d44fb6 b0f9380fc56d42e5a12094c467188de9
RTMPDUMP		:= rtmpdump-$(RTMPDUMP_VERSION)
RTMPDUMP_SUFFIX		:= tar.gz
RTMPDUMP_URL		:= git+https://git.ffmpeg.org/rtmpdump.git;tag=$(RTMPDUMP_VERSION)
RTMPDUMP_SOURCE		:= $(SRCDIR)/$(RTMPDUMP).$(RTMPDUMP_SUFFIX)
RTMPDUMP_DIR		:= $(BUILDDIR)/$(RTMPDUMP)
RTMPDUMP_LICENSE	:= LGPL-2.1-or-later AND GPL-2.0-or-later
RTMPDUMP_LICENSE_FILES	:= \
	file://librtmp/rtmp.c;startline=1;endline=24;md5=96a5f261b5569d2c1daf56477675485a \
	file://librtmp/COPYING;md5=e344c8fa836c3a41c4cbd79d7bd3a379 \
	file://rtmpdump.c;startline=1;endline=21;md5=f5d34dc0445bc1d3984f7efcfeaab1cf \
	file://COPYING;md5=751419260aa954499f7abaabaa882bbe

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
