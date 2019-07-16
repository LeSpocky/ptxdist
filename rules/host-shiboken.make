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
HOST_PACKAGES-$(PTXCONF_HOST_SHIBOKEN) += host-shiboken

#
# Paths and names
#

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
HOST_SHIBOKEN_CONF_TOOL	:= cmake
HOST_SHIBOKEN_CONF_OPT	= \
	$(HOST_CMAKE_OPT) \
	-DBUILD_TESTS:BOOL=OFF \
	-DDISABLE_DOCSTRINGS:BOOL=ON \
	-DPython_PREFERRED_VERSION=python$(PYTHON_MAJORMINOR)


# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-shiboken.install:
	@$(call targetinfo)
	@$(call world/install, HOST_SHIBOKEN)
	@sed -i -e 's,"$(PTXDIST_SYSROOT_HOST),",g' \
		$(HOST_SHIBOKEN_PKGDIR)/lib/cmake/Shiboken-$(SHIBOKEN_VERSION)/ShibokenConfig-python$(PYTHON_MAJORMINOR).cmake
	@$(call touch)

$(STATEDIR)/host-shiboken.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_SHIBOKEN)
	@sed -i -e 's,(/,($(PTXDIST_SYSROOT_HOST)/,g' \
		'$(PTXDIST_SYSROOT_HOST)/lib/cmake/Shiboken-$(SHIBOKEN_VERSION)/ShibokenConfig.cmake'
	@sed -i -e 's,"/,"$(PTXDIST_SYSROOT_HOST)/,g' \
		'$(PTXDIST_SYSROOT_HOST)/lib/cmake/Shiboken-$(SHIBOKEN_VERSION)/ShibokenConfig-python$(PYTHON_MAJORMINOR).cmake'
	@$(call touch)

# vim: syntax=make
