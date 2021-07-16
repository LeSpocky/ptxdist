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
PACKAGES-$(PTXCONF_LIBSRTP) += libsrtp

#
# Paths and names
#
LIBSRTP_VERSION	:= 2.3.0
LIBSRTP_MD5	:= da38ee5d9c31be212a12964c22d7f795
LIBSRTP		:= libsrtp-$(LIBSRTP_VERSION)
LIBSRTP_SUFFIX	:= tar.gz
LIBSRTP_URL	:= https://github.com/cisco/libsrtp/archive/v$(LIBSRTP_VERSION).$(LIBSRTP_SUFFIX)
LIBSRTP_SOURCE	:= $(SRCDIR)/$(LIBSRTP).$(LIBSRTP_SUFFIX)
LIBSRTP_DIR	:= $(BUILDDIR)/$(LIBSRTP)
LIBSRTP_LICENSE	:= BSD-3-Clause
LIBSRTP_LICENSE_FILES := \
	file://LICENSE;md5=2909fcf6f09ffff8430463d91c08c4e1

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBSRTP_CONF_TOOL	:= autoconf
LIBSRTP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug-logging \
	--enable-openssl \
	--disable-nss \
	--disable-openssl-kdf \
	--disable-pcap \
	--enable-log-stdout

LIBSRTP_MAKE_OPT	:= shared_library

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsrtp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsrtp)
	@$(call install_fixup, libsrtp,PRIORITY,optional)
	@$(call install_fixup, libsrtp,SECTION,base)
	@$(call install_fixup, libsrtp,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libsrtp,DESCRIPTION,missing)

	@$(call install_lib, libsrtp, 0, 0, 0644, libsrtp2)

	@$(call install_finish, libsrtp)

	@$(call touch)

# vim: syntax=make
