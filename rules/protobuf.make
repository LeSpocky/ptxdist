# -*-makefile-*-
#
# Copyright (C) 2012 by Adrian Baumgarth <adrian.baumgarth@l-3com.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PROTOBUF) += protobuf

#
# Paths and names
#
PROTOBUF_VERSION	:= 3.3.2
PROTOBUF_MD5		:= 19ed45d0cbbb88de2c4922978235d314
PROTOBUF		:= protobuf-$(PROTOBUF_VERSION)
PROTOBUF_SUFFIX		:= tar.gz
PROTOBUF_URL		:= https://github.com/google/protobuf/archive/v$(PROTOBUF_VERSION).$(PROTOBUF_SUFFIX)
PROTOBUF_SOURCE		:= $(SRCDIR)/$(PROTOBUF).$(PROTOBUF_SUFFIX)
PROTOBUF_DIR		:= $(BUILDDIR)/$(PROTOBUF)
PROTOBUF_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
PROTOBUF_CONF_TOOL	:= autoconf
PROTOBUF_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--$(call ptx/wwo, PTXCONF_PROTOBUF_ZLIB)-zlib \
	--with-protoc=$(PTXDIST_SYSROOT_HOST)/bin/protoc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/protobuf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, protobuf)
	@$(call install_fixup, protobuf,PRIORITY,optional)
	@$(call install_fixup, protobuf,SECTION,base)
	@$(call install_fixup, protobuf,AUTHOR,"Adrian Baumgarth <adrian.baumgarth@l-3com.com>")
	@$(call install_fixup, protobuf,DESCRIPTION,missing)

	@$(call install_lib, protobuf, 0, 0, 0644, libprotobuf-lite)
	@$(call install_lib, protobuf, 0, 0, 0644, libprotobuf)

	@$(call install_finish, protobuf)

	@$(call touch)

# vim: syntax=make
