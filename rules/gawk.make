# -*-makefile-*-
#
# Copyright (C) 2003 by Ixia Corporation, By Milan Bobde
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GAWK) += gawk

#
# Paths and names
#
GAWK_VERSION	:= 5.0.1
GAWK_MD5	:= f9db3f6715207c6f13719713abc9c707
GAWK		:= gawk-$(GAWK_VERSION)
GAWK_SUFFIX	:= tar.xz
GAWK_URL	:= $(call ptx/mirror, GNU, gawk/$(GAWK).$(GAWK_SUFFIX))
GAWK_SOURCE	:= $(SRCDIR)/$(GAWK).$(GAWK_SUFFIX)
GAWK_DIR	:= $(BUILDDIR)/$(GAWK)
GAWK_LICENSE	:= GPL-3.0-or-later
GAWK_LICENSE_FILES := \
	file://COPYING;md5=d32239bcb673463ab874e80d47fae504 \
	file://main.c;startline=5;endline=24;md5=f471bca08ffe28738729b5bfd1d6ae86

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GAWK_CONF_TOOL	:= autoconf
GAWK_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-silent-rules \
	--enable-lint \
	--enable-builtin-intdiv0 \
	--disable-mpfr \
	--disable-versioned-extension-dir \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-nls \
	--disable-rpath \
	--$(call ptx/endis, PTXCONF_GAWK_EXTENSIONS)-extensions

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gawk.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gawk)
	@$(call install_fixup, gawk, PRIORITY, optional)
	@$(call install_fixup, gawk, SECTION, base)
	@$(call install_fixup, gawk, AUTHOR, \
		"Carsten Schlote <schlote@konzeptpark.de>")
	@$(call install_fixup, gawk,DESCRIPTION, \
		"gawk - pattern scanning and processing language")

	@$(call install_copy, gawk, 0, 0, 0755, -, /usr/bin/gawk)
	@$(call install_link, gawk, gawk, /usr/bin/awk)

ifdef PTXCONF_GAWK_AWKLIB
	@$(call install_tree, gawk, 0, 0, -, /usr/libexec/awk)
endif
ifdef PTXCONF_GAWK_EXTENSIONS
	@$(call install_tree, gawk, 0, 0, -, /usr/lib/gawk)
endif

	@$(call install_finish, gawk)

	@$(call touch)

# vim: syntax=make
