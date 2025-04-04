# -*-makefile-*-
#
# Copyright (C) 2016 by Florian Scherf <f.scherf@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_MSGPACK) += python3-msgpack

#
# Paths and names
#
PYTHON3_MSGPACK_VERSION	:= 1.1.0
PYTHON3_MSGPACK_MD5	:= e5769d4ab610491ac561c84fde4cf4a7
PYTHON3_MSGPACK		:= msgpack-$(PYTHON3_MSGPACK_VERSION)
PYTHON3_MSGPACK_SUFFIX	:= tar.gz
PYTHON3_MSGPACK_URL	:= $(call ptx/mirror-pypi, msgpack, $(PYTHON3_MSGPACK).$(PYTHON3_MSGPACK_SUFFIX))
PYTHON3_MSGPACK_SOURCE	:= $(SRCDIR)/$(PYTHON3_MSGPACK).$(PYTHON3_MSGPACK_SUFFIX)
PYTHON3_MSGPACK_DIR	:= $(BUILDDIR)/$(PYTHON3_MSGPACK)
PYTHON3_MSGPACK_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_MSGPACK_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-msgpack.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-msgpack)
	@$(call install_fixup, python3-msgpack, PRIORITY, optional)
	@$(call install_fixup, python3-msgpack, SECTION, base)
	@$(call install_fixup, python3-msgpack, AUTHOR, "Florian Scherf <f.scherf@pengutronix.de>")
	@$(call install_fixup, python3-msgpack, DESCRIPTION, It`s like JSON. But fast and small.)

	@$(call install_glob, python3-msgpack, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-msgpack)

	@$(call touch)

# vim: syntax=make
