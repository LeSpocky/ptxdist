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
PACKAGES-$(PTXCONF_VULKAN_VALIDATIONLAYERS) += vulkan-validationlayers

#
# Paths and names
#
VULKAN_VALIDATIONLAYERS_VERSION	:= 1.4.313.0
VULKAN_VALIDATIONLAYERS_MD5	:= f35f7c7220c5db126e62cc5b87eb1087
VULKAN_VALIDATIONLAYERS		:= vulkan-validationlayers-$(VULKAN_VALIDATIONLAYERS_VERSION)
VULKAN_VALIDATIONLAYERS_SUFFIX	:= tar.gz
VULKAN_VALIDATIONLAYERS_URL	:= https://github.com/KhronosGroup/Vulkan-ValidationLayers/archive/vulkan-sdk-$(VULKAN_VALIDATIONLAYERS_VERSION).$(VULKAN_VALIDATIONLAYERS_SUFFIX)
VULKAN_VALIDATIONLAYERS_SOURCE	:= $(SRCDIR)/$(VULKAN_VALIDATIONLAYERS).$(VULKAN_VALIDATIONLAYERS_SUFFIX)
VULKAN_VALIDATIONLAYERS_DIR	:= $(BUILDDIR)/$(VULKAN_VALIDATIONLAYERS)
VULKAN_VALIDATIONLAYERS_LICENSE	:= Apache-2.0 AND MIT AND BSL-1.0
VULKAN_VALIDATIONLAYERS_LICENSE_FILES := file://LICENSE.txt;md5=b1a17d548e004bfbbfaa0c40988b6b31

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

VULKAN_VALIDATIONLAYERS_CONF_TOOL	:= cmake
VULKAN_VALIDATIONLAYERS_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DCMAKE_BUILD_TYPE=Release \
	-DBUILD_SELF_VVL=OFF \
	-DBUILD_TESTS=OFF \
	-DBUILD_WERROR=OFF \
	-DBUILD_WSI_WAYLAND_SUPPORT=$(call ptx/onoff, PTXCONF_VULKAN_VALIDATIONLAYERS_WAYLAND) \
	-DBUILD_WSI_XCB_SUPPORT=$(call ptx/onoff, PTXCONF_VULKAN_VALIDATIONLAYERS_XCB) \
	-DBUILD_WSI_XLIB_SUPPORT=OFF \
	-DDEBUG_CAPTURE_KEYBOARD=OFF \
	-DUPDATE_DEPS=OFF \
	-DUSE_CUSTOM_HASH_MAP=ON \
	-DVVL_CODEGEN=OFF \
	-DVVL_ENABLE_ASAN=OFF \
	-DVVL_ENABLE_TRACY=OFF \
	-DVVL_ENABLE_TRACY_CPU_MEMORY=OFF \
	-DVVL_ENABLE_UBSAN=OFF \
	-DVVL_TRACY_CALLSTACK=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/vulkan-validationlayers.targetinstall:
	@$(call targetinfo)

	@$(call install_init, vulkan-validationlayers)
	@$(call install_fixup, vulkan-validationlayers, PRIORITY, optional)
	@$(call install_fixup, vulkan-validationlayers, SECTION, base)
	@$(call install_fixup, vulkan-validationlayers, AUTHOR, "Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, vulkan-validationlayers, DESCRIPTION, Vulkan Validation Layers)

	@$(call install_lib, vulkan-validationlayers, 0, 0, 0644, libVkLayer_khronos_validation)

	@$(call install_copy, vulkan-validationlayers, 0, 0, 0644, -, /usr/share/vulkan/explicit_layer.d/VkLayer_khronos_validation.json)

	@$(call install_finish, vulkan-validationlayers)

	@$(call touch)

# vim: syntax=make
