# -*-makefile-*-
#
# Copyright (C) 2021 by Christian Melki <christian.melki@t2data.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XXHASH) += xxhash

#
# Paths and names
#
XXHASH_VERSION	:= 0.8.1
XXHASH_MD5	:= b67c587f5ff4894253da0095ba7ea393
XXHASH		:= xxhash-$(XXHASH_VERSION)
XXHASH_SUFFIX	:= tar.gz
XXHASH_URL	:= https://github.com/Cyan4973/xxHash/archive/refs/tags/v$(XXHASH_VERSION).$(XXHASH_SUFFIX)
XXHASH_SOURCE	:= $(SRCDIR)/$(XXHASH).$(XXHASH_SUFFIX)
XXHASH_DIR	:= $(BUILDDIR)/$(XXHASH)
XXHASH_LICENSE	:= BSD-2-Clause
XXHASH_LICENSE_FILES := \
	file://LICENSE;md5=cdfe7764d5685d8e08b3df302885d7f3

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

XXHASH_CONF_TOOL	:= NO

XXHASH_MAKE_ENV		:= \
	$(CROSS_ENV) \
	prefix=/usr

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xxhash.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xxhash)
	@$(call install_fixup, xxhash,PRIORITY,optional)
	@$(call install_fixup, xxhash,SECTION,base)
	@$(call install_fixup, xxhash,AUTHOR,"Christian Melki <christian.melki@t2data.com>")
	@$(call install_fixup, xxhash,DESCRIPTION,missing)

	@$(call install_lib, xxhash, 0, 0, 0644, libxxhash)

	@$(call install_finish, xxhash)
	@$(call touch)

# vim: syntax=make
