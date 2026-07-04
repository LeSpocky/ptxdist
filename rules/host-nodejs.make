# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Grzeschik <mgr@pengutronix.de>
# Copyright (C) 2019 by Björn Esser <bes@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_NODEJS) += host-nodejs

# Always run the preprocessor locally.
HOST_NODEJS_MAKE_ENV	:= \
	ICECC_REMOTE_CPP=0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_NODEJS_CONF_TOOL	:= autoconf
HOST_NODEJS_CONF_OPT	:= \
	--prefix=/usr \
	--no-cross-compiling \
	--dest-os=linux \
	--shared \
	--libdir=lib \
	--shared-openssl \
	--shared-zlib \
	--shared-cares \
	--with-intl=none

$(STATEDIR)/host-nodejs.prepare:
	@$(call targetinfo)

	@$(call world/execute, HOST_NODEJS, python3 $(HOST_NODEJS_DIR)/configure $(HOST_NODEJS_CONF_OPT))
	@mkdir -p $(HOST_NODEJS_DIR)/out/Release/
	@echo -e '#!/bin/sh\nexec "$${@}"' > \
		$(HOST_NODEJS_DIR)/out/Release/tool-wrapper
	@chmod +x $(HOST_NODEJS_DIR)/out/Release/tool-wrapper

	@$(call touch)

# vim: syntax=make
