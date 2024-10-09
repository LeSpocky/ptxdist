# -*-makefile-*-
#
# Copyright (C) 2020 by Philipp Zabel <p.zabel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_VULKAN_LOADER) += vulkan-loader

#
# Paths and names
#
VULKAN_LOADER_VERSION	:= 1.3.296.0
VULKAN_LOADER_MD5	:= a25690fb720eae4bb203db466b7f41d7
VULKAN_LOADER		:= vulkan-loader-$(VULKAN_LOADER_VERSION)
VULKAN_LOADER_SUFFIX	:= tar.gz
VULKAN_LOADER_URL	:= https://github.com/KhronosGroup/Vulkan-Loader/archive/vulkan-sdk-$(VULKAN_LOADER_VERSION).$(VULKAN_LOADER_SUFFIX)
VULKAN_LOADER_SOURCE	:= $(SRCDIR)/$(VULKAN_LOADER).$(VULKAN_LOADER_SUFFIX)
VULKAN_LOADER_DIR	:= $(BUILDDIR)/$(VULKAN_LOADER)
VULKAN_LOADER_LICENSE	:= Apache-2.0
VULKAN_LOADER_LICENSE_FILES := file://LICENSE.txt;md5=7dbefed23242760aa3475ee42801c5ac

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

VULKAN_LOADER_CONF_TOOL	:= cmake

VULKAN_LOADER_USE_GAS := OFF
ifdef PTXCONF_ARCH_ARM64
VULKAN_LOADER_USE_GAS := ON
endif
ifdef PTXCONF_ARCH_X86_64
VULKAN_LOADER_USE_GAS := ON
endif

VULKAN_LOADER_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-G Ninja \
	-DCMAKE_BUILD_TYPE=Release \
	-DBUILD_TESTS=OFF \
	-DBUILD_WERROR=OFF \
	-DBUILD_WSI_DIRECTFB_SUPPORT=OFF \
	-DBUILD_WSI_WAYLAND_SUPPORT=$(call ptx/onoff, PTXCONF_VULKAN_LOADER_WAYLAND) \
	-DBUILD_WSI_XCB_SUPPORT=$(call ptx/onoff, PTXCONF_VULKAN_LOADER_XCB) \
	-DBUILD_WSI_XLIB_SUPPORT=OFF \
	-DCODE_COVERAGE=OFF \
	-DFALLBACK_CONFIG_DIRS=/etc/xdg \
	-DFALLBACK_DATA_DIRS=/usr/local/share:/usr/share \
	-DLOADER_CODEGEN=OFF \
	-DLOADER_ENABLE_ADDRESS_SANITIZER=OFF \
	-DLOADER_ENABLE_THREAD_SANITIZER=OFF \
	-DLOADER_USE_UNSAFE_FILE_SEARCH=OFF \
	-DSYSCONFDIR= \
	-DUPDATE_DEPS=OFF \
	-DUSE_GAS=$(VULKAN_LOADER_USE_GAS)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/vulkan-loader.targetinstall:
	@$(call targetinfo)

	@$(call install_init, vulkan-loader)
	@$(call install_fixup, vulkan-loader, PRIORITY, optional)
	@$(call install_fixup, vulkan-loader, SECTION, base)
	@$(call install_fixup, vulkan-loader, AUTHOR, "Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, vulkan-loader, DESCRIPTION, Vulkan ICD Loader)

	@$(call install_lib, vulkan-loader, 0, 0, 0644, libvulkan)

	@$(call install_finish, vulkan-loader)

	@$(call touch)

# vim: syntax=make
