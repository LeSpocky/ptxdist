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

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

ifdef PTXCONF_IMAGE_RAUC

IMAGE_RAUC_ENV	= \
	$(CODE_SIGNING_ENV) \
	RAUC_BUNDLE_COMPATIBLE="$(call remove_quotes,$(PTXCONF_RAUC_COMPATIBLE))" \
	RAUC_BUNDLE_VERSION="$(call remove_quotes, $(PTXCONF_RAUC_BUNDLE_VERSION))" \
	RAUC_BUNDLE_BUILD=$(call ptx/sh, date +%FT%T%z) \
	RAUC_BUNDLE_DESCRIPTION=$(PTXCONF_IMAGE_RAUC_DESCRIPTION) \
	RAUC_KEY="$(shell cs_get_uri update)" \
	RAUC_CERT="$(shell cs_get_uri update)" \
	RAUC_KEYRING="$(shell cs_get_ca update)"

$(IMAGE_RAUC_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_RAUC)
	@$(call finish)

endif

# vim: syntax=make
