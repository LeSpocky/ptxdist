# -*-makefile-*-
#
# Copyright (C) 2023 by Ian Abbott <abbotti@mev.co.uk>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PROTOBUF_C) += protobuf-c

#
# Paths and names
#
PROTOBUF_C_VERSION	:= 1.5.2
PROTOBUF_C_MD5		:= 0612ee47cccaaf4ad1c4f0c8bdc13abf
PROTOBUF_C		:= protobuf-c-$(PROTOBUF_C_VERSION)
PROTOBUF_C_SUFFIX	:= tar.gz
PROTOBUF_C_URL		:= https://github.com/protobuf-c/protobuf-c/releases/download/v$(PROTOBUF_C_VERSION)/protobuf-c-$(PROTOBUF_C_VERSION).$(PROTOBUF_C_SUFFIX)
PROTOBUF_C_SOURCE	:= $(SRCDIR)/$(PROTOBUF_C).$(PROTOBUF_C_SUFFIX)
PROTOBUF_C_DIR		:= $(BUILDDIR)/$(PROTOBUF_C)
PROTOBUF_C_LICENSE	:= BSD-2-Clause
PROTOBUF_C_LICENSE_FILES := file://LICENSE;md5=bd8de4f63e06b1ccc06e9f8dc5b1aa97

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
PROTOBUF_C_CONF_TOOL	:= autoconf
PROTOBUF_C_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-static \
	--disable-protoc \
	--disable-valgrind-tests \
	--disable-code-coverage \
	--$(call ptx/endis, PTXDIST_Y2038)-year2038

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/protobuf-c.targetinstall:
	@$(call targetinfo)

	@$(call install_init, protobuf-c)
	@$(call install_fixup, protobuf-c,PRIORITY,optional)
	@$(call install_fixup, protobuf-c,SECTION,base)
	@$(call install_fixup, protobuf-c,AUTHOR,"Ian Abbott <abbotti@mev.co.uk>")
	@$(call install_fixup, protobuf-c,DESCRIPTION,missing)

	@$(call install_lib, protobuf-c, 0, 0, 0644, libprotobuf-c)

	@$(call install_finish, protobuf-c)

	@$(call touch)

# vim: syntax=make
