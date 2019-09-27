# -*-makefile-*-
#
# Copyright (C) 2019 by Sascha Hauer <s.hauer@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

CODE_SIGNING_ENV = \
	SO_PATH=$(PTXDIST_SYSROOT_HOST)/lib/engines-1.1/pkcs11.so \
	OPENSSL_CONF="$(PTXDIST_SYSROOT_HOST)/ssl/openssl.cnf" \
	OPENSSL_ENGINES="$(PTXDIST_SYSROOT_HOST)/lib/engines-1.1"

# vim: syntax=make
