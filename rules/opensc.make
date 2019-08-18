# -*-makefile-*-
#
# Copyright (C) 2010 by Juergen Beisert <jbe@pengutronix.de>
#               2015 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPENSC) += opensc

#
# Paths and names
#
OPENSC_VERSION	:= 0.19.0
OPENSC_MD5	:= 40734b2343cf83c62c4c403f8a37475e
OPENSC		:= OpenSC-$(OPENSC_VERSION)
OPENSC_SUFFIX	:= tar.gz
OPENSC_URL	:= https://github.com/OpenSC/OpenSC/releases/download/$(OPENSC_VERSION)/$(OPENSC).$(OPENSC_SUFFIX)
OPENSC_SOURCE	:= $(SRCDIR)/$(OPENSC).$(OPENSC_SUFFIX)
OPENSC_DIR	:= $(BUILDDIR)/$(OPENSC)
OPENSC_LICENSE	:= LGPL-2.1-or-later AND Expat AND ISC
ifdef PTXCONF_OPENSC_TESTSUITE
OPENSC_DEVPKG	:= NO
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
OPENSC_CONF_TOOL := autoconf
OPENSC_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--sysconfdir=/etc/opensc \
	--enable-optimization \
	--disable-strict \
	--disable-pedantic \
	--enable-thread-locking \
	--enable-zlib \
	--$(call ptx/endis,PTXCONF_OPENSC_READLINE)-readline \
	--$(call ptx/endis,PTXCONF_OPENSC_OPENSSL)-openssl \
	--disable-openpace \
	--$(call ptx/endis,PTXCONF_OPENSC_OPENCT)-openct \
	--$(call ptx/endis,PTXCONF_OPENSC_PCSC)-pcsc \
	--disable-cryptotokenkit \
	--disable-ctapi \
	--disable-minidriver \
	--enable-sm \
	--disable-man \
	--disable-doc \
	--disable-dnie-ui \
	--disable-notify \
	--$(call ptx/endis,PTXCONF_OPENSC_TESTSUITE)-tests \
	--disable-static

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

OPENSC_TESTS := \
	base64 \
	lottery \
	p15dump \
	pintest \
	prngtest \
	\
	regression/crypt0001 \
	regression/crypt0002 \
	regression/crypt0003 \
	regression/crypt0004 \
	regression/crypt0005 \
	regression/crypt0006 \
	regression/crypt0007 \
	regression/erase \
	regression/functions \
	regression/init0001 \
	regression/init0002 \
	regression/init0003 \
	regression/init0004 \
	regression/init0005 \
	regression/init0006 \
	regression/init0007 \
	regression/init0008 \
	regression/init0009 \
	regression/init0010 \
	regression/init0011 \
	regression/init0012 \
	regression/pin0001 \
	regression/pin0002 \
	regression/run-all

$(STATEDIR)/opensc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, opensc)
	@$(call install_fixup, opensc,PRIORITY,optional)
	@$(call install_fixup, opensc,SECTION,base)
	@$(call install_fixup, opensc,AUTHOR,"Juergen Beisert <jbe@pengutronix.de>")
	@$(call install_fixup, opensc,DESCRIPTION,missing)

	@$(call install_alternative, opensc, 0, 0, 0644, /etc/opensc/opensc.conf)

	@$(call install_lib, opensc, 0, 0, 0644, libopensc)
	@$(call install_copy, opensc, 0, 0, 0755, /usr/lib/pkcs11)
	@$(call install_lib, opensc, 0, 0, 0644, onepin-opensc-pkcs11)
	@$(call install_link, opensc, ../onepin-opensc-pkcs11.so, /usr/lib/pkcs11/onepin-opensc-pkcs11.so)
	@$(call install_lib, opensc, 0, 0, 0644, opensc-pkcs11)
	@$(call install_link, opensc, ../opensc-pkcs11.so, /usr/lib/pkcs11/opensc-pkcs11.so)
	@$(call install_lib, opensc, 0, 0, 0644, pkcs11-spy)
	@$(call install_link, opensc, ../pkcs11-spy.so, /usr/lib/pkcs11/pkcs11-spy.so)

ifdef PTXCONF_OPENSC_TOOLS
	@$(call install_copy, opensc, 0, 0, 0755, -, /usr/bin/cardos-tool)
	@$(call install_copy, opensc, 0, 0, 0755, -, /usr/bin/eidenv)
	@$(call install_copy, opensc, 0, 0, 0755, -, /usr/bin/iasecc-tool)
	@$(call install_copy, opensc, 0, 0, 0755, -, /usr/bin/openpgp-tool)
	@$(call install_copy, opensc, 0, 0, 0755, -, /usr/bin/opensc-explorer)
	@$(call install_copy, opensc, 0, 0, 0755, -, /usr/bin/opensc-tool)
	@$(call install_copy, opensc, 0, 0, 0755, -, /usr/bin/pkcs11-tool)
	@$(call install_copy, opensc, 0, 0, 0755, -, /usr/bin/pkcs15-crypt)
	@$(call install_copy, opensc, 0, 0, 0755, -, /usr/bin/pkcs15-tool)
endif

ifdef PTXCONF_OPENSC_TESTSUITE
	@$(call install_copy, opensc, 0, 0, 0755, /usr/lib/opensc/tests)
	@$(call install_copy, opensc, 0, 0, 0755, /usr/lib/opensc/tests/regression)
	@$(foreach prog, $(OPENSC_TESTS), \
                $(call install_copy, opensc, 0, 0, 0755, $(OPENSC_DIR)/src/tests/$(prog), \
			/usr/lib/opensc/tests/$(prog));)

	@$(call install_copy, opensc, 0, 0, 0644, $(OPENSC_DIR)/src/tests/regression/bintest, \
		/usr/lib/opensc/tests/regression/bintest)
	@$(call install_copy, opensc, 0, 0, 0644, $(OPENSC_DIR)/src/tests/regression/test.p12, \
		/usr/lib/opensc/tests/regression/test.p12)
endif

	@$(call install_finish, opensc)

	@$(call touch)

# vim: syntax=make
