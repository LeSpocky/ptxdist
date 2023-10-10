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
PACKAGES-$(PTXCONF_POKE) += poke

#
# Paths and names
#
POKE_VERSION	:= 3.3
POKE_MD5	:= 25461e6e9032fa4d3ed089576990c159
POKE		:= poke-$(POKE_VERSION)
POKE_SUFFIX	:= tar.gz
POKE_URL	:= $(call ptx/mirror, GNU, poke/$(POKE).$(POKE_SUFFIX))
POKE_SOURCE	:= $(SRCDIR)/$(POKE).$(POKE_SUFFIX)
POKE_DIR	:= $(BUILDDIR)/$(POKE)
POKE_LICENSE	:= GPL-3.0-or-later
POKE_LICENSE_FILES := \
	file://COPYING;md5=d32239bcb673463ab874e80d47fae504 \
	file://jitter/COPYING;md5=d32239bcb673463ab874e80d47fae504

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

POKE_CONF_TOOL	:= autoconf
POKE_CONF_OPT	:=  \
	$(CROSS_AUTOCONF_USR) \
	--enable-threads=posix \
	--disable-rpath \
	--enable-curses \
	--disable-nls \
	--disable-pvm-profiling \
	--disable-libnbd \
	--enable-hserver \
	--$(call ptx/endis, PTXDIST_Y2038)-year2038 \
	--$(call ptx/endis, PTXCONF_GLOBAL_LARGE_FILE)-largefile \
	--with-libreadline-prefix="$(PTXDIST_SYSROOT_TARGET)/usr" \
	--with-jitter-dispatch=best \
	--without-vimdir \
	--without-lispdir

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/poke.targetinstall:
	@$(call targetinfo)

	@$(call install_init, poke)
	@$(call install_fixup, poke,PRIORITY,optional)
	@$(call install_fixup, poke,SECTION,base)
	@$(call install_fixup, poke,AUTHOR,"Alexander Dahl <ada@thorsis.com>")
	@$(call install_fixup, poke,DESCRIPTION,missing)

	@$(call install_lib, poke, 0, 0, 0644, libpoke)
	@$(call install_copy, poke, 0, 0, 0755, -, /usr/bin/poke)
	@$(call install_tree, poke, 0, 0, -,  /usr/share/poke)

	@$(call install_finish, poke)

	@$(call touch)

# vim: ft=make noet tw=72 ts=8 sw=8
