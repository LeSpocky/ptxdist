# -*-makefile-*-
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBEVENT) += libevent

#
# Paths and names
#
LIBEVENT_VERSION	:= 2.1.13
LIBEVENT_SHA256		:= f7e9383b8c0baa81b687e5b5eecc01beefaf1b19b64151d95ed61647fe7a315c
LIBEVENT		:= libevent-$(LIBEVENT_VERSION)-stable
LIBEVENT_SUFFIX		:= tar.gz
LIBEVENT_URL		:= https://github.com/libevent/libevent/releases/download/release-$(LIBEVENT_VERSION)-stable/$(LIBEVENT).$(LIBEVENT_SUFFIX)
LIBEVENT_SOURCE		:= $(SRCDIR)/$(LIBEVENT).$(LIBEVENT_SUFFIX)
LIBEVENT_DIR		:= $(BUILDDIR)/$(LIBEVENT)
LIBEVENT_LICENSE	:= BSD-3-Clause AND 0BSD AND MIT
LIBEVENT_LICENSE_FILES	:= file://LICENSE;md5=17f20574c0b154d12236d5fbe964f549

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBEVENT_CONF_TOOL	:= autoconf
LIBEVENT_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-gcc-warnings \
	--enable-gcc-hardening \
	--enable-thread-support \
	--disable-malloc-replacement \
	--$(call ptx/endis, PTXCONF_LIBEVENT_OPENSSL)-openssl \
	--disable-debug-mode \
	--enable-libevent-install \
	--disable-libevent-regress \
	--disable-samples \
	--enable-function-sections \
	--disable-verbose-debug \
	--enable-clock-gettime \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-doxygen-doc \
	--disable-doxygen-dot \
	--disable-doxygen-man \
	--disable-doxygen-rtf \
	--disable-doxygen-xml \
	--disable-doxygen-chm \
	--disable-doxygen-chi \
	--disable-doxygen-html \
	--disable-doxygen-ps \
	--disable-doxygen-pdf \
	--$(call ptx/endis, PTXDIST_Y2038)-year2038


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libevent.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libevent)
	@$(call install_fixup, libevent,PRIORITY,optional)
	@$(call install_fixup, libevent,SECTION,base)
	@$(call install_fixup, libevent,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libevent,DESCRIPTION,missing)

	@$(call install_lib, libevent, 0, 0, 0644, libevent-2.1)
	@$(call install_lib, libevent, 0, 0, 0644, libevent_core-2.1)
	@$(call install_lib, libevent, 0, 0, 0644, libevent_extra-2.1)
	@$(call install_lib, libevent, 0, 0, 0644, libevent_pthreads-2.1)
ifdef PTXCONF_LIBEVENT_OPENSSL
	@$(call install_lib, libevent, 0, 0, 0644, libevent_openssl-2.1)
endif

	@$(call install_finish, libevent)

	@$(call touch)

# vim: syntax=make
