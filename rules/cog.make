# -*-makefile-*-
#
# Copyright (C) 2019 by Philippe Normand <philn@igalia.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_COG) += cog

#
# Paths and names
#
COG_VERSION		:= 0.8.0
COG_MD5			:= f7aa8a425927cab247563411fc67c5a3
COG			:= cog-$(COG_VERSION)
COG_SUFFIX		:= tar.xz
COG_URL			:= https://wpewebkit.org/releases/$(COG).$(COG_SUFFIX)
COG_SOURCE		:= $(SRCDIR)/$(COG).$(COG_SUFFIX)
COG_DIR			:= $(BUILDDIR)/$(COG)
COG_LICENSE		:= MIT
COG_LICENSE_FILES	:= file://COPYING;md5=bf1229cd7425b302d60cdb641b0ce5fb

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
COG_CONF_TOOL	:= cmake
COG_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-G Ninja \
	-DCOG_APPID= \
	-DCOG_BUILD_PROGRAMS=ON \
	-DCOG_DBUS_OWN_USER= \
	-DCOG_DBUS_SYSTEM_BUS=OFF \
	-DCOG_HOME_URI=https://ptxdist.org/ \
	-DCOG_PLATFORM_DRM=OFF \
	-DCOG_PLATFORM_FDO=ON \
	-DCOG_USE_WEBKITGTK=OFF \
	-DCOG_WESTON_DIRECT_DISPLAY=OFF \
	-DINSTALL_MAN_PAGES=OFF \
	-DWAYLAND_PROTOCOLS=$(PTXDIST_SYSROOT_TARGET)/usr/share/wayland-protocols

# ----------------------------------------------------------------------------
# Target-Install
# -----------------------------------------------------------------------------

$(STATEDIR)/cog.targetinstall:
	@$(call targetinfo)

	@$(call install_init, cog)
	@$(call install_fixup, cog,PRIORITY,optional)
	@$(call install_fixup, cog,SECTION,base)
	@$(call install_fixup, cog,AUTHOR,"Philippe Normand <philn@igalia.com>")
	@$(call install_fixup, cog,DESCRIPTION,"WPE launcher and webapp container")

	@$(call install_copy, cog, 0, 0, 0755, -, /usr/bin/cog)
	@$(call install_lib, cog, 0, 0, 0644, libcogplatform-fdo)
	@$(call install_lib, cog, 0, 0, 0644, libcogcore)

	@$(call install_finish, cog)

	@$(call touch)

# vim: syntax=make
