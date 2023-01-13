# -*-makefile-*-
# Copyright (C) 2021 by Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_TF_A) += host-tf-a

HOST_TF_A_MAKE_OPT = fiptool

$(STATEDIR)/host-tf-a.install:
	@$(call targetinfo)
	install -vD -m755 $(HOST_TF_A_DIR)/tools/fiptool/fiptool $(HOST_TF_A_PKGDIR)/usr/bin/fiptool
	@$(call touch)

# vim: syntax=make
