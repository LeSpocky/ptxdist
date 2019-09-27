# -*-makefile-*-
#
# Copyright (C) 2019 by Sascha Hauer <s.hauer@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ifdef PTXCONF_HOST_SOFTHSM
SOFTHSM_CODE_SIGNING_ENV = \
	SOFTHSM2_CONF="$(PTXDIST_SYSROOT_HOST)/etc/softhsm2.conf" \
	PKCS11_MODULE_PATH=$(PTXDIST_SYSROOT_HOST)/lib/softhsm/libsofthsm2.so

CODE_SIGNING_ENV += \
	$(SOFTHSM_CODE_SIGNING_ENV)
endif

# vim: syntax=make
