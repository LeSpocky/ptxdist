# -*-makefile-*-
#
# Copyright (C) 2019 by Bjoern Esser <bes@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_UA_NODESET) += host-ua-nodeset

#
# Paths and names
#
HOST_UA_NODESET_VERSION	:= 1.04.4-2020-01-08
HOST_UA_NODESET_MD5	:= ce7b39c7f2d65617f76e0301f654a9ea
HOST_UA_NODESET		:= ua-nodeset-$(HOST_UA_NODESET_VERSION)
HOST_UA_NODESET_SUFFIX	:= tar.gz
HOST_UA_NODESET_URL	:= https://github.com/OPCFoundation/UA-Nodeset/archive/UA-$(HOST_UA_NODESET_VERSION)/$(HOST_UA_NODESET).$(HOST_UA_NODESET_SUFFIX)
HOST_UA_NODESET_SOURCE	:= $(SRCDIR)/$(HOST_UA_NODESET).$(HOST_UA_NODESET_SUFFIX)
HOST_UA_NODESET_DIR	:= $(HOST_BUILDDIR)/$(HOST_UA_NODESET)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-ua-nodeset.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-ua-nodeset.install:
	@$(call targetinfo)

	@$(call world/execute, HOST_UA_NODESET, \
		mkdir -vp $(HOST_UA_NODESET_PKGDIR)/usr/share/ua-nodeset)
	@$(call execute, HOST_UA_NODESET, \
		cp -va $(HOST_BUILDDIR)/$(HOST_UA_NODESET)/* \
			$(HOST_UA_NODESET_PKGDIR)/usr/share/ua-nodeset)

	@$(call touch)
