# Copyright (C) 2009 by Markus Rathgeb <rathgeb.markus@googlemail.com>


PACKAGES-$(PTXCONF_SPARSEHASH) += sparsehash

#
# Paths and names
#
SPARSEHASH_NAME		:= sparsehash
SPARSEHASH_VERSION	:= 1.11
SPARSEHASH_SHA256	:= a637687cfc8ebd579e39d69afd5eadf071d932bf0c2913a2c2665446c274ba4c 1934d7b0ae76d24518c1520fc1cc424eb4788f9bd4618a8e9b0f19a9f8489cd4
SPARSEHASH		:= $(SPARSEHASH_NAME)-$(SPARSEHASH_VERSION)
SPARSEHASH_SUFFIX	:= tar.gz
SPARSEHASH_URL		:= https://github.com/sparsehash/sparsehash/archive/$(SPARSEHASH).$(SPARSEHASH_SUFFIX)
SPARSEHASH_SOURCE	:= $(SRCDIR)/$(SPARSEHASH).$(SPARSEHASH_SUFFIX)
SPARSEHASH_DIR		:= $(BUILDDIR)/$(SPARSEHASH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
SPARSEHASH_CONF_TOOL	:= autoconf
SPARSEHASH_CONF_OPT	:= $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sparsehash.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make
