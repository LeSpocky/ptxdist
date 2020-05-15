# -*-makefile-*-
#
# Copyright (C) 2019 by Sascha Hauer <s.hauer@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PTX_CODE_SIGNING_DEV) += host-ptx-code-signing-dev

#
# Paths and names
#
HOST_PTX_CODE_SIGNING_DEV_VERSION	:= 0.4
HOST_PTX_CODE_SIGNING_DEV_MD5		:= 853ac0147adc0b46dc695e16a7101aaa
HOST_PTX_CODE_SIGNING_DEV		:= ptx-code-signing-dev-$(HOST_PTX_CODE_SIGNING_DEV_VERSION)
HOST_PTX_CODE_SIGNING_DEV_SUFFIX	:= tar.gz
HOST_PTX_CODE_SIGNING_DEV_URL		:= https://git.pengutronix.de/cgit/ptx-code-signing-dev/snapshot/$(HOST_PTX_CODE_SIGNING_DEV).$(HOST_PTX_CODE_SIGNING_DEV_SUFFIX)
HOST_PTX_CODE_SIGNING_DEV_SOURCE	:= $(SRCDIR)/$(HOST_PTX_CODE_SIGNING_DEV).$(HOST_PTX_CODE_SIGNING_DEV_SUFFIX)
HOST_PTX_CODE_SIGNING_DEV_DIR		:= $(HOST_BUILDDIR)/$(HOST_PTX_CODE_SIGNING_DEV)

CODE_SIGNING_ENV-$(PTXCONF_HOST_PTX_CODE_SIGNING_DEV) += $(SOFTHSM_CODE_SIGNING_ENV)

HOST_PTX_CODE_SIGNING_DEV_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

HOST_PTX_CODE_SIGNING_DEV_MAKE_ENV	:= \
	$(CODE_SIGNING_ENV)

$(STATEDIR)/host-ptx-code-signing-dev.compile:
	@$(call targetinfo)
	@$(call world/execute, HOST_PTX_CODE_SIGNING_DEV, \
		./ptxdist-import-keys.sh)
	@$(call touch)

$(STATEDIR)/host-ptx-code-signing-dev.install:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make
