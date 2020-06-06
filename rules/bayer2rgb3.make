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
PACKAGES-$(PTXCONF_BAYER2RGB3) += bayer2rgb3

#
# Paths and names
#
BAYER2RGB3_VERSION	:= 0.4.1
BAYER2RGB3_MD5		:= 5362a93d4251eb012d38c1409af0182e
BAYER2RGB3		:= bayer2rgb3-$(BAYER2RGB3_VERSION)
BAYER2RGB3_SUFFIX	:= zip
BAYER2RGB3_URL		:= https://gitlab-ext.sigma-chemnitz.de/ensc/bayer2rgb/-/archive/master/bayer2rgb-master.zip
BAYER2RGB3_SOURCE	:= $(SRCDIR)/$(BAYER2RGB3).$(BAYER2RGB3_SUFFIX)
BAYER2RGB3_DIR		:= $(BUILDDIR)/$(BAYER2RGB3)
BAYER2RGB3_LICENSE	:= GPL-3.0-only
BAYER2RGB3_LICENSE_FILES := file://COPYING;md5=d32239bcb673463ab874e80d47fae504

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
BAYER2RGB3_CONF_TOOL	:= autoconf
BAYER2RGB3_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-as-needed \
	--$(call ptx/endis, PTXCONF_BAYER2RGB3_COMMAND_TOOL)-cplusplus \
	--$(call ptx/endis, PTXCONF_BAYER2RGB3_COMMAND_TOOL)-c

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bayer2rgb3.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bayer2rgb3)
	@$(call install_fixup, bayer2rgb3,PRIORITY,optional)
	@$(call install_fixup, bayer2rgb3,SECTION,base)
	@$(call install_fixup, bayer2rgb3,AUTHOR,"Marian Cichy <m.cichy@pengutronix.de>")
	@$(call install_fixup, bayer2rgb3,DESCRIPTION,missing)

ifdef PTXCONF_BAYER2RGB3_COMMAND_TOOL
	@$(call install_copy, bayer2rgb3, 0, 0, 0755, -, /usr/bin/bayer2rgb)
endif
	@$(call install_lib, bayer2rgb3, 0, 0, 0644, libbayer2rgb3)

	@$(call install_finish, bayer2rgb3)

	@$(call touch)

# vim: syntax=make
