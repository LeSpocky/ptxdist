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
HOST_PTX_CODE_SIGNING_DEV_VERSION	:= 0.8
HOST_PTX_CODE_SIGNING_DEV_SHA256	:= e5746446f456c07d91e023923e5331e7a0d3f0ec453e698c70726c5d7a5bd780
HOST_PTX_CODE_SIGNING_DEV		:= ptx-code-signing-dev-$(HOST_PTX_CODE_SIGNING_DEV_VERSION)
HOST_PTX_CODE_SIGNING_DEV_SUFFIX	:= tar.gz
HOST_PTX_CODE_SIGNING_DEV_URL		:= https://git.pengutronix.de/cgit/ptx-code-signing-dev/snapshot/$(HOST_PTX_CODE_SIGNING_DEV).$(HOST_PTX_CODE_SIGNING_DEV_SUFFIX)
HOST_PTX_CODE_SIGNING_DEV_SOURCE	:= $(SRCDIR)/$(HOST_PTX_CODE_SIGNING_DEV).$(HOST_PTX_CODE_SIGNING_DEV_SUFFIX)
HOST_PTX_CODE_SIGNING_DEV_DIR		:= $(HOST_BUILDDIR)/$(HOST_PTX_CODE_SIGNING_DEV)
HOST_PTX_CODE_SIGNING_DEV_LICENSE	:= MIT
HOST_PTX_CODE_SIGNING_DEV_LICENSE_FILES	:= \
	file://COPYING.MIT;md5=838c366f69b72c5df05c96dff79b35f2

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
