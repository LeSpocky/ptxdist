# -*-makefile-*-
#
# Copyright (C) 2019 by Denis Osterland <Denis.Osterland@diehl.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_SCONS) += host-python3-scons

#
# Paths and names
#
HOST_PYTHON3_SCONS_VERSION		:= 4.0.1
HOST_PYTHON3_SCONS_MD5			:= 1567d695c457f791207a224feb2fefef
HOST_PYTHON3_SCONS			:= python-scons-$(HOST_PYTHON3_SCONS_VERSION)
HOST_PYTHON3_SCONS_SUFFIX		:= tar.gz
HOST_PYTHON3_SCONS_URL			:= https://github.com/SCons/scons/archive/$(HOST_PYTHON3_SCONS_VERSION).$(HOST_PYTHON3_SCONS_SUFFIX)
HOST_PYTHON3_SCONS_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_SCONS).$(HOST_PYTHON3_SCONS_SUFFIX)
HOST_PYTHON3_SCONS_DIR			:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_SCONS)
HOST_PYTHON3_SCONS_LICENSE		:= MIT
HOST_PYTHON3_SCONS_LICENSE_FILES	:= file://LICENSE;md5=b94c6e2be9670c62b38f7118c12866d2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_SCONS_CONF_TOOL	:= python3


# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

HOST_PYTHON3_SCONS_INSTALL_OPT	:= \
	$(HOST_PYTHON_INSTALL) \
	--install-lib /lib/scons

$(STATEDIR)/host-python3-scons.install:
	@$(call targetinfo)
	@$(call world/install, HOST_PYTHON3_SCONS)
	@mv $(HOST_PYTHON3_SCONS_PKGDIR)/bin/scons $(HOST_PYTHON3_SCONS_PKGDIR)/bin/scons.orig
	@echo -e '#!/bin/sh\nPYTHONPATH=$$(dirname $$0)/../lib/scons exec $${0}.orig "$${@}"' > \
		$(HOST_PYTHON3_SCONS_PKGDIR)/bin/scons
	@chmod +x $(HOST_PYTHON3_SCONS_PKGDIR)/bin/scons
	@$(call touch)
# vim: syntax=make
