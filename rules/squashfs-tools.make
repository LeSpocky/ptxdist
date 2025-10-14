# -*-makefile-*-
#
# Copyright (C) 2010 by Erwin Rol
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SQUASHFS_TOOLS) += squashfs-tools

#
# Paths and names
#
SQUASHFS_TOOLS_VERSION	:= 4.7.2
SQUASHFS_TOOLS_MD5	:= b02b324f74605f3569f7e10b913dda0d
SQUASHFS_TOOLS		:= squashfs-tools-$(SQUASHFS_TOOLS_VERSION)
SQUASHFS_TOOLS_SUFFIX	:= tar.gz
SQUASHFS_TOOLS_URL	:= https://github.com/plougher/squashfs-tools/releases/download/$(SQUASHFS_TOOLS_VERSION)/$(SQUASHFS_TOOLS).$(SQUASHFS_TOOLS_SUFFIX)
SQUASHFS_TOOLS_SOURCE	:= $(SRCDIR)/$(SQUASHFS_TOOLS).$(SQUASHFS_TOOLS_SUFFIX)
SQUASHFS_TOOLS_DIR	:= $(BUILDDIR)/$(SQUASHFS_TOOLS)
SQUASHFS_TOOLS_SUBDIR	:= squashfs-tools
SQUASHFS_TOOLS_LICENSE	:= GPL-2.0-or-later
SQUASHFS_TOOLS_LICENSE_FILES := \
	file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SQUASHFS_TOOLS_MAKE_PAR := NO
SQUASHFS_TOOLS_MAKE_ENV := \
	LZ4_SUPPORT=0 \
	LZO_SUPPORT=0 \
	XZ_SUPPORT=0 \
	ZSTD_SUPPORT=$(call ptx/ifdef, PTXCONF_SQUASHFS_TOOLS_ZSTD_SUPPORT,1,0) \
	$(CROSS_ENV) \
	CONFIG=1 \
	USE_PREBUILT_MANPAGES=y

SQUASHFS_TOOLS_INSTALL_OPT := \
	INSTALL_DIR="$(SQUASHFS_TOOLS_PKGDIR)/usr/sbin" \
	INSTALL_MANPAGES_DIR="$(SQUASHFS_TOOLS_PKGDIR)/usr/local/man/man1" \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/squashfs-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  squashfs-tools)
	@$(call install_fixup, squashfs-tools,PRIORITY,optional)
	@$(call install_fixup, squashfs-tools,SECTION,base)
	@$(call install_fixup, squashfs-tools,AUTHOR,"Erwin Rol")
	@$(call install_fixup, squashfs-tools,DESCRIPTION,missing)


ifdef PTXCONF_SQUASHFS_TOOLS_MKSQUASHFS
	@$(call install_copy, squashfs-tools, 0, 0, 0755, -, /usr/sbin/mksquashfs)
endif
ifdef PTXCONF_SQUASHFS_TOOLS_UNSQUASHFS
	@$(call install_copy, squashfs-tools, 0, 0, 0755, -, /usr/sbin/unsquashfs)
endif

	@$(call install_finish, squashfs-tools)

	@$(call touch)

# vim: syntax=make
