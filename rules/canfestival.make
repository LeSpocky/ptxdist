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
# There are not tags. Use the commit date instaed
CANFESTIVAL_VERSION	:= 20150803-g7a705265f727
CANFESTIVAL_MD5		:= 3f5e16c45bd9bdbe2513dbd0e670c12a
CANFESTIVAL		:= canfestival-$(CANFESTIVAL_VERSION)
CANFESTIVAL_SUFFIX	:= tar.gz
CANFESTIVAL_URL		:= https://github.com/beremiz/canfestival/archive/canfestival-$(CANFESTIVAL_VERSION).$(CANFESTIVAL_SUFFIX)
CANFESTIVAL_SOURCE	:= $(SRCDIR)/$(CANFESTIVAL).$(CANFESTIVAL_SUFFIX)
CANFESTIVAL_DIR		:= $(BUILDDIR)/$(CANFESTIVAL)
CANFESTIVAL_LICENSE	:= LGPL-2.1-or-later
CANFESTIVAL_LICENSE_FILES	:= \
	file://LICENCE;md5=085e7fb76fb3fa8ba9e9ed0ce95a43f9 \
	file://COPYING;startline=17;endline=25;md5=2964e968dd34832b27b656f9a0ca2dbf

CANFESTIVAL_GNOSIS_SOURCE	:= $(CANFESTIVAL_DIR)/objdictgen/Gnosis_Utils-current.tar.gz
CANFESTIVAL_GNOSIS_DIR		:= $(CANFESTIVAL_DIR)/objdictgen/gnosis
CANFESTIVAL_GNOSIS_STRIP_LEVEL	:= 2
CANFESTIVAL_GNOSIS_SRC_FILTER	:= */gnosis

CANFESTIVAL_PARTS		+= CANFESTIVAL_GNOSIS

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
		ln -sf $(PTXDIST_SYSROOT_TARGET)/usr/bin/"$${file}" $(PTXDIST_SYSROOT_HOST)/usr/bin; \
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
