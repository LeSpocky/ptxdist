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
VULKAN_VALIDATIONLAYERS_VERSION	:= 1.3.261.1
VULKAN_VALIDATIONLAYERS_MD5	:= 6663c3848b75ff0630b87675922b828b
VULKAN_VALIDATIONLAYERS		:= vulkan-validationlayers-$(VULKAN_VALIDATIONLAYERS_VERSION)
VULKAN_VALIDATIONLAYERS_SUFFIX	:= tar.gz
VULKAN_VALIDATIONLAYERS_URL	:= https://github.com/KhronosGroup/Vulkan-ValidationLayers/archive/sdk-$(VULKAN_VALIDATIONLAYERS_VERSION).$(VULKAN_VALIDATIONLAYERS_SUFFIX)
VULKAN_VALIDATIONLAYERS_SOURCE	:= $(SRCDIR)/$(VULKAN_VALIDATIONLAYERS).$(VULKAN_VALIDATIONLAYERS_SUFFIX)
VULKAN_VALIDATIONLAYERS_DIR	:= $(BUILDDIR)/$(VULKAN_VALIDATIONLAYERS)
VULKAN_VALIDATIONLAYERS_LICENSE	:= Apache-2.0 AND MIT
VULKAN_VALIDATIONLAYERS_LICENSE_FILES := file://LICENSE.txt;md5=cd3c0bc366cd9b6a906e22f0bcb5910f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

VULKAN_VALIDATIONLAYERS_CONF_TOOL	:= cmake
VULKAN_VALIDATIONLAYERS_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DCMAKE_BUILD_TYPE=Release \
	-DBUILD_LAYERS=ON \
	-DBUILD_LAYER_SUPPORT_FILES=OFF \
	-DBUILD_TESTS=OFF \
	-DBUILD_WERROR=OFF \
	-DBUILD_WSI_WAYLAND_SUPPORT=$(call ptx/onoff, PTXCONF_VULKAN_VALIDATIONLAYERS_WAYLAND) \
	-DBUILD_WSI_XCB_SUPPORT=$(call ptx/onoff, PTXCONF_VULKAN_VALIDATIONLAYERS_XCB) \
	-DBUILD_WSI_XLIB_SUPPORT=OFF \
	-DUPDATE_DEPS=OFF \
	-DUSE_ROBIN_HOOD_HASHING=OFF \
	-DVVL_CLANG_TIDY=OFF \
	-DVVL_CPP_STANDARD=20 \
	-DVVL_ENABLE_ASAN=OFF

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
