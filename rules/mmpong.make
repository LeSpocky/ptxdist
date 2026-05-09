# -*-makefile-*-
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MMPONG) += mmpong

#
# Paths and names
#
MMPONG_VERSION	:= 0.9
MMPONG_SHA256	:= 86a3b32ce72ab24105b9ed9d8eb76afa996ebe6075243f998a7e7829b7ab0ca8
MMPONG		:= mmpong-$(MMPONG_VERSION)
MMPONG_SUFFIX	:= tar.gz
MMPONG_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(MMPONG).$(MMPONG_SUFFIX)
MMPONG_SOURCE	:= $(SRCDIR)/$(MMPONG).$(MMPONG_SUFFIX)
MMPONG_DIR	:= $(BUILDDIR)/$(MMPONG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MMPONG_CONF_TOOL := cmake

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mmpong.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mmpong)
	@$(call install_fixup, mmpong,PRIORITY,optional)
	@$(call install_fixup, mmpong,SECTION,base)
	@$(call install_fixup, mmpong,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, mmpong,DESCRIPTION,missing)

	@$(call install_lib, mmpong, 0, 0, 0644, libmmpong)

ifdef PTXCONF_MMPONG_CACA
	@$(call install_copy, mmpong, 0, 0, 0755, -, /usr/games/mmpong-caca)
endif
ifdef PTXCONF_MMPONG_SERVER
	@$(call install_copy, mmpong, 0, 0, 0755, -, /usr/games/mmpongd)
endif

	@$(call install_finish, mmpong)

	@$(call touch)

# vim: syntax=make
