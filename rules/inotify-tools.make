# -*-makefile-*-
#
# Copyright (C) 2008 by Brandon Fosdick <bfosdick@dash.net>
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
INOTIFY_TOOLS_VERSION	:= 3.13
INOTIFY_TOOLS_MD5	:= 35d7178297390f18bae451e083362acf
INOTIFY_TOOLS		:= inotify-tools-$(INOTIFY_TOOLS_VERSION)
INOTIFY_TOOLS_SUFFIX	:= tar.gz
INOTIFY_TOOLS_URL	:= $(call ptx/mirror, SF, inotify-tools/$(INOTIFY_TOOLS).$(INOTIFY_TOOLS_SUFFIX))
INOTIFY_TOOLS_SOURCE	:= $(SRCDIR)/$(INOTIFY_TOOLS).$(INOTIFY_TOOLS_SUFFIX)
INOTIFY_TOOLS_DIR	:= $(BUILDDIR)/$(INOTIFY_TOOLS)
INOTIFY_TOOLS_LICENSE	:= GPL-2.0-only
INOTIFY_TOOLS_LICENSE_FILES	:= file://COPYING;md5=59530bdf33659b29e73d4adb9f9f6552

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

INOTIFY_TOOLS_PATH	:= PATH=$(CROSS_PATH)
INOTIFY_TOOLS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
INOTIFY_TOOLS_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/inotify-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, inotify-tools)
	@$(call install_fixup, inotify-tools,PRIORITY,optional)
	@$(call install_fixup, inotify-tools,SECTION,base)
	@$(call install_fixup, inotify-tools,AUTHOR,"Brandon Fosdick <bfosdick@dash.net>")
	@$(call install_fixup, inotify-tools,DESCRIPTION,missing)

	@$(call install_copy, inotify-tools, 0, 0, 0755, -, /usr/bin/inotifywait)
	@$(call install_lib,  inotify_tools, 0, 0, 0644, libinotifytools)

	@$(call install_finish, inotify-tools)

	@$(call touch)

# vim: syntax=make
