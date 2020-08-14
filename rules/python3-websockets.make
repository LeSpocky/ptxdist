# -*-makefile-*-
#
# Copyright (C) 2017 by David Jander <david@protonic.nl>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_WEBSOCKETS) += python3-websockets

#
# Paths and names
#
PYTHON3_WEBSOCKETS_VERSION	:= 6.0
PYTHON3_WEBSOCKETS_MD5		:= 51f6987effdab7ce35934d7caaf84b6b
PYTHON3_WEBSOCKETS		:= python3-websockets-$(PYTHON3_WEBSOCKETS_VERSION)
PYTHON3_WEBSOCKETS_SUFFIX	:= tar.gz
PYTHON3_WEBSOCKETS_URL		:= https://github.com/aaugustin/websockets/archive/$(PYTHON3_WEBSOCKETS_VERSION).$(PYTHON3_WEBSOCKETS_SUFFIX)
PYTHON3_WEBSOCKETS_SOURCE	:= $(SRCDIR)/$(PYTHON3_WEBSOCKETS).$(PYTHON3_WEBSOCKETS_SUFFIX)
PYTHON3_WEBSOCKETS_DIR		:= $(BUILDDIR)/$(PYTHON3_WEBSOCKETS)
PYTHON3_WEBSOCKETS_LICENSE	:= BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_WEBSOCKETS_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-websockets.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-websockets)
	@$(call install_fixup, python3-websockets, PRIORITY, optional)
	@$(call install_fixup, python3-websockets, SECTION, base)
	@$(call install_fixup, python3-websockets, AUTHOR, "David Jander <david@protonic.nl>")
	@$(call install_fixup, python3-websockets, DESCRIPTION, missing)

	@$(call install_glob, python3-websockets, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES)/websockets,, *.py)

	@$(call install_finish, python3-websockets)

	@$(call touch)

# vim: syntax=make
