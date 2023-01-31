# -*-makefile-*-
#
# Copyright (C) 2011 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_SVGALIB) += svgalib

#
# Paths and names
#
SVGALIB_VERSION	:= 1.9.25
SVGALIB_MD5	:= 4dda7e779e550b7404cfe118f1d74222
SVGALIB		:= svgalib-$(SVGALIB_VERSION)
SVGALIB_SUFFIX	:= tar.gz
SVGALIB_URL	:= http://www.svgalib.org/$(SVGALIB).$(SVGALIB_SUFFIX)
SVGALIB_SOURCE	:= $(SRCDIR)/$(SVGALIB).$(SVGALIB_SUFFIX)
SVGALIB_DIR	:= $(BUILDDIR)/$(SVGALIB)
SVGALIB_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SVGALIB_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

SVGALIB_MAKE_ENV	:= \
	$(CROSS_ENV) \
	S_KERNELRELEASE=$(KERNEL_HEADER_VERSION)

$(STATEDIR)/svgalib.compile:
	@$(call targetinfo)

	@$(call compile, SVGALIB, sharedlib/libvga.so.$(SVGALIB_VERSION))
	@$(call compile, SVGALIB, sharedlib/libvgagl.so.$(SVGALIB_VERSION))
ifdef PTXCONF_SVGALIB_VGATEST
	@$(call compile, SVGALIB, -C demos vgatest)
endif

	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

SVGALIB_INSTALL_OPT	:= \
	prefix=$(SVGALIB_PKGDIR)/usr \
	datadir=$(SVGALIB_PKGDIR)/etc/vga \
	installheaders \
	installsharedlib \
	installconfig

$(STATEDIR)/svgalib.install:
	@$(call targetinfo)
	@$(call world/install, SVGALIB)
	@ln -sf libvga.so.$(SVGALIB_VERSION) $(SVGALIB_PKGDIR)/usr/lib/libvga.so.1
	@ln -sf libvgagl.so.$(SVGALIB_VERSION) $(SVGALIB_PKGDIR)/usr/lib/libvgagl.so.1
ifdef PTXCONF_SVGALIB_VGATEST
	@install -vd -m755 $(SVGALIB_PKGDIR)/usr/bin
	install -vD -m755  $(SVGALIB_DIR)/demos/vgatest $(SVGALIB_PKGDIR)/usr/bin/vgatest
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/svgalib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, svgalib)
	@$(call install_fixup, svgalib,PRIORITY,optional)
	@$(call install_fixup, svgalib,SECTION,base)
	@$(call install_fixup, svgalib,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, svgalib,DESCRIPTION,missing)

	@$(call install_lib, svgalib, 0, 0, 0644, libvga)
	@$(call install_lib, svgalib, 0, 0, 0644, libvgagl)

ifdef PTXCONF_SVGALIB_VGATEST
	@$(call install_copy, svgalib, 0, 0, 0755, -, /usr/bin/vgatest)
endif
	@$(call install_config, svgalib, 0, 0, 0644, /etc/vga/libvga.config)

	@$(call install_finish, svgalib)

	@$(call touch)

# vim: syntax=make
