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
PACKAGES-$(PTXCONF_WAYVNC) += wayvnc

#
# Paths and names
#
WAYVNC_VERSION	:= 0.8.0
WAYVNC_MD5	:= 403b1e45edafa6bf07c9c308639df2b9
WAYVNC		:= wayvnc-$(WAYVNC_VERSION)
WAYVNC_SUFFIX	:= tar.gz
WAYVNC_URL	:= https://github.com/any1/wayvnc/archive/refs/tags/v$(WAYVNC_VERSION).$(WAYVNC_SUFFIX)
WAYVNC_SOURCE	:= $(SRCDIR)/$(WAYVNC).$(WAYVNC_SUFFIX)
WAYVNC_DIR	:= $(BUILDDIR)/$(WAYVNC)
WAYVNC_LICENSE	:= ISC

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
WAYVNC_CONF_TOOL	:= meson
WAYVNC_CONF_OPT	:=  \
	$(CROSS_MESON_USR) \
	-Dman-pages=disabled \
	-Dpam=disabled \
	-Dscreencopy-dmabuf=$(call ptx/endis,PTXCONF_WAYVNC_SCREENCOPY_DMABUF)d \
	-Dsystemtap=false \
	-Dtests=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wayvnc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, wayvnc)
	@$(call install_fixup, wayvnc,PRIORITY,optional)
	@$(call install_fixup, wayvnc,SECTION,base)
	@$(call install_fixup, wayvnc,AUTHOR,"Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, wayvnc,DESCRIPTION,missing)

	@$(call install_copy, wayvnc, 0, 0, 0755, -, /usr/bin/wayvnc)

	@$(call install_finish, wayvnc)

	@$(call touch)

# vim: syntax=make
