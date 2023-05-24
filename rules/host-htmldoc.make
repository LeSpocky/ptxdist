# -*-makefile-*-
#
# Copyright (C) 2023 by Roland Hieber <rhi@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_HTMLDOC) += host-htmldoc

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_HTMLDOC_CONF_TOOL	:= autoconf
HOST_HTMLDOC_CONF_OPT	:=  \
	$(HOST_AUTOCONF) \
	--disable-debug \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-ssl \
	--disable-gnutls \
	--disable-cdsassl \
	--disable-maintainer \
	--disable-sanitizer \
	--without-gui

# vim: syntax=make
