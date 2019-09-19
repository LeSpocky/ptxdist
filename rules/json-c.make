# -*-makefile-*-
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_JSON_C) += json-c

#
# Paths and names
#
JSON_C_VERSION		:= 0.13.1-20180305
JSON_C_MD5		:= 20dba7bf773599a0842745a2fe5b7cd3
JSON_C			:= json-c-$(JSON_C_VERSION)
JSON_C_SUFFIX		:= tar.gz
JSON_C_URL		:= https://github.com/json-c/json-c/archive/$(JSON_C).$(JSON_C_SUFFIX)
JSON_C_SOURCE		:= $(SRCDIR)/$(JSON_C).$(JSON_C_SUFFIX)
JSON_C_DIR		:= $(BUILDDIR)/$(JSON_C)
JSON_C_LICENSE		:= MIT
JSON_C_LICENSE_FILES	:= file://COPYING;md5=de54b60fbbc35123ba193fea8ee216f2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
JSON_C_CONF_TOOL	:= autoconf
JSON_C_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-threading \
	--disable-rdrand \
	--disable-static

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/json-c.install:
	@$(call targetinfo)
	@$(call world/install, JSON_C)
	@ln -sv json-c.pc $(JSON_C_PKGDIR)/usr/lib/pkgconfig/json.pc
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/json-c.targetinstall:
	@$(call targetinfo)

	@$(call install_init, json-c)
	@$(call install_fixup, json-c,PRIORITY,optional)
	@$(call install_fixup, json-c,SECTION,base)
	@$(call install_fixup, json-c,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, json-c,DESCRIPTION,missing)

	@$(call install_lib, json-c, 0, 0, 0644, libjson-c)

	@$(call install_finish, json-c)

	@$(call touch)

# vim: ft=make noet
