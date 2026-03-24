# -*-makefile-*-
#
# Copyright (C) 2026 by Lars Pedersen <lapeddk@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_GRPCIO) += python3-grpcio

#
# Paths and names
#
PYTHON3_GRPCIO_VERSION		:= 1.78.0
PYTHON3_GRPCIO_MD5		:= 51c345912f45715610f9c93cbf5ab82b
PYTHON3_GRPCIO			:= grpcio-$(PYTHON3_GRPCIO_VERSION)
PYTHON3_GRPCIO_SUFFIX		:= tar.gz
PYTHON3_GRPCIO_URL		:= $(call ptx/mirror-pypi, grpcio, $(PYTHON3_GRPCIO).$(PYTHON3_GRPCIO_SUFFIX))
PYTHON3_GRPCIO_SOURCE		:= $(SRCDIR)/$(PYTHON3_GRPCIO).$(PYTHON3_GRPCIO_SUFFIX)
PYTHON3_GRPCIO_DIR		:= $(BUILDDIR)/$(PYTHON3_GRPCIO)
PYTHON3_GRPCIO_LICENSE		:= BSD-3-Clause AND Apache-2.0 AND MPL-2.0
PYTHON3_GRPCIO_LICENSE_FILES	:= \
	file://LICENSE;md5=731e401b36f8077ae0c134b59be5c906

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_GRPCIO_CONF_TOOL	:= python3
PYTHON3_GRPCIO_CONF_ENV		= $(CROSS_ENV) \
	GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=True \
	GRPC_PYTHON_BUILD_SYSTEM_ZLIB=True \
	GRPC_PYTHON_BUILD_SYSTEM_CARES=True \
	GRPC_PYTHON_BUILD_SYSTEM_RE2=True \
	GRPC_PYTHON_BUILD_SYSTEM_ABSL=True \
	GRPC_PYTHON_BUILD_WITH_STATIC_LIBSTDCXX=False \
	GRPC_PYTHON_USE_PREBUILT_GRPC_CORE=False \
	GRPC_PYTHON_ENABLE_CYTHON_TRACING=False \
	GRPC_PYTHON_ENABLE_DOCUMENTATION_BUILD=False

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-grpcio.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-grpcio)
	@$(call install_fixup, python3-grpcio,PRIORITY,optional)
	@$(call install_fixup, python3-grpcio,SECTION,base)
	@$(call install_fixup, python3-grpcio,AUTHOR,"Lars Pedersen <lapeddk@gmail.com>")
	@$(call install_fixup, python3-grpcio,DESCRIPTION,missing)

	@$(call install_glob, python3-grpcio, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-grpcio)

	@$(call touch)

# vim: ft=make
