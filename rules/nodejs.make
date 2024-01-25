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
NODEJS_VERSION		:= v20.11.0
NODEJS_MD5		:= e112c8d089843052639ac5c438149c4e
NODEJS			:= node-$(NODEJS_VERSION)
NODEJS_SUFFIX		:= tar.xz
NODEJS_URL		:= http://nodejs.org/dist/$(NODEJS_VERSION)/$(NODEJS).$(NODEJS_SUFFIX)
NODEJS_SOURCE		:= $(SRCDIR)/$(NODEJS).$(NODEJS_SUFFIX)
NODEJS_DIR		:= $(BUILDDIR)/$(NODEJS)
NODEJS_LICENSE		:= MIT AND ISC AND BSD-3-Clause AND BSD-2-Clause AND Apache-2.0
NODEJS_LICENSE_FILES	:= \
        file://LICENSE;md5=78ad16dab3c1d15d4878c81770be0be7

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
	--cross-compiling \
	--dest-os=linux \
	$(call ptx/ifdef,PTXCONF_ARCH_ARM,--with-arm-float-abi=$(NODEJS_ARM_FLOAT_ABI)) \
	$(call ptx/ifdef,PTXCONF_ARCH_ARM,--with-arm-fpu=$(NODEJS_ARM_FPU)) \
	--without-npm \
	--shared \
	--shared-libuv \
	--shared-openssl \
	--shared-zlib \
	--shared-brotli \
	--shared-cares \
	--with-intl=none

ifdef PTXCONF_GLOBAL_LARGE_FILE
# these flags are supposed to come from libuv but that does not work with shared libuv
NODEJS_CPPFLAGS := \
	-D_LARGEFILE_SOURCE \
	-D_FILE_OFFSET_BITS=64
endif

$(STATEDIR)/nodejs.prepare:
	@$(call targetinfo)

	@$(call world/execute, NODEJS, \
		python3 ./configure $(NODEJS_CONF_OPT))
	@mkdir -p $(NODEJS_DIR)/out/Release/
	@ ln -svf $(PTXDIST_SYSROOT_CROSS)/usr/bin/qemu-cross \
		$(NODEJS_DIR)/out/Release/tool-wrapper

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
