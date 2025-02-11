# -*-makefile-*-
#
# Copyright (C) 2008 by Brandon Fosdick <bfosdick@dash.net>
# Copyright (C) 2025 by Lars Pedersen <lapeddk@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_INOTIFY_TOOLS) += inotify-tools

#
# Paths and names
#
INOTIFY_TOOLS_VERSION		:= 4.23.9.0
INOTIFY_TOOLS_MD5		:= 66ff78fc6595fefe715f505357b9714a
INOTIFY_TOOLS			:= inotify-tools-$(INOTIFY_TOOLS_VERSION)
INOTIFY_TOOLS_SUFFIX		:= tar.gz
INOTIFY_TOOLS_URL		:= https://github.com/inotify-tools/inotify-tools/archive/refs/tags/$(INOTIFY_TOOLS_VERSION).$(INOTIFY_TOOLS_SUFFIX)
INOTIFY_TOOLS_SOURCE		:= $(SRCDIR)/$(INOTIFY_TOOLS).$(INOTIFY_TOOLS_SUFFIX)
INOTIFY_TOOLS_DIR		:= $(BUILDDIR)/$(INOTIFY_TOOLS)
INOTIFY_TOOLS_LICENSE		:= GPL-2.0-only
INOTIFY_TOOLS_LICENSE_FILES	:= file://COPYING;md5=ac6c26e52aea428ee7f56dc2c56424c6

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
INOTIFY_TOOLS_CONF_TOOL	:= autoconf
INOTIFY_TOOLS_CONF_OPT	:= $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/inotify-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, inotify-tools)
	@$(call install_fixup, inotify-tools,PRIORITY,optional)
	@$(call install_fixup, inotify-tools,SECTION,base)
	@$(call install_fixup, inotify-tools,AUTHOR,"Lars Pedersen <lapeddk@gmail.com>")
	@$(call install_fixup, inotify-tools,DESCRIPTION,missing)

ifdef PTXCONF_INOTIFY_TOOLS_WAIT
	@$(call install_copy, inotify-tools, 0, 0, 0755, -, /usr/bin/inotifywait)
endif

ifdef PTXCONF_INOTIFY_TOOLS_WATCH
	@$(call install_copy, inotify-tools, 0, 0, 0755, -, /usr/bin/inotifywatch)
endif

ifdef PTXCONF_INOTIFY_TOOLS_FS_WAIT
	@$(call install_copy, inotify-tools, 0, 0, 0755, -, /usr/bin/fsnotifywait)
endif

ifdef PTXCONF_INOTIFY_TOOLS_FS_WATCH
	@$(call install_copy, inotify-tools, 0, 0, 0755, -, /usr/bin/fsnotifywatch)
endif

	@$(call install_lib,  inotify-tools, 0, 0, 0644, libinotifytools)

	@$(call install_finish, inotify-tools)

	@$(call touch)