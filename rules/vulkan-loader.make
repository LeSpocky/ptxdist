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
VULKAN_LOADER_VERSION	:= 1.2.162.0
VULKAN_LOADER_MD5	:= 97de90f2b599979ea492a3ed92c025fb
VULKAN_LOADER		:= vulkan-loader-$(VULKAN_LOADER_VERSION)
VULKAN_LOADER_SUFFIX	:= tar.gz
VULKAN_LOADER_URL	:= https://github.com/KhronosGroup/Vulkan-Loader/archive/sdk-$(VULKAN_LOADER_VERSION).$(VULKAN_LOADER_SUFFIX)
VULKAN_LOADER_SOURCE	:= $(SRCDIR)/$(VULKAN_LOADER).$(VULKAN_LOADER_SUFFIX)
VULKAN_LOADER_DIR	:= $(BUILDDIR)/$(VULKAN_LOADER)
VULKAN_LOADER_LICENSE	:= Apache-2.0
VULKAN_LOADER_LICENSE_FILES := file://LICENSE.txt;md5=7dbefed23242760aa3475ee42801c5ac

VULKAN_HEADERS_VERSION	:= 1.2.162.0
VULKAN_HEADERS_MD5	:= a26c15a4bd1c683226c4e74b1f265248
VULKAN_HEADERS_SUFFIX	:= tar.gz
VULKAN_HEADERS_URL	:= https://github.com/KhronosGroup/Vulkan-Headers/archive/sdk-$(VULKAN_HEADERS_VERSION).$(VULKAN_HEADERS_SUFFIX)
VULKAN_HEADERS_SOURCE	:= $(SRCDIR)/vulkan-headers-$(VULKAN_HEADERS_VERSION).$(VULKAN_HEADERS_SUFFIX)
$(VULKAN_HEADERS_SOURCE) := VULKAN_HEADERS
VULKAN_HEADERS_DIR	:= $(VULKAN_LOADER_DIR)/vulkan-headers

VULKAN_LOADER_SOURCES	:= $(VULKAN_LOADER_SOURCE) $(VULKAN_HEADERS_SOURCE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/vulkan-loader.extract:
	@$(call targetinfo)
	@$(call clean, $(VULKAN_LOADER_DIR))
	@$(call extract, VULKAN_LOADER)
	@$(call extract, VULKAN_HEADERS)
	@$(call patchin, VULKAN_LOADER)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

VULKAN_LOADER_CONF_TOOL	:= cmake
VULKAN_LOADER_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_CROSSCOMPILING_EMULATOR=$(PTXDIST_SYSROOT_CROSS)/bin/qemu-cross \
	-DCMAKE_INSTALL_LIBDIR=/usr/lib \
	-DBUILD_WSI_XCB_SUPPORT=$(call ptx/onoff, PTXCONF_VULKAN_LOADER_XCB) \
	-DBUILD_WSI_XLIB_SUPPORT=OFF \
	-DBUILD_WSI_WAYLAND_SUPPORT=$(call ptx/onoff, PTXCONF_VULKAN_LOADER_WAYLAND) \
	-DBUILD_WSI_DIRECTFB_SUPPORT=OFF \
	-DBUILD_LOADER=ON \
	-DBUILD_TESTS=OFF \
	-DVulkanHeaders_INCLUDE_DIR=$(VULKAN_HEADERS_DIR)/include \
	-DVulkanRegistry_DIR=$(VULKAN_HEADERS_DIR)/registry

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/vulkan-loader.install:
	@$(call targetinfo)
	@$(call world/install, VULKAN_LOADER)
	@cp -rp $(VULKAN_HEADERS_DIR)/include $(VULKAN_LOADER_PKGDIR)/usr
	@cp -rp $(VULKAN_HEADERS_DIR)/registry $(VULKAN_LOADER_PKGDIR)/usr/share/vulkan
	@$(call touch)

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
