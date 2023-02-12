# -*-makefile-*-
#
# Copyright (C) 2019 by Sascha Hauer <s.hauer@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

CODE_SIGNING_ENV = \
	SO_PATH=$(PTXDIST_SYSROOT_HOST)/usr/lib/engines-3/pkcs11.so \
	OPENSSL_CONF="$(PTXDIST_SYSROOT_HOST)/usr/ssl/openssl.cnf" \
	OPENSSL_ENGINES="$(PTXDIST_SYSROOT_HOST)/usr/lib/engines-3"

#
# This macro is used to allow a code signing provider
# to communicate with a server in an other stage than get
#
ptx/online-code-signing-provider = $(eval CODE_SIGNING_ENV += \
	HTTPS_PROXY= HTTP_PROXY= https_proxy= http_proxy=)

# vim: syntax=make
