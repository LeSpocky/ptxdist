# -*-makefile-*-
#
# Copyright (C) 2017 by Bastian Stender
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IPERF3) += iperf3

#
# Paths and names
#
IPERF3_VERSION	:= 3.19.1
IPERF3_MD5	:= adcfb5a59ce5c325d669fcfc4ea6e7e3
IPERF3		:= iperf-$(IPERF3_VERSION)
IPERF3_SUFFIX	:= tar.gz
IPERF3_URL	:= https://downloads.es.net/pub/iperf/$(IPERF3).$(IPERF3_SUFFIX)
IPERF3_SOURCE	:= $(SRCDIR)/$(IPERF3).$(IPERF3_SUFFIX)
IPERF3_DIR	:= $(BUILDDIR)/$(IPERF3)
IPERF3_LICENSE	:= BSD-3-Clause-LBNL AND MIT AND dtoa AND BSD-3-Clause AND NCSA AND public_domain
IPERF3_LICENSE_FILES := file://LICENSE;md5=b51332d7f45357a9410daa9a14a3655f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
IPERF3_CONF_TOOL := autoconf
IPERF3_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-profiling \
	--without-sctp \
	--with-openssl=$(PTXDIST_SYSROOT_TARGET)/usr

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/iperf3.targetinstall:
	@$(call targetinfo)

	@$(call install_init, iperf3)
	@$(call install_fixup, iperf3,PRIORITY,optional)
	@$(call install_fixup, iperf3,SECTION,base)
	@$(call install_fixup, iperf3,AUTHOR,"Bastian Stender <bst@pengutronix.de>")
	@$(call install_fixup, iperf3,DESCRIPTION,missing)

	@$(call install_copy, iperf3, 0, 0, 0755, -, /usr/bin/iperf3)
	@$(call install_lib, iperf3, 0, 0, 0644, libiperf)

	@$(call install_finish, iperf3)

	@$(call touch)

# vim: syntax=make
