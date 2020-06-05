# -*-makefile-*-
#
# Copyright (C) 2008 by Markus Messmer
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifndef PTXCONF_ARCH_ARM64
PACKAGES-$(PTXCONF_CANFESTIVAL) += canfestival
endif

#
# Paths and names
#
# Taken from https://hg.beremiz.org/CanFestival-3/rev/8bfe0ac00cdb
CANFESTIVAL_VERSION	:= 3+hg20180126.794
CANFESTIVAL_MD5		:= c97bca1c4a81a17b1a75a1f8d068b2b3
CANFESTIVAL		:= canfestival-$(CANFESTIVAL_VERSION)
CANFESTIVAL_SUFFIX	:= tar.gz
CANFESTIVAL_URL		:= https://hg.beremiz.org/CanFestival-3/archive/8bfe0ac00cdb.$(CANFESTIVAL_SUFFIX)
CANFESTIVAL_SOURCE	:= $(SRCDIR)/$(CANFESTIVAL).$(CANFESTIVAL_SUFFIX)
CANFESTIVAL_DIR		:= $(BUILDDIR)/$(CANFESTIVAL)
CANFESTIVAL_LICENSE	:= LGPL-2.1-or-later
CANFESTIVAL_LICENSE_FILES	:= \
	file://LICENCE;md5=085e7fb76fb3fa8ba9e9ed0ce95a43f9 \
	file://COPYING;startline=17;endline=25;md5=2964e968dd34832b27b656f9a0ca2dbf

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
CANFESTIVAL_CONF_TOOL	:= autoconf
CANFESTIVAL_CONF_OPT	:= \
	--ld=$(CROSS_CXX) \
	--prefix=/usr \
	--can=socket \
	--timers=unix \
	--wx=0 \
	$(call ptx/ifdef,PTXCONF_ENDIAN_BIG,--CANOPEN_BIG_ENDIAN=1) \

ifdef PTXCONF_KERNEL_HEADER
CANFESTIVAL_CFLAGS	:= -isystem $(KERNEL_HEADERS_INCLUDE_DIR)
endif

CANFESTIVAL_MAKE_PAR	:= NO
CANFESTIVAL_MAKE_OPT	:= canfestival examples

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/canfestival.install.post:
	@$(call targetinfo)
	@$(call world/install.post, CANFESTIVAL)
	@for file in objdictedit objdictgen; do \
		ln -sf $(PTXDIST_SYSROOT_TARGET)/usr/bin/"$${file}" $(PTXDIST_SYSROOT_HOST)/bin; \
	done

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/canfestival.targetinstall:
	@$(call targetinfo)

	@$(call install_init, canfestival)
	@$(call install_fixup, canfestival,PRIORITY,optional)
	@$(call install_fixup, canfestival,SECTION,base)
	@$(call install_fixup, canfestival,AUTHOR,"Markus Messmer <m.messmer@pengutronix.de>")
	@$(call install_fixup, canfestival,DESCRIPTION,missing)

	@$(call install_copy, canfestival, 0, 0, 0644, -, \
		/usr/lib/libcanfestival_can_socket.so)

	@$(call install_finish, canfestival)

	@$(call touch)

# vim: syntax=make tabstop=8
