# -*-makefile-*-
#
# Copyright (C) 2018 by Niklas Reisser <Niklas.Reisser@de.bosch.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GOOGLETEST) += googletest

#
# Paths and names
#
GOOGLETEST_VERSION	:= 1.8.1
GOOGLETEST_MD5		:= 2e6fbeb6a91310a16efe181886c59596
GOOGLETEST		:= googletest-release-$(GOOGLETEST_VERSION)
GOOGLETEST_SUFFIX	:= tar.gz
GOOGLETEST_URL		:= https://github.com/google/googletest/archive/release-$(GOOGLETEST_VERSION).$(GOOGLETEST_SUFFIX)
GOOGLETEST_SOURCE	:= $(SRCDIR)/$(GOOGLETEST).$(GOOGLETEST_SUFFIX)
GOOGLETEST_DIR		:= $(BUILDDIR)/$(GOOGLETEST)
GOOGLETEST_LICENSE	:= BSD-3-Clause
GOOGLETEST_LICENSE_FILES	:= file://LICENSE;md5=cbbd27594afd089daa160d3a16dd515a

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GOOGLETEST_CONF_TOOL := cmake
GOOGLETEST_CONF_OPT := \
	$(CROSS_CMAKE_USR) \
	-DBUILD_GMOCK=ON \
	-DBUILD_SHARED_LIBS=ON \
	-DINSTALL_GTEST=ON \
	-Dgmock_build_tests=OFF \
	-Dgtest_build_samples=OFF \
	-Dgtest_build_tests=OFF \
	-Dgtest_disable_pthreads=OFF \
	-Dgtest_force_shared_crt=OFF \
	-Dgtest_hide_internal_symbols=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/googletest.targetinstall:
	@$(call targetinfo)

	@$(call install_init, googletest)
	@$(call install_fixup, googletest,PRIORITY,optional)
	@$(call install_fixup, googletest,SECTION,base)
	@$(call install_fixup, googletest,AUTHOR,"Niklas Reisser <Niklas.Reisser@de.bosch.com>")
	@$(call install_fixup, googletest,DESCRIPTION,missing)

	@$(call install_lib, googletest, 0,0, 0644, libgmock)
	@$(call install_lib, googletest, 0,0, 0644, libgtest)
	@$(call install_lib, googletest, 0,0, 0644, libgtest_main)
	@$(call install_lib, googletest, 0,0, 0644, libgmock_main)

	@$(call install_finish, googletest)

	@$(call touch)

# vim: syntax=make
