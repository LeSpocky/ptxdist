# -*-makefile-*-
#
# Copyright (C) 2008 by Luotao Fu <l.fu@pengutronix.de>
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GREP) += grep

#
# Paths and names
#
GREP_VERSION		:= 3.11
GREP_MD5		:= 7c9bbd74492131245f7cdb291fa142c0
GREP			:= grep-$(GREP_VERSION)
GREP_SUFFIX		:= tar.xz
GREP_URL		:= $(call ptx/mirror, GNU, grep/$(GREP).$(GREP_SUFFIX))
GREP_SOURCE		:= $(SRCDIR)/$(GREP).$(GREP_SUFFIX)
GREP_DIR		:= $(BUILDDIR)/$(GREP)
GREP_LICENSE		:= GPL-3.0-or-later
GREP_LICENSE_FILES	:= \
	file://COPYING;md5=1ebbd3e34237af26da5dc08a4e440464

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GREP_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_path_MSGFMT=: \
	ac_cv_path_GMSGFMT=: \
	ac_cv_path_XGETTEXT=:

#
# autoconf
#
GREP_CONF_TOOL	:= autoconf
GREP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-threads=posix \
	--disable-assert \
	--disable-rpath \
	--disable-nls \
	--$(call ptx/endis, PTXCONF_GREP_PCRE)-perl-regexp \
	--$(call ptx/endis, PTXDIST_Y2038)-year2038 \
	--with-libsigsegv \
	--without-included-regex \
	--with-packager \
	--with-packager-version \
	--with-packager-bug-reports


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/grep.targetinstall:
	@$(call targetinfo)

	@$(call install_init, grep)
	@$(call install_fixup, grep,PRIORITY,optional)
	@$(call install_fixup, grep,SECTION,base)
	@$(call install_fixup, grep,AUTHOR,"Luotao Fu <l.fu@pengutronix.de>")
	@$(call install_fixup, grep,DESCRIPTION,missing)

	@$(call install_copy, grep, 0, 0, 0755, -, /usr/bin/grep)

	@$(call install_finish, grep)

	@$(call touch)

# vim: syntax=make
