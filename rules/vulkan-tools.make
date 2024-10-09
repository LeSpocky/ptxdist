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
PACKAGES-$(PTXCONF_VULKAN_TOOLS) += vulkan-tools

#
# Paths and names
#
VULKAN_TOOLS_VERSION	:= 1.3.296.0
VULKAN_TOOLS_MD5	:= 6cc24a1fe1fe0794a1bd24e339a28dda
VULKAN_TOOLS		:= vulkan-tools-$(VULKAN_TOOLS_VERSION)
VULKAN_TOOLS_SUFFIX	:= tar.gz
VULKAN_TOOLS_URL	:= https://github.com/KhronosGroup/Vulkan-Tools/archive/vulkan-sdk-$(VULKAN_TOOLS_VERSION).$(VULKAN_TOOLS_SUFFIX)
VULKAN_TOOLS_SOURCE	:= $(SRCDIR)/$(VULKAN_TOOLS).$(VULKAN_TOOLS_SUFFIX)
VULKAN_TOOLS_DIR	:= $(BUILDDIR)/$(VULKAN_TOOLS)
VULKAN_TOOLS_LICENSE	:= Apache-2.0
VULKAN_TOOLS_LICENSE_FILES := file://LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

VULKAN_TOOLS_CONF_TOOL	:= cmake
VULKAN_TOOLS_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DBUILD_CUBE=$(call ptx/onoff, PTXCONF_VULKAN_TOOLS_CUBE) \
	-DBUILD_ICD=OFF \
	-DBUILD_TESTS=OFF \
	-DBUILD_VULKANINFO=ON \
	-DBUILD_WERROR=ON \
	-DBUILD_WSI_DIRECTFB_SUPPORT=OFF \
	-DBUILD_WSI_WAYLAND_SUPPORT=$(call ptx/onoff, PTXCONF_VULKAN_TOOLS_WAYLAND) \
	-DBUILD_WSI_XCB_SUPPORT=$(call ptx/onoff, PTXCONF_VULKAN_TOOLS_XCB) \
	-DBUILD_WSI_XLIB_SUPPORT=OFF \
	-DENABLE_ADDRESS_SANITIZER=OFF \
	-DTOOLS_CODEGEN=OFF \
	-DUPDATE_DEPS=OFF

ifdef PTXCONF_VULKAN_TOOLS_CUBE
VULKAN_TOOLS_CONF_OPT	+= \
	-DCUBE_WSI_SELECTION=$(call ptx/ifdef, PTXCONF_VULKAN_TOOLS_WAYLAND, WAYLAND, \
			$(call ptx/ifdef, PTXCONF_VULKAN_TOOLS_XCB, XCB, DISPLAY)) \
	-DGLSLANG_INSTALL_DIR=$(PTXDIST_SYSROOT_HOST)/usr/bin
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/vulkan-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, vulkan-tools)
	@$(call install_fixup, vulkan-tools, PRIORITY, optional)
	@$(call install_fixup, vulkan-tools, SECTION, base)
	@$(call install_fixup, vulkan-tools, AUTHOR, "Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, vulkan-tools, DESCRIPTION, Vulkan Utilities and Tools)

ifdef PTXCONF_VULKAN_TOOLS_CUBE
	@$(call install_copy, vulkan-tools, 0, 0, 0755, -, /usr/bin/vkcube)
	@$(call install_copy, vulkan-tools, 0, 0, 0755, -, /usr/bin/vkcubepp)
endif

	@$(call install_copy, vulkan-tools, 0, 0, 0755, -, /usr/bin/vulkaninfo)

	@$(call install_finish, vulkan-tools)

	@$(call touch)

# vim: syntax=make
