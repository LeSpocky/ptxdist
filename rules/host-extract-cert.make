# -*-makefile-*-
#
# Copyright (C) 2019 by Sascha Hauer <s.hauer@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_EXTRACT_CERT) += host-extract-cert

#
# Paths and names
#
HOST_EXTRACT_CERT_VERSION	:= 0.3
HOST_EXTRACT_CERT_MD5		:= a0fb2a20ef7528edcedd1ebcb1578c92
HOST_EXTRACT_CERT		:= extract-cert-$(HOST_EXTRACT_CERT_VERSION)
HOST_EXTRACT_CERT_SUFFIX	:= tar.gz
HOST_EXTRACT_CERT_URL		:= https://git.pengutronix.de/cgit/extract-cert/snapshot/$(HOST_EXTRACT_CERT).$(HOST_EXTRACT_CERT_SUFFIX)
HOST_EXTRACT_CERT_SOURCE	:= $(SRCDIR)/$(HOST_EXTRACT_CERT).$(HOST_EXTRACT_CERT_SUFFIX)
HOST_EXTRACT_CERT_DIR		:= $(HOST_BUILDDIR)/$(HOST_EXTRACT_CERT)
HOST_EXTRACT_CERT_LICENSE	:= LGPL-2.1-only
HOST_EXTRACT_CERT_LICENSE_FILES	:= file://COPYING;md5=4fbd65380cdd255951079008b364516c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_EXTRACT_CERT_CONF_TOOL	:= meson

# vim: syntax=make
