# -*-makefile-*-
#
# Copyright (C) 2026 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SHARED_MIME_INFO) += host-shared-mime-info

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
HOST_SHARED_MIME_INFO_CONF_TOOL	:= meson
HOST_SHARED_MIME_INFO_CONF_OPT	:=  \
	$(HOST_MESON_OPT) \
	-Dupdate-mimedb=false \
	-Dbuild-tools=true \
	-Dbuild-translations=false \
	-Dbuild-tests=false \
	-Dxdgmime-path=/bin/false

# vim: ft=make
