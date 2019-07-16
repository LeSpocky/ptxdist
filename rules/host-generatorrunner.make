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
HOST_PACKAGES-$(PTXCONF_HOST_GENERATORRUNNER) += host-generatorrunner

#
# Paths and names
#
HOST_GENERATORRUNNER_VERSION	:= 0.6.16
HOST_GENERATORRUNNER_MD5	:= c7011b8ee08e228779a769b7cfa90f5f
HOST_GENERATORRUNNER		:= generatorrunner-$(HOST_GENERATORRUNNER_VERSION)
HOST_GENERATORRUNNER_SUFFIX	:= tar.bz2
HOST_GENERATORRUNNER_URL	:= https://distfiles.macports.org/generatorrunner/$(HOST_GENERATORRUNNER).$(HOST_GENERATORRUNNER_SUFFIX)
HOST_GENERATORRUNNER_SOURCE	:= $(SRCDIR)/$(HOST_GENERATORRUNNER).$(HOST_GENERATORRUNNER_SUFFIX)
HOST_GENERATORRUNNER_DIR	:= $(HOST_BUILDDIR)/$(HOST_GENERATORRUNNER)
HOST_GENERATORRUNNER_LICENSE	:= unknown
# The plugin dir is compiled into the generator
HOST_GENERATORRUNNER_DEVPKG	:= NO

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
HOST_GENERATORRUNNER_CONF_TOOL	:= cmake
HOST_GENERATORRUNNER_CONF_OPT	:= \
	$(HOST_CMAKE_OPT_SYSROOT) \
	-DBUILD_TESTS:BOOL=OFF \

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-generatorrunner.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_GENERATORRUNNER)
	@sed -i -e 's,\(GENERATORRUNNER_PLUGIN_DIR "\)$(PTXDIST_SYSROOT_HOST),\1,g' \
		'$(PTXDIST_SYSROOT_HOST)/lib/cmake/GeneratorRunner-$(HOST_GENERATORRUNNER_VERSION)/GeneratorRunnerConfig.cmake'
	@$(call touch)

# vim: syntax=make
