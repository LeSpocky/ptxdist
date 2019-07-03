# -*-makefile-*-
#
# Copyright (C) 2018 by Rouven Czerwinski <rouven@czerwinskis.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_OPTEE_PLATFORM
PACKAGES-$(PTXCONF_OPTEE_TEST) += optee-test
endif

#
# Paths and names
#
OPTEE_TEST_VERSION	:= 3.5.0
OPTEE_TEST_MD5		:= e75893492a92ea835e8f7e22eaa9697e
OPTEE_TEST		:= optee-test-$(OPTEE_TEST_VERSION)
OPTEE_TEST_SUFFIX	:= tar.gz
OPTEE_TEST_URL		:= https://github.com/OP-TEE/optee_test/archive/$(OPTEE_TEST_VERSION).$(OPTEE_TEST_SUFFIX)
OPTEE_TEST_SOURCE	:= $(SRCDIR)/$(OPTEE_TEST).$(OPTEE_TEST_SUFFIX)
OPTEE_TEST_DIR		:= $(BUILDDIR)/$(OPTEE_TEST)
OPTEE_TEST_LICENSE	:= BSD-2-Clause and GPL-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OPTEE_TEST_CONF_TOOL	:= NO
OPTEE_TEST_MAKE_ENV	:= \
	$(CROSS_ENV) \
	CROSS_COMPILE_HOST=$(call remove_quotes,$(PTXCONF_COMPILER_PREFIX)) \
	CROSS_COMPILE_TA=$(call remove_quotes,$(PTXCONF_COMPILER_PREFIX)) \
	TA_DEV_KIT_DIR=$(PTXDIST_SYSROOT_TARGET)/usr/lib/optee-os \
	OPTEE_CLIENT_EXPORT=$(PTXDIST_SYSROOT_TARGET)/usr \
	COMPILE_NS_USER=32 OPTEE_OPENSSL_EXPORT=$(PTXDIST_SYSROOT_TARGET)/usr/lib

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

OPTEE_TEST_INSTALL_OPT := install DESTDIR=$(OPTEE_TEST_PKGDIR)/usr/

$(STATEDIR)/optee-test.install:
	@$(call targetinfo)
	@$(call world/install, OPTEE_TEST)
	@mv -v $(OPTEE_TEST_PKGDIR)/usr/bin/xtest $(OPTEE_TEST_PKGDIR)/usr/bin/optee-xtest
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/optee-test.targetinstall:
	@$(call targetinfo)

	@$(call install_init, optee-test)
	@$(call install_fixup, optee-test,PRIORITY,optional)
	@$(call install_fixup, optee-test,SECTION,base)
	@$(call install_fixup, optee-test,AUTHOR,"Rouven Czerwinski <rouven@czerwinskis.de>")
	@$(call install_fixup, optee-test,DESCRIPTION,missing)

	@$(call install_copy, optee-test, 0, 0, 0755, -, /usr/bin/optee-xtest)
	@$(call install_tree, optee-test, 0, 0, -, /usr/lib/optee_armtz)

	@$(call install_finish, optee-test)

	@$(call touch)

# vim: syntax=make
