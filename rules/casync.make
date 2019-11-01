# -*-makefile-*-
#
# Copyright (C) 2019 by Ladislav Michl <ladis@linux-mips.org>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CASYNC) += casync

#
# Paths and names
#
CASYNC_VERSION	:= a8f6c841ccfe59ca8c68aad64df170b64042dce8
CASYNC_MD5	:= 38cf3c9e1be9ac60243031538024aa01
CASYNC		:= casync-$(CASYNC_VERSION)
CASYNC_SUFFIX	:= tar.gz
CASYNC_URL	:= https://github.com/systemd/casync/archive/$(CASYNC_VERSION).$(CASYNC_SUFFIX)
CASYNC_SOURCE	:= $(SRCDIR)/$(CASYNC).$(CASYNC_SUFFIX)
CASYNC_DIR	:= $(BUILDDIR)/$(CASYNC)
CASYNC_LICENSE	:= LGPL-2.1-or-later
CASYNC_LICENSE_FILES := \
	file://LICENSE.LGPL2.1;md5=4fbd65380cdd255951079008b364516c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CASYNC_CONF_TOOL	:= meson
CASYNC_CONF_OPT		:= \
	$(CROSS_MESON_USR) \
	-Dfuse=$(call ptx/truefalse,PTXCONF_CASYNC_FUSE) \
	-Dselinux=$(call ptx/truefalse,PTXCONF_GLOBAL_SELINUX) \
	-Dudev=$(call ptx/truefalse,PTXCONF_CASYNC_UDEV) \
	-Dudevrulesdir=/usr/lib/udev/rules.d \
	-Dman=false \
	-Dlibzstd=disabled \
	-Dliblzma=$(call ptx/endis,PTXCONF_CASYNC_LZMA)d \
	-Dlibz=$(call ptx/endis,PTXCONF_CASYNC_ZLIB)d \
	-Doss-fuzz=false \
	-Dllvm-fuzz=false \
	-Dbashcompletiondir=no

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/casync.targetinstall:
	@$(call targetinfo)

	@$(call install_init, casync)
	@$(call install_fixup, casync, PRIORITY, optional)
	@$(call install_fixup, casync, SECTION, base)
	@$(call install_fixup, casync, AUTHOR, "Ladislav Michl <ladis@linux-mips.org>")
	@$(call install_fixup, casync, DESCRIPTION, \
		"Content Addressable Data Synchronizer")

	@$(call install_copy, casync, 0, 0, 0755, -, /usr/bin/casync)
	@$(call install_copy, casync, 0, 0, 0755, -, /usr/lib/casync/protocols/casync-http)
	@$(call install_link, casync, casync-http, /usr/lib/casync/protocols/casync-https)
	@$(call install_link, casync, casync-http, /usr/lib/casync/protocols/casync-ftp)
	@$(call install_link, casync, casync-http, /usr/lib/casync/protocols/casync-sftp)

ifdef PTXCONF_CASYNC_UDEV
	@$(call install_alternative, casync, 0, 0, 0644, \
		/usr/lib/udev/rules.d/75-casync.rules)
endif

	@$(call install_finish, casync)

	@$(call touch)

# vim: syntax=make
