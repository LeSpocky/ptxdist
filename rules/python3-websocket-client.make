# -*-makefile-*-
#
# Copyright (C) 2021 by Matthias Fend <matthias.fend@emfend.at>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_WEBSOCKET_CLIENT) += python3-websocket-client

#
# Paths and names
#
PYTHON3_WEBSOCKET_CLIENT_VERSION	:= 1.2.1
PYTHON3_WEBSOCKET_CLIENT_SHA256		:= 8dfb715d8a992f5712fff8c843adae94e22b22a99b2c5e6b0ec4a1a981cc4e0d
PYTHON3_WEBSOCKET_CLIENT		:= websocket-client-$(PYTHON3_WEBSOCKET_CLIENT_VERSION)
PYTHON3_WEBSOCKET_CLIENT_SUFFIX		:= tar.gz
PYTHON3_WEBSOCKET_CLIENT_URL		:= $(call ptx/mirror-pypi, websocket-client, $(PYTHON3_WEBSOCKET_CLIENT).$(PYTHON3_WEBSOCKET_CLIENT_SUFFIX))
PYTHON3_WEBSOCKET_CLIENT_SOURCE		:= $(SRCDIR)/$(PYTHON3_WEBSOCKET_CLIENT).$(PYTHON3_WEBSOCKET_CLIENT_SUFFIX)
PYTHON3_WEBSOCKET_CLIENT_DIR		:= $(BUILDDIR)/$(PYTHON3_WEBSOCKET_CLIENT)
PYTHON3_WEBSOCKET_CLIENT_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_WEBSOCKET_CLIENT_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-websocket-client.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-websocket-client)
	@$(call install_fixup, python3-websocket-client, PRIORITY, optional)
	@$(call install_fixup, python3-websocket-client, SECTION, base)
	@$(call install_fixup, python3-websocket-client, AUTHOR, "Matthias Fend <matthias.fend@emfend.at>")
	@$(call install_fixup, python3-websocket-client, DESCRIPTION, missing)

	@$(call install_glob, python3-websocket-client, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-websocket-client)

	@$(call touch)

# vim: syntax=make
