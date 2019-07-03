# -*-makefile-*-
#
# Copyright (C) 2007 by Marc Kleine-Budde <mkl@pengutronix.de>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONTS) += xorg-fonts

#
# Paths and names
#
XORG_FONTS_VERSION	:= 1.0.0
XORG_FONTS_DIR_INSTALL	:= $(BUILDDIR)/xorg-fonts-$(XORG_FONTS_VERSION)-install
XORG_FONTS_LICENSE	:= ignore

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-fonts.install:
	@$(call targetinfo)

	@if test -e $(XORG_FONTS_DIR_INSTALL); then \
		rm -rf $(XORG_FONTS_DIR_INSTALL); \
	fi
	@mkdir -p $(XORG_FONTS_DIR_INSTALL)

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-fonts.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install-post
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-fonts.targetinstall.post:
	@$(call targetinfo)

	@find $(XORG_FONTS_DIR_INSTALL) -mindepth 1 -type d | while read dir; do \
		echo $$dir;\
		case "$${dir}" in \
			*/[Ee]ncodings)	\
					if test -d "$${dir}/large"; then \
						elarge="-e ./large"; \
					fi; \
					pushd $${dir} > /dev/null; \
					mkfontscale -b -s -l -n -r -p $(XORG_FONTDIR)/encodings -e . $${elarge} $${dir}; \
					popd > /dev/null ;; \
			*/[Ss]peedo)	mkfontdir $${dir} ;; \
			*)		mkfontscale $${dir}; \
					mkfontdir $${dir} ;; \
		esac; \
	done

	@$(call install_init, xorg-fonts)
	@$(call install_fixup, xorg-fonts,PRIORITY,optional)
	@$(call install_fixup, xorg-fonts,SECTION,base)
	@$(call install_fixup, xorg-fonts,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xorg-fonts,DESCRIPTION,missing)

	@cd $(XORG_FONTS_DIR_INSTALL) && \
	find . -type f | while read file; do \
		$(call install_copy, xorg-fonts, 0, 0, 0644, \
			$(XORG_FONTS_DIR_INSTALL)/$$file, \
			$(XORG_FONTDIR)/$$file, n); \
	done
ifdef PTXCONF_XORG_FONTS_QT4_LINKS
	@cd $(XORG_FONTS_DIR_INSTALL) && \
	find . -type f | while read file; do \
		name=`basename $$file`; \
		$(call install_link, xorg-fonts, \
			../../..$(XORG_FONTDIR)/$$file, \
			/usr/lib/fonts/$$name); \
	done
endif

	@$(call install_finish, xorg-fonts)

	@$(call touch)

# vim: syntax=make
