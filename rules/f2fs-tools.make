# -*-makefile-*-
#
# Copyright (C) 2014 by Jon Ringle
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifndef PTXCONF_ENDIAN_BIG
PACKAGES-$(PTXCONF_F2FS_TOOLS) += f2fs-tools
endif

#
# Paths and names
#
F2FS_TOOLS_VERSION	:= 1.16.0
F2FS_TOOLS_SHA256	:= 208c7a07e95383fbd7b466b5681590789dcb41f41bf197369c41a95383b57c5e
F2FS_TOOLS		:= f2fs-tools-$(F2FS_TOOLS_VERSION)
F2FS_TOOLS_SUFFIX	:= tar.gz
F2FS_TOOLS_URL		:= https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/snapshot/$(F2FS_TOOLS).$(F2FS_TOOLS_SUFFIX)
F2FS_TOOLS_SOURCE	:= $(SRCDIR)/$(F2FS_TOOLS).$(F2FS_TOOLS_SUFFIX)
F2FS_TOOLS_DIR		:= $(BUILDDIR)/$(F2FS_TOOLS)
F2FS_TOOLS_LICENSE	:= GPL-2.0-or-later AND LGPL-2.1-or-later
F2FS_TOOLS_LICENSE_FILES := \
	file://COPYING;md5=362b4b2594cd362b874a97718faa51d3

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

F2FS_TOOLS_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_file__git=no

#
# autoconf
#
F2FS_TOOLS_CONF_TOOL	:= autoconf
F2FS_TOOLS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/wwo, PTXCONF_GLOBAL_SELINUX)-selinux \
	--with-blkid \
	--without-lzo2 \
	--without-lz4

F2FS_TOOLS_CFLAGS	:= \
	-std=gnu11

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/f2fs-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, f2fs-tools)
	@$(call install_fixup, f2fs-tools,PRIORITY,optional)
	@$(call install_fixup, f2fs-tools,SECTION,base)
	@$(call install_fixup, f2fs-tools,AUTHOR,"Jon Ringle")
	@$(call install_fixup, f2fs-tools,DESCRIPTION,missing)

	@$(call install_copy, f2fs-tools, 0, 0, 0755, -, /usr/sbin/mkfs.f2fs)
	@$(call install_copy, f2fs-tools, 0, 0, 0755, -, /usr/sbin/fsck.f2fs)

	@$(call install_lib, f2fs-tools, 0, 0, 0644, libf2fs)

	@$(call install_finish, f2fs-tools)

	@$(call touch)

# vim: syntax=make
