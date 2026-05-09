# -*-makefile-*-
#
# Copyright (C) 2023 by Artur Wiebe <artur@4wiebe.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_POSIX_IPC) += python3-posix_ipc

#
# Paths and names
#
PYTHON3_POSIX_IPC_VERSION	:= 1.1.1
PYTHON3_POSIX_IPC_SHA256	:= e2456ba0cfb2ee5ba14121450e8d825b3c4a1461fca0761220aab66d4111cbb7
PYTHON3_POSIX_IPC		:= posix_ipc-$(PYTHON3_POSIX_IPC_VERSION)
PYTHON3_POSIX_IPC_SUFFIX	:= tar.gz
PYTHON3_POSIX_IPC_URL		:= $(call ptx/mirror-pypi, posix_ipc, $(PYTHON3_POSIX_IPC).$(PYTHON3_POSIX_IPC_SUFFIX))
PYTHON3_POSIX_IPC_SOURCE	:= $(SRCDIR)/$(PYTHON3_POSIX_IPC).$(PYTHON3_POSIX_IPC_SUFFIX)
PYTHON3_POSIX_IPC_DIR		:= $(BUILDDIR)/$(PYTHON3_POSIX_IPC)
PYTHON3_POSIX_IPC_LICENSE	:= BSD
PYTHON3_POSIX_IPC_LICENSE_FILES	:= file://LICENSE;md5=513d94a7390d4d72f3475e2d45c739b5

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_POSIX_IPC_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-posix_ipc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-posix_ipc)
	@$(call install_fixup, python3-posix_ipc,PRIORITY,optional)
	@$(call install_fixup, python3-posix_ipc,SECTION,base)
	@$(call install_fixup, python3-posix_ipc,AUTHOR,"Artur Wiebe <artur@4wiebe.de>")
	@$(call install_fixup, python3-posix_ipc,DESCRIPTION,missing)

	@$(call install_glob, python3-posix_ipc, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES), *.so,)

	@$(call install_finish, python3-posix_ipc)

	@$(call touch)

# vim: syntax=make
