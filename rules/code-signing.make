# -*-makefile-*-
#
# Copyright (C) 2020 by Bastian Krause <bst@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ifdef PTXCONF_CODE_SIGNING
ifeq ($(call remove_quotes,$(PTXCONF_CODE_SIGNING_PROVIDER)),)
$(error PTXCONF_CODE_SIGNING_PROVIDER must be set correctly)
endif
endif
