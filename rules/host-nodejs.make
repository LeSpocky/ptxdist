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
HOST_NODEJS_COMPILE_ENV	:= \
	ICECC_REMOTE_CPP=0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_NODEJS_CONF_TOOL	:= autoconf
HOST_NODEJS_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--prefix=/ \
	--no-cross-compiling \
	--dest-os=linux \
	--without-dtrace \
	--without-etw \
	--without-npm \
	--shared \
	--shared-openssl \
	--shared-zlib \
	--shared-cares \
	--with-intl=none \
	--without-snapshot

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-nodejs.install:
	@$(call targetinfo)
	@$(call install, HOST_NODEJS)

#	# Needed to cross-compile for target.
	@install -pm 0755 $(HOST_NODEJS_DIR)/out/Release/bytecode_builtins_list_generator $(HOST_NODEJS_PKGDIR)/bin/
	@install -pm 0755 $(HOST_NODEJS_DIR)/out/Release/mkcodecache $(HOST_NODEJS_PKGDIR)/bin/
	@install -pm 0755 $(HOST_NODEJS_DIR)/out/Release/node_mksnapshot $(HOST_NODEJS_PKGDIR)/bin/
	@install -pm 0755 $(HOST_NODEJS_DIR)/out/Release/torque $(HOST_NODEJS_PKGDIR)/bin/

	@$(call touch)

# vim: syntax=make
