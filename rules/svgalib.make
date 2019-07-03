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

$(STATEDIR)/svgalib.install:
	@$(call targetinfo)
	mkdir -p $(SVGALIB_PKGDIR)/usr/lib
	cp "$(SVGALIB_DIR)/sharedlib/libvga.so.$(SVGALIB_VERSION)" "$(SVGALIB_PKGDIR)/usr/lib"
	ln -sf libvga.so.$(SVGALIB_VERSION) $(SVGALIB_PKGDIR)/usr/lib/libvga.so.1
	ln -sf libvga.so.$(SVGALIB_VERSION) $(SVGALIB_PKGDIR)/usr/lib/libvga.so
	cp "$(SVGALIB_DIR)/sharedlib/libvgagl.so.$(SVGALIB_VERSION)" "$(SVGALIB_PKGDIR)/usr/lib"
	ln -sf libvgagl.so.$(SVGALIB_VERSION) $(SVGALIB_PKGDIR)/usr/lib/libvgagl.so.1
	ln -sf libvgagl.so.$(SVGALIB_VERSION) $(SVGALIB_PKGDIR)/usr/lib/libvgagl.so
ifdef PTXCONF_SVGALIB_VGATEST
	mkdir -p $(SVGALIB_PKGDIR)/usr/bin
	cp "$(SVGALIB_DIR)/demos/vgatest" "$(SVGALIB_PKGDIR)/usr/bin/vgatest"
endif
	install -d $(SYSROOT)/include
	install $(SVGALIB_DIR)/include/vga.h $(SYSROOT)/include
	install $(SVGALIB_DIR)/include/vgamouse.h $(SYSROOT)/include
	install $(SVGALIB_DIR)/include/vgakeyboard.h $(SYSROOT)/include
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
