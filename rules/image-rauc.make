# -*-makefile-*-
#
# Copyright (C) 2017 by Enrico Joerns <e.joerns@pengutronix.de>
# Copyright (C) 2016 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_RAUC) += image-rauc

#
# Paths and names
#
IMAGE_RAUC		:= image-rauc
IMAGE_RAUC_DIR		:= $(BUILDDIR)/$(IMAGE_RAUC)
IMAGE_RAUC_IMAGE	:= $(IMAGEDIR)/update.raucb
IMAGE_RAUC_CONFIG	:= rauc.config
IMAGE_RAUC_HOOK_FILE	:= $(call ptx/in-path, PTXDIST_PATH, config/images/rauc-hooks.sh)

$(call ptx/cfghash, IMAGE_RAUC, $(IMAGE_RAUC_HOOK_FILE))
$(call ptx/cfghash-file, IMAGE_RAUC, $(IMAGE_RAUC_HOOK_FILE))

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

ifdef PTXCONF_IMAGE_RAUC

ifdef PTXCONF_IMAGE_RAUC_BUNDLE_FORMAT_PLAIN
IMAGE_RAUC_BUNDLE_FORMAT := "plain"
endif
ifdef PTXCONF_IMAGE_RAUC_BUNDLE_FORMAT_VERITY
IMAGE_RAUC_BUNDLE_FORMAT := "verity"
endif
ifdef PTXCONF_IMAGE_RAUC_BUNDLE_FORMAT_CRYPT
IMAGE_RAUC_BUNDLE_FORMAT := "crypt"
endif

ifdef PTXCONF_IMAGE_RAUC_HOOK
ifndef IMAGE_RAUC_HOOK_FILE
$(error IMAGE_RAUC_HOOK is enabled, but config/images/rauc-hooks.sh was not \
	found in any component of PTXDIST_PATH)
endif
IMAGE_RAUC_ENV_HOOK = \
	RAUC_HOOK_FILE="file hooks.sh { image = \\"$(IMAGE_RAUC_HOOK_FILE)\\" }" \
	RAUC_HOOK_MANIFEST="filename=hooks.sh"
else
IMAGE_RAUC_ENV_HOOK = \
	RAUC_HOOK_FILE="" \
	RAUC_HOOK_MANIFEST=""
endif

IMAGE_RAUC_ENV	= \
	$(CODE_SIGNING_ENV) \
	RAUC_BUNDLE_COMPATIBLE="$(call remove_quotes,$(PTXCONF_RAUC_COMPATIBLE))" \
	RAUC_BUNDLE_FORMAT=$(IMAGE_RAUC_BUNDLE_FORMAT) \
	RAUC_BUNDLE_VERSION="$(call remove_quotes, $(PTXCONF_IMAGE_RAUC_BUNDLE_VERSION))" \
	RAUC_BUNDLE_BUILD=$(call ptx/sh, date +%FT%T%z) \
	RAUC_BUNDLE_DESCRIPTION="$(call remove_quotes, $(PTXCONF_IMAGE_RAUC_DESCRIPTION))" \
	$(IMAGE_RAUC_ENV_HOOK) \
	RAUC_KEY="$(shell cs_get_uri update)" \
	RAUC_CERT="$(shell cs_get_uri update)" \
	RAUC_KEYRING="$(shell cs_get_ca update)" \
	RAUC_INTERMEDIATE=$(call ptx/ifdef, PTXCONF_IMAGE_RAUC_INTERMEDIATE,'"$(shell cs_get_ca update-intermediate)"','{}')

$(IMAGE_RAUC_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_RAUC)
	@$(call finish)

endif

# vim: syntax=make
