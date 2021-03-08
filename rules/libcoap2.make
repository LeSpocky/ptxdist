# -*-makefile-*-
#
# Copyright (C) 2021 by Alexander Dahl <ada@thorsis.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBCOAP2) += libcoap2

#
# Paths and names
#
LIBCOAP2_VERSION	:= 4.2.1
LIBCOAP2_MD5		:= ddd35fed3b44e20d6d456c9901334dae
LIBCOAP2		:= libcoap2-$(LIBCOAP2_VERSION)
LIBCOAP2_SUFFIX		:= tar.gz
LIBCOAP2_URL		:= https://github.com/obgm/libcoap/archive/v$(LIBCOAP2_VERSION).$(LIBCOAP2_SUFFIX)
LIBCOAP2_SOURCE		:= $(SRCDIR)/$(LIBCOAP2).$(LIBCOAP2_SUFFIX)
LIBCOAP2_DIR		:= $(BUILDDIR)/$(LIBCOAP2)
LIBCOAP2_LICENSE	:= BSD-2-Clause AND BSD-1-Clause
LIBCOAP2_LICENSE_FILES	:= \
	file://COPYING;md5=faed8f005d476edd3f250599a4bb9a75 \
	file://LICENSE;md5=4cba1bd050d08b2154b5c29de3a0e9c2 \
	file://include/coap2/uthash.h;startline=2;endline=21;md5=cd2b3441e2540a602f09fa4f0438d82b \
	file://include/coap2/utlist.h;startline=2;endline=21;md5=b9b2b4f775f0f5b7901f008940efe5cf

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBCOAP2_CONF_TOOL	:= autoconf
LIBCOAP2_CONF_OPT	:=  \
	$(CROSS_AUTOCONF_USR) \
	--disable-assert \
	--disable-documentation \
	--disable-doxygen \
	--disable-manpages \
	--disable-dtls \
	--disable-tests \
	--disable-examples \
	--disable-gcov \
	--disable-small-stack \
	--without-gnutls \
	--without-openssl \
	--without-tinydtls \
	--with-epoll

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libcoap2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libcoap2)
	@$(call install_fixup, libcoap2,PRIORITY,optional)
	@$(call install_fixup, libcoap2,SECTION,base)
	@$(call install_fixup, libcoap2,AUTHOR,"Alexander Dahl <ada@thorsis.com>")
	@$(call install_fixup, libcoap2,DESCRIPTION,missing)

	@$(call install_lib, libcoap2, 0, 0, 0644, libcoap-2)

	@$(call install_finish, libcoap2)

	@$(call touch)

# vim: ft=make noet tw=72 ts=8 sw=8
