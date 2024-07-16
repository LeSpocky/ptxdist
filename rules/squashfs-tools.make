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
SQUASHFS_TOOLS_VERSION	:= 4.6.1
SQUASHFS_TOOLS_MD5	:= db23a40fa0dc54b4d6d225fb20ee6555
SQUASHFS_TOOLS		:= squashfs$(SQUASHFS_TOOLS_VERSION)
SQUASHFS_TOOLS_SUFFIX	:= tar.gz
SQUASHFS_TOOLS_URL	:= $(call ptx/mirror, SF, squashfs/$(SQUASHFS_TOOLS).$(SQUASHFS_TOOLS_SUFFIX))
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
