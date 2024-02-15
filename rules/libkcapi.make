# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Grzeschik <mgr@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBKCAPI) += libkcapi

#
# Paths and names
#
LIBKCAPI_VERSION	:= 1.5.0
LIBKCAPI_MD5		:= 1114dc32e6055f09076ca04b7e0c93e2
LIBKCAPI		:= libkcapi-$(LIBKCAPI_VERSION)
LIBKCAPI_SUFFIX		:= tar.gz
LIBKCAPI_URL		:= https://github.com/smuellerDD/libkcapi/archive/refs/tags/v$(LIBKCAPI_VERSION).$(LIBKCAPI_SUFFIX)
LIBKCAPI_SOURCE		:= $(SRCDIR)/$(LIBKCAPI).$(LIBKCAPI_SUFFIX)
LIBKCAPI_DIR		:= $(BUILDDIR)/$(LIBKCAPI)
LIBKCAPI_LICENSE	:= GPLv2+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBKCAPI_CONF_ENV	:= \
			$(CROSS_ENV) \
			ac_cv_path_XMLTO=

#
# autoconf
#
LIBKCAPI_CONF_TOOL	:= autoconf
LIBKCAPI_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-werror \
	--$(call ptx/endis, PTXCONF_LIBKCAPI_TEST)-kcapi-test \
	--enable-kcapi-speed \
	--enable-kcapi-hasher \
	--enable-kcapi-rngapp \
	--enable-kcapi-encapp \
	--enable-kcapi-dgstapp \
	--enable-lib-kdf \
	--enable-lib-sym \
	--enable-lib-md \
	--enable-lib-aead \
	--enable-lib-rng \
	--disable-lib-asym \
	--disable-lib-kpp

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libkcapi.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libkcapi)
	@$(call install_fixup, libkcapi,PRIORITY,optional)
	@$(call install_fixup, libkcapi,SECTION,base)
	@$(call install_fixup, libkcapi,AUTHOR,"Michael Grzeschik <mgr@pengutronix.de>")
	@$(call install_fixup, libkcapi,DESCRIPTION,missing)

	@$(call install_lib, libkcapi, 0, 0, 0644, libkcapi);

	@$(call install_copy, libkcapi, 0, 0, 0755, -, /usr/bin/kcapi-rng);
	@$(call install_copy, libkcapi, 0, 0, 0755, -, /usr/bin/kcapi-speed);
	@$(call install_copy, libkcapi, 0, 0, 0755, -, /usr/bin/kcapi-enc);
	@$(call install_copy, libkcapi, 0, 0, 0755, -, /usr/bin/kcapi-dgst);

	@$(call install_copy, libkcapi, 0, 0, 0755, -, /usr/bin/kcapi-hasher);
	@$(call install_link, libkcapi, kcapi-hasher, /usr/bin/fipscheck);
	@$(call install_link, libkcapi, kcapi-hasher, /usr/bin/fipshmac);
	@$(call install_link, libkcapi, kcapi-hasher, /usr/bin/sha1hmac);
	@$(call install_link, libkcapi, kcapi-hasher, /usr/bin/sha224hmac);
	@$(call install_link, libkcapi, kcapi-hasher, /usr/bin/sha256hmac);
	@$(call install_link, libkcapi, kcapi-hasher, /usr/bin/sha384hmac);
	@$(call install_link, libkcapi, kcapi-hasher, /usr/bin/sha512hmac);

ifdef PTXCONF_LIBKCAPI_MD5SUM
	@$(call install_link, libkcapi, kcapi-hasher, /usr/bin/md5sum);
endif

ifdef PTXCONF_LIBKCAPI_SHA1SUM
	@$(call install_link, libkcapi, kcapi-hasher, /usr/bin/sha1sum);
endif

ifdef PTXCONF_LIBKCAPI_SHA224SUM
	@$(call install_link, libkcapi, kcapi-hasher, /usr/bin/sha224sum);
endif

ifdef PTXCONF_LIBKCAPI_SHA256SUM
	@$(call install_link, libkcapi, kcapi-hasher, /usr/bin/sha256sum);
endif

ifdef PTXCONF_LIBKCAPI_SHA384SUM
	@$(call install_link, libkcapi, kcapi-hasher, /usr/bin/sha384sum);
endif

ifdef PTXCONF_LIBKCAPI_SHA512SUM
	@$(call install_link, libkcapi, kcapi-hasher, /usr/bin/sha512sum);
endif

ifdef PTXCONF_LIBKCAPI_TEST
	@$(call install_tree, libkcapi, 0, 0, -, /usr/libexec/libkcapi);
endif

	@$(call install_finish, libkcapi)

	@$(call touch)

# vim: syntax=make
