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
PACKAGES-$(PTXCONF_NEATVNC) += neatvnc

#
# Paths and names
#
NEATVNC_VERSION	:= 0.5.1
NEATVNC_MD5	:= 5811a7890a1da1fa57cda4424818b0c2
NEATVNC		:= neatvnc-$(NEATVNC_VERSION)
NEATVNC_SUFFIX	:= tar.gz
NEATVNC_URL	:= https://github.com/any1/neatvnc/archive/refs/tags/v$(NEATVNC_VERSION).$(NEATVNC_SUFFIX)
NEATVNC_SOURCE	:= $(SRCDIR)/$(NEATVNC).$(NEATVNC_SUFFIX)
NEATVNC_DIR	:= $(BUILDDIR)/$(NEATVNC)
NEATVNC_LICENSE	:= ISC

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
NEATVNC_CONF_TOOL	:= meson
NEATVNC_CONF_OPT	:=  \
	$(CROSS_MESON_USR) \
	-Dbenchmarks=false \
	-Dexamples=false \
	-Dgbm=$(call ptx/endis,PTXCONF_NEATVNC_GBM)d \
	-Dh264=$(call ptx/endis,PTXCONF_NEATVNC_OPENH264)d \
	-Djpeg=$(call ptx/endis,PTXCONF_NEATVNC_JPEG)d \
	-Dsystemtap=false \
	-Dtests=false \
	-Dtls=disabled

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/neatvnc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, neatvnc)
	@$(call install_fixup, neatvnc,PRIORITY,optional)
	@$(call install_fixup, neatvnc,SECTION,base)
	@$(call install_fixup, neatvnc,AUTHOR,"Marian Cichy <m.cichy@pengutronix.de>")
	@$(call install_fixup, neatvnc,DESCRIPTION,missing)

	@$(call install_lib, neatvnc, 0, 0, 0644, libneatvnc)

	@$(call install_finish, neatvnc)

	@$(call touch)

# vim: syntax=make
