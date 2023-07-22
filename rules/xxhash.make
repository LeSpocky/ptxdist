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
XXHASH_VERSION	:= 0.8.2
XXHASH_MD5	:= a7628d7a4fd608a7573c5a3e2c856ea5
XXHASH		:= xxhash-$(XXHASH_VERSION)
XXHASH_SUFFIX	:= tar.gz
XXHASH_URL	:= https://github.com/Cyan4973/xxHash/archive/refs/tags/v$(XXHASH_VERSION).$(XXHASH_SUFFIX)
XXHASH_SOURCE	:= $(SRCDIR)/$(XXHASH).$(XXHASH_SUFFIX)
XXHASH_DIR	:= $(BUILDDIR)/$(XXHASH)
XXHASH_LICENSE	:= BSD-2-Clause
XXHASH_LICENSE_FILES := \
	file://LICENSE;md5=13be6b481ff5616f77dda971191bb29b

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
