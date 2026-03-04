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
PACKAGES-$(PTXCONF_SHARED_MIME_INFO) += shared-mime-info

#
# Paths and names
#
SHARED_MIME_INFO_VERSION	:= 2.4
SHARED_MIME_INFO_MD5		:= aac56db912b7b12a04fb0018e28f2f36
SHARED_MIME_INFO		:= shared-mime-info-$(SHARED_MIME_INFO_VERSION)
SHARED_MIME_INFO_SUFFIX		:= tar.gz
SHARED_MIME_INFO_URL		:= https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/$(SHARED_MIME_INFO_VERSION)/$(SHARED_MIME_INFO).$(SHARED_MIME_INFO_SUFFIX)
SHARED_MIME_INFO_SOURCE		:= $(SRCDIR)/$(SHARED_MIME_INFO).$(SHARED_MIME_INFO_SUFFIX)
SHARED_MIME_INFO_DIR		:= $(BUILDDIR)/$(SHARED_MIME_INFO)
SHARED_MIME_INFO_LICENSE	:= unknown
SHARED_MIME_INFO_LICENSE_FILES	:=


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
SHARED_MIME_INFO_CONF_TOOL	:= meson
SHARED_MIME_INFO_CONF_OPT	:=  \
	$(CROSS_MESON_USR) \
	-Dupdate-mimedb=true \
	-Dbuild-tools=false \
	-Dbuild-translations=false \
	-Dbuild-tests=false \
	-Dxdgmime-path=/bin/false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/shared-mime-info.targetinstall:
	@$(call targetinfo)

	@$(call install_init, shared-mime-info)
	@$(call install_fixup, shared-mime-info,PRIORITY,optional)
	@$(call install_fixup, shared-mime-info,SECTION,base)
	@$(call install_fixup, shared-mime-info,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, shared-mime-info,DESCRIPTION,missing)

	@$(call install_copy, shared-mime-info, 0, 0, 0644, -, /usr/share/mime/mime.cache)

	@$(call install_finish, shared-mime-info)

	@$(call touch)

# vim: ft=make
