# -*-makefile-*-
#
# Copyright (C) 2018 Florian Bäuerle <florian.baeuerle@allegion.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

world/install-fonts = \
	DIR=$($(strip $(1)_DIR)); \
	PKGDIR=$($(strip $(1)_PKGDIR)); \
	PKGFONTDIR=$${PKGDIR}$($(strip $(1)_FONTDIR)); \
	FILTER=$(strip $(2)); \
	rm -rf $($(1)_PKGDIR) && \
	install -m 755 -d $${PKGFONTDIR} && \
	find $${DIR} -name "$${FILTER}" | \
		while read file; do \
			install -m 644 $${file} $${PKGFONTDIR} && \
			if [ "$(PTXCONF_XORG_FONTS_QT4_LINKS)" = "y" ]; then \
				name=$$(basename $${file}) && \
				install -m 755 -d $${PKGDIR}/usr/lib/fonts && \
				ln -s ../../..$($(strip $(1)_FONTDIR))/$${name} \
					$${PKGDIR}/usr/lib/fonts/$${name} || break; \
			fi; \
		done && \
	mkfontdir $${PKGFONTDIR} && \
	mkfontscale $${PKGFONTDIR}

# vim: syntax=make
