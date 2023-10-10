# -*-makefile-*-
#
# Copyright (C) 2023 by Alexander Dahl <ada@thorsis.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBATOMIC_OPS) += libatomic_ops

#
# Paths and names
#
LIBATOMIC_OPS_VERSION	:= 7.8.0
LIBATOMIC_OPS_MD5	:= a7e51e8041c3e60c298c037b2789c3fa
LIBATOMIC_OPS		:= libatomic_ops-$(LIBATOMIC_OPS_VERSION)
LIBATOMIC_OPS_SUFFIX	:= tar.gz
LIBATOMIC_OPS_URL	:= https://github.com/ivmai/libatomic_ops/releases/download/v$(LIBATOMIC_OPS_VERSION)/$(LIBATOMIC_OPS).$(LIBATOMIC_OPS_SUFFIX)
LIBATOMIC_OPS_SOURCE	:= $(SRCDIR)/$(LIBATOMIC_OPS).$(LIBATOMIC_OPS_SUFFIX)
LIBATOMIC_OPS_DIR	:= $(BUILDDIR)/$(LIBATOMIC_OPS)
# quote from LICENSE:
#
# > Our intent is to make it easy to use libatomic_ops, in both free and
# > proprietary software.  Hence most of code (core library) that we
# > expect to be linked into a client application is covered by a MIT or
# > MIT-style license.
#
# > However, a few library routines (the gpl extension library) are
# > covered by the GNU General Public License.  These are put into a
# > separate library, libatomic_ops_gpl.a file.
LIBATOMIC_OPS_LICENSE	:= MIT AND Boehm-GC AND GPL-2.0-or-later
LIBATOMIC_OPS_LICENSE_FILES := \
	file://LICENSE;md5=5700d28353dfa2f191ca9b1bd707865e \
	file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBATOMIC_OPS_CONF_TOOL	:= autoconf
LIBATOMIC_OPS_CONF_OPT	:=  \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--disable-static \
	--disable-werror \
	--disable-assertions \
	--disable-atomic-intrinsics \
	--disable-gcov \
	--enable-gpl \
	--disable-docs

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libatomic_ops.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libatomic_ops)
	@$(call install_fixup, libatomic_ops,PRIORITY,optional)
	@$(call install_fixup, libatomic_ops,SECTION,base)
	@$(call install_fixup, libatomic_ops,AUTHOR,"Alexander Dahl <ada@thorsis.com>")
	@$(call install_fixup, libatomic_ops,DESCRIPTION,missing)

	@$(call install_lib, libatomic_ops, 0, 0, 0644, libatomic_ops)
	@$(call install_lib, libatomic_ops, 0, 0, 0644, libatomic_ops_gpl)

	@$(call install_finish, libatomic_ops)

	@$(call touch)

# vim: ft=make noet tw=72 ts=8 sw=8
