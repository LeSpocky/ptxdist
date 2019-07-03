# -*-makefile-*-
#
# Copyright (C) 2003-2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2011 by George McCollister <george.mccollister@gmail.com>
# For further information about the PTXdist project and license conditions
# see the README file.
#

ifdef PTXCONF_CROSS_DUMMY_STRIP
$(STATEDIR)/virtual-cross-tools.install: $(STATEDIR)/cross-dummy-strip.install.post
endif

ifdef PTXCONF_HOST_FAKEROOT
$(STATEDIR)/virtual-cross-tools.install: $(STATEDIR)/host-fakeroot.install.post
endif

$(STATEDIR)/virtual-cross-tools.install: $(STATEDIR)/host-opkg-utils.install.post

ifdef PTXCONF_CROSS_PKG_CONFIG_WRAPPER
$(STATEDIR)/virtual-cross-tools.install: $(STATEDIR)/cross-pkg-config-wrapper.install.post
endif

$(STATEDIR)/virtual-cross-tools.install:
	@$(call targetinfo)
	@$(call touch)


ifdef PTXCONF_HOST_DUMMY_INSTALL_INFO
$(STATEDIR)/virtual-host-tools.install: $(STATEDIR)/host-dummy-install-info.install.post
endif

ifdef PTXCONF_HOST_PKG_CONFIG
$(STATEDIR)/virtual-host-tools.install: $(STATEDIR)/host-pkg-config.install.post
endif

ifdef PTXCONF_HOST_CHRPATH
$(STATEDIR)/virtual-host-tools.install: $(STATEDIR)/host-chrpath.install.post
endif

$(STATEDIR)/virtual-host-tools.install:
	@$(call targetinfo)
	@$(call touch)
