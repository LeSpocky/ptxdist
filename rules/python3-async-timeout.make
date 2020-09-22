# -*-makefile-*-
#
# Copyright (C) 2017 by Pim Klanke <pim@protonic.nl>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_ASYNC_TIMEOUT) += python3-async-timeout

#
# Paths and names
#
PYTHON3_ASYNC_TIMEOUT_VERSION	:= 3.0.1
PYTHON3_ASYNC_TIMEOUT_MD5	:= 305c4fa529f2485c403d0dbe14390175
PYTHON3_ASYNC_TIMEOUT		:= async-timeout-$(PYTHON3_ASYNC_TIMEOUT_VERSION)
PYTHON3_ASYNC_TIMEOUT_SUFFIX	:= tar.gz
PYTHON3_ASYNC_TIMEOUT_URL	:= $(call ptx/mirror-pypi, async-timeout, $(PYTHON3_ASYNC_TIMEOUT).$(PYTHON3_ASYNC_TIMEOUT_SUFFIX))
PYTHON3_ASYNC_TIMEOUT_SOURCE	:= $(SRCDIR)/$(PYTHON3_ASYNC_TIMEOUT).$(PYTHON3_ASYNC_TIMEOUT_SUFFIX)
PYTHON3_ASYNC_TIMEOUT_DIR	:= $(BUILDDIR)/$(PYTHON3_ASYNC_TIMEOUT)
PYTHON3_ASYNC_TIMEOUT_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_ASYNC_TIMEOUT_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-async-timeout.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-async-timeout)
	@$(call install_fixup, python3-async-timeout, PRIORITY, optional)
	@$(call install_fixup, python3-async-timeout, SECTION, base)
	@$(call install_fixup, python3-async-timeout, AUTHOR, "Pim Klanke <pim@protonic.nl>")
	@$(call install_fixup, python3-async-timeout, DESCRIPTION, missing)

	@$(call install_glob, python3-async-timeout, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES)/async_timeout,, *.py)

	@$(call install_finish, python3-async-timeout)

	@$(call touch)

# vim: syntax=make
