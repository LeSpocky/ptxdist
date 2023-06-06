# -*-makefile-*-
#
# Copyright (C) 2005 by Sascha Hauer
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DIFFUTILS) += diffutils

#
# Paths and names
#
DIFFUTILS_VERSION	:= 3.10
DIFFUTILS_MD5		:= 2745c50f6f4e395e7b7d52f902d075bf
DIFFUTILS		:= diffutils-$(DIFFUTILS_VERSION)
DIFFUTILS_SUFFIX	:= tar.xz
DIFFUTILS_URL		:= $(call ptx/mirror, GNU, diffutils/$(DIFFUTILS).$(DIFFUTILS_SUFFIX))
DIFFUTILS_SOURCE	:= $(SRCDIR)/$(DIFFUTILS).$(DIFFUTILS_SUFFIX)
DIFFUTILS_DIR		:= $(BUILDDIR)/$(DIFFUTILS)
DIFFUTILS_LICENSE	:= GPL-3.0-or-later
DIFFUTILS_LICENSE_FILES	:= \
	file://COPYING;md5=d32239bcb673463ab874e80d47fae504 \
	file://src/diff.c;startline=1;endline=19;md5=22826ba1b6d00ff5a114342e7b46d1aa


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
DIFFUTILS_CONF_TOOL	:= autoconf
DIFFUTILS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-threads=posix \
	--disable-rpath \
	--disable-nls \
	--$(call ptx/endis, PTXDIST_Y2038)-year2038 \
	--without-libsigsegv

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/diffutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, diffutils)
	@$(call install_fixup, diffutils,PRIORITY,optional)
	@$(call install_fixup, diffutils,SECTION,base)
	@$(call install_fixup, diffutils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, diffutils,DESCRIPTION,missing)

ifdef PTXCONF_DIFFUTILS_DIFF
	@$(call install_copy, diffutils, 0, 0, 0755, -, /usr/bin/diff)
endif
ifdef PTXCONF_DIFFUTILS_DIFF3
	@$(call install_copy, diffutils, 0, 0, 0755, -, /usr/bin/diff3)
endif
ifdef PTXCONF_DIFFUTILS_SDIFF
	@$(call install_copy, diffutils, 0, 0, 0755, -, /usr/bin/sdiff)
endif
ifdef PTXCONF_DIFFUTILS_CMP
	@$(call install_copy, diffutils, 0, 0, 0755, -, /usr/bin/cmp)
endif

	@$(call install_finish, diffutils)

	@$(call touch)

# vim: syntax=make
