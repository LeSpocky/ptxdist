# -*-makefile-*-
#
# Copyright (C) 2020 by Marian Cichy <m.cichy@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GST_BAYER2RGB_NEON) += gst-bayer2rgb-neon

#
# Paths and names
#
GST_BAYER2RGB_NEON_VERSION	:= 0.3
GST_BAYER2RGB_NEON_MD5		:= 73f05f8504e29c03d6b1164ee37b4fb9
GST_BAYER2RGB_NEON		:= gst-bayer2rgb-neon-$(GST_BAYER2RGB_NEON_VERSION)
GST_BAYER2RGB_NEON_SUFFIX	:= tar.bz2
GST_BAYER2RGB_NEON_URL		:= https://git.phytec.de/gst-bayer2rgb-neon/snapshot/$(GST_BAYER2RGB_NEON).$(GST_BAYER2RGB_NEON_SUFFIX)
GST_BAYER2RGB_NEON_SOURCE	:= $(SRCDIR)/$(GST_BAYER2RGB_NEON).$(GST_BAYER2RGB_NEON_SUFFIX)
GST_BAYER2RGB_NEON_DIR		:= $(BUILDDIR)/$(GST_BAYER2RGB_NEON)
GST_BAYER2RGB_NEON_LICENSE	:= GPL-3.0-only
GST_BAYER2RGB_NEON_LICENSE_FILES:= file://COPYING;md5=d32239bcb673463ab874e80d47fae504

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
GST_BAYER2RGB_NEON_CONF_TOOL	:= autoconf
GST_BAYER2RGB_NEON_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--with-plugindir=/usr/lib/gstreamer-1.0

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gst-bayer2rgb-neon.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gst-bayer2rgb-neon)
	@$(call install_fixup, gst-bayer2rgb-neon,PRIORITY,optional)
	@$(call install_fixup, gst-bayer2rgb-neon,SECTION,base)
	@$(call install_fixup, gst-bayer2rgb-neon,AUTHOR,"Marian Cichy <m.cichy@pengutronix.de>")
	@$(call install_fixup, gst-bayer2rgb-neon,DESCRIPTION,missing)

	@$(call install_lib, gst-bayer2rgb-neon, 0, 0, 0644, \
		gstreamer-1.0/gstbayer2rgbneon)
	@$(call install_finish, gst-bayer2rgb-neon)

	@$(call touch)

# vim: syntax=make
