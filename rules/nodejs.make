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
ifndef PTXCONF_ARCH_PPC
PACKAGES-$(PTXCONF_NODEJS) += nodejs
endif

#
# Paths and names
#
NODEJS_VERSION		:= v12.16.1
NODEJS_MD5		:= 549582c075072c689c245ba12ecac54a
NODEJS			:= node-$(NODEJS_VERSION)
NODEJS_SUFFIX		:= tar.xz
NODEJS_URL		:= http://nodejs.org/dist/$(NODEJS_VERSION)/$(NODEJS).$(NODEJS_SUFFIX)
NODEJS_SOURCE		:= $(SRCDIR)/$(NODEJS).$(NODEJS_SUFFIX)
NODEJS_DIR		:= $(BUILDDIR)/$(NODEJS)
NODEJS_LICENSE		:= MIT AND ISC AND BSD-3-Clause
NODEJS_LICENSE_FILES	:= \
        file://LICENSE;md5=126890df35936bbffe9fa00c90ad4870

NODEJS_HOST_TOOLS	:= \
	bytecode_builtins_list_generator \
	gen-regexp-special-case \
	mkcodecache \
	mksnapshot \
	node_mksnapshot \
	torque

node/env = \
	$(CROSS_ENV) \
	npm_config_arch=$(NODEJS_ARCH) \
	npm_prefix=$(NODEJS_PKGDIR)/usr/lib \
	npm_config_cache=$(HOST_NODEJS_PKGDIR)/npm \
	npm_config_tmp=$(PTXDIST_TEMPDIR)/nodejs \
	npm_config_nodedir=$(NODEJS_DIR) \
	$(1)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ifdef PTXCONF_ARCH_X86
ifdef PTXCONF_ARCH_X86_64
NODEJS_ARCH := "x64"
else
NODEJS_ARCH := "ia32"
endif
else
NODEJS_ARCH := $(PTXCONF_ARCH_STRING)
endif

ifdef PTXCONF_ARCH_ARM
NODEJS_ARM_FLOAT_ABI = $(shell ptxd_cross_cc_v | sed -n "s/COLLECT_GCC_OPTIONS=.*'-mfloat-abi=\([^']*\)'.*/\1/p" | tail -n1)
NODEJS_ARM_FPU = $(shell ptxd_cross_cc_v | sed -n "s/COLLECT_GCC_OPTIONS=.*'-mfpu=\([^']*\)'.*/\1/p" | tail -n1)
endif

NODEJS_CONF_OPT := \
	--prefix=/usr \
	--dest-cpu=$(NODEJS_ARCH) \
	--no-cross-compiling \
	--dest-os=linux \
	$(call ptx/ifdef,PTXCONF_ARCH_ARM,--with-arm-float-abi=$(NODEJS_ARM_FLOAT_ABI)) \
	$(call ptx/ifdef,PTXCONF_ARCH_ARM,--with-arm-fpu=$(NODEJS_ARM_FPU)) \
	--without-dtrace \
	--without-etw \
	--without-npm \
	--shared \
	--shared-libuv \
	--shared-openssl \
	--shared-zlib \
	--shared-cares \
	--with-intl=none \
	--without-snapshot

$(STATEDIR)/nodejs.prepare:
	@$(call targetinfo)

#	# Using a patch here isn't enough, as we need absolute paths
#	# to the pre-built host tool binaries, which are different for
#	# each individual checkout of a BSP.  -_-
	$(foreach f,$(NODEJS_HOST_TOOLS), \
		sed -i -e "s#<(PRODUCT_DIR)/<(EXECUTABLE_PREFIX)$(f)<(EXECUTABLE_SUFFIX)#$(PTXDIST_SYSROOT_HOST)/bin/$(f)#" \
			$(NODEJS_DIR)/node.gyp $(NODEJS_DIR)/tools/v8_gypfiles/v8.gyp $(ptx/nl))

	@$(call world/prepare, NODEJS)

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nodejs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nodejs)
	@$(call install_fixup, nodejs,PRIORITY,optional)
	@$(call install_fixup, nodejs,SECTION,base)
	@$(call install_fixup, nodejs,AUTHOR,"Michael Grzeschik <mgr@pengutronix.de>")
	@$(call install_fixup, nodejs,DESCRIPTION,missing)

	@$(call install_copy, nodejs, 0, 0, 0755, -, /usr/bin/node)
	@$(call install_lib, nodejs, 0, 0, 0644, libnode)

#	# the place node searches for packages
	@$(call install_link, nodejs, node_modules, /usr/lib/node)

	@$(call install_finish, nodejs)

	@$(call touch)

# vim: syntax=make
