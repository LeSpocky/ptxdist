# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_APIEXTRACTOR) += host-apiextractor

#
# Paths and names
#
HOST_APIEXTRACTOR_VERSION	:= 0.10.10
HOST_APIEXTRACTOR_MD5		:= 7cdf6bdbf161e15b8bc5e98df86f95ee
HOST_APIEXTRACTOR		:= apiextractor-$(HOST_APIEXTRACTOR_VERSION)
HOST_APIEXTRACTOR_SUFFIX	:= tar.bz2
HOST_APIEXTRACTOR_URL		:= https://distfiles.macports.org/apiextractor/$(HOST_APIEXTRACTOR).$(HOST_APIEXTRACTOR_SUFFIX)
HOST_APIEXTRACTOR_SOURCE	:= $(SRCDIR)/$(HOST_APIEXTRACTOR).$(HOST_APIEXTRACTOR_SUFFIX)
HOST_APIEXTRACTOR_DIR		:= $(HOST_BUILDDIR)/$(HOST_APIEXTRACTOR)
HOST_APIEXTRACTOR_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
HOST_APIEXTRACTOR_CONF_TOOL	:= cmake
HOST_APIEXTRACTOR_CONF_OPT	:= \
	$(HOST_CMAKE_OPT) \
	-DBUILD_TESTS:BOOL=OFF \
	-DDISABLE_DOCSTRINGS:BOOL=ON

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-apiextractor.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_APIEXTRACTOR)
	@sed -i -e 's,"/,"$(PTXDIST_SYSROOT_HOST)/,g' \
		'$(PTXDIST_SYSROOT_HOST)/lib/cmake/ApiExtractor-$(HOST_APIEXTRACTOR_VERSION)/ApiExtractorConfig.cmake'
	@$(call touch)

# vim: syntax=make
