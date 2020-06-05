# -*-makefile-*-
#
# Copyright (C) 2004 by Robert Schwebel
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GNUPLOT) += gnuplot

#
# Paths and names
#
GNUPLOT_VERSION	:= 4.6.7
GNUPLOT_MAJ_VER := $(basename $(GNUPLOT_VERSION))
GNUPLOT_MD5	:= fbcb4715acf228fcd2957f9d218b9167
GNUPLOT		:= gnuplot-$(GNUPLOT_VERSION)
GNUPLOT_SUFFIX	:= tar.gz
GNUPLOT_URL	:= $(call ptx/mirror, SF, gnuplot/$(GNUPLOT).$(GNUPLOT_SUFFIX))
GNUPLOT_SOURCE	:= $(SRCDIR)/$(GNUPLOT).$(GNUPLOT_SUFFIX)
GNUPLOT_DIR	:= $(BUILDDIR)/$(GNUPLOT)
GNUPLOT_LICENSE	:= gnuplot
GNUPLOT_LICENSE_FILES	:= file://Copyright;md5=243a186fc2fd3b992125d60d5b1bab8f


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GNUPLOT_PATH	:= PATH=$(CROSS_PATH)
GNUPLOT_ENV	:= $(CROSS_ENV)

#
# autoconf
#
GNUPLOT_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	--disable-history-file \
	--$(call ptx/endis, PTXCONF_GNUPLOT_X)-mouse \
	--disable-x11-mbfonts \
	--disable-x11-external \
	--disable-volatile-data \
	--disable-raise-console \
	--disable-objects \
	--disable-macros \
	--disable-h3d-quadtree \
	--disable-h3d-gridbox \
	--disable-wxwidgets \
	--enable-backwards-compatibility \
	--disable-stats \
	--disable-qt \
	--without-lispdir \
	--without-latex \
	--without-kpsexpand \
	--$(call ptx/wwo, PTXCONF_GNUPLOT_X)-x \
	--without-lasergnu \
	--without-linux-vga \
	--without-ggi \
	--without-xmi \
	--with-readline=builtin \
	--$(call ptx/wwo, PTXCONF_GNUPLOT_GD)-gd \
	--$(call ptx/wwo, PTXCONF_GNUPLOT_PDF)-pdf \
	--without-lua \
	--without-cwdrc \
	--without-lisp-files \
	--without-row-help \
	--without-tutorial \
	--without-wx-config \
	--without-bitmap-terminals \
	--without-cairo

GNUPLOT_MAKE_OPT := -C src

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gnuplot.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gnuplot)
	@$(call install_fixup, gnuplot,PRIORITY,optional)
	@$(call install_fixup, gnuplot,SECTION,base)
	@$(call install_fixup, gnuplot,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, gnuplot,DESCRIPTION,missing)

	@$(call install_copy, gnuplot, 0, 0, 0755, -, /usr/bin/gnuplot)

ifdef PTXCONF_GNUPLOT_HELP
	@$(call install_copy, gnuplot, 0, 0, 0644, -, \
		/usr/share/gnuplot/$(GNUPLOT_MAJ_VER)/gnuplot.gih)
endif

ifdef PTXCONF_GNUPLOT_POSTSCRIPT
	@$(call install_tree, gnuplot, 0, 0, -, \
		/usr/share/gnuplot/$(GNUPLOT_MAJ_VER)/PostScript)
endif

ifdef PTXCONF_GNUPLOT_JS
	@$(call install_tree, gnuplot, 0, 0, -, \
		/usr/share/gnuplot/$(GNUPLOT_MAJ_VER)/js)
endif

ifdef PTXCONF_GNUPLOT_X
	@$(call install_copy, gnuplot, 0, 0, 0755, -, \
		/usr/libexec/gnuplot/$(GNUPLOT_MAJ_VER)/gnuplot_x11)
endif

	@$(call install_finish, gnuplot)

	@$(call touch)

# vim: syntax=make
