# -*-makefile-*-
#
# Copyright (C) 2025 by Fabian Pfitzner <f.pfitzner@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_X264) += x264

#
# Paths and names
#
X264_VERSION	:= 2025-08-27-g31e19f92f00c7
X264_MD5	:= 540aaf514c058f0c0ecbd63f70320783
X264		:= x264-$(X264_VERSION)
X264_SUFFIX	:= tar.gz
X264_URL	:= https://code.videolan.org/videolan/x264/-/archive/$(X264_VERSION)/$(X264).$(X264_SUFFIX)
X264_SOURCE	:= $(SRCDIR)/$(X264).$(X264_SUFFIX)
X264_DIR	:= $(BUILDDIR)/$(X264)
X264_LICENSE	:= GPL-2.0-only
X264_LICENSE_FILES	:= file://COPYING;md5=94d55d512a9ba36caa9b7df079bae19f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

X264_CONF_ENV := \
	$(CROSS_ENV) \
	AS=$(CROSS_CC)

X264_CONF_TOOL := autoconf
X264_CONF_OPT := \
	--host=$(patsubst aarch64-v8a%,aarch64% \
	      ,$(patsubst arm-v7a%,arm% \
	      ,$(PTXCONF_GNU_TARGET))) \
	--prefix=/usr \
	--enable-shared

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/x264.targetinstall:
	@$(call targetinfo)

	@$(call install_init, x264)
	@$(call install_fixup, x264,PRIORITY,optional)
	@$(call install_fixup, x264,SECTION,base)
	@$(call install_fixup, x264,AUTHOR,"Fabian Pfitzner <f.pfitzner@pengutronix.de>")
	@$(call install_fixup, x264,DESCRIPTION,missing)

	@$(call install_lib, x264, 0, 0, 0644, libx264)

	@$(call install_finish, x264)

	@$(call touch)

# vim: syntax=make
