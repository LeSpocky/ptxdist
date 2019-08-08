# -*-makefile-*-
#
# Copyright (C) 2006 by Juergen Beisert
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FINDUTILS) += findutils

#
# Paths and names
#
FINDUTILS_VERSION	:= 4.6.0
FINDUTILS_MD5		:= 9936aa8009438ce185bea2694a997fc1
FINDUTILS		:= findutils-$(FINDUTILS_VERSION)
FINDUTILS_SUFFIX	:= tar.gz
FINDUTILS_URL		:= $(call ptx/mirror, GNU, findutils/$(FINDUTILS).$(FINDUTILS_SUFFIX))
FINDUTILS_SOURCE	:= $(SRCDIR)/$(FINDUTILS).$(FINDUTILS_SUFFIX)
FINDUTILS_DIR		:= $(BUILDDIR)/$(FINDUTILS)
FINDUTILS_LICENSE   := GPL-3.0-or-later
FINDUTILS_LICENSE_FILES   := \
	file://COPYING;md5=f27defe1e96c2e1ecd4e0c9be8967949 \
	file://find/finddata.c;startline=1;endline=17;md5=8762699fb923e458287765af95c28d5a


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FINDUTILS_PATH	:= PATH=$(CROSS_PATH)
FINDUTILS_ENV 	:= $(CROSS_ENV)
#
# where to place the database at runtime
#
FINDUTILS_DBASE_PATH := /var/lib/locate
#
# autoconf
#
FINDUTILS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--libexecdir=/usr/bin \
	--localstatedir=$(FINDUTILS_DBASE_PATH) \
	--disable-debug \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-threads=posix \
	--disable-assert \
	--disable-rpath \
	--disable-nls \
	--without-selinux

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/findutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, findutils)
	@$(call install_fixup, findutils,PRIORITY,optional)
	@$(call install_fixup, findutils,SECTION,base)
	@$(call install_fixup, findutils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, findutils,DESCRIPTION,missing)

ifdef PTXCONF_FINDUTILS_FIND
	@$(call install_copy, findutils, 0, 0, 0755, -, /usr/bin/find)
endif
ifdef PTXCONF_FINDUTILS_XARGS
	@$(call install_copy, findutils, 0, 0, 0755, -, /usr/bin/xargs)
endif
ifdef PTXCONF_FINDUTILS_DATABASE
	@$(call install_copy, findutils, 0, 0, 0755, -, /usr/bin/locate)
	@$(call install_copy, findutils, 0, 0, 0755, -, /usr/bin/updatedb,n)
	@$(call install_copy, findutils, 0, 0, 0755, -, /usr/bin/bigram)
	@$(call install_copy, findutils, 0, 0, 0755, -, /usr/bin/code)
	@$(call install_copy, findutils, 0, 0, 0755, -, /usr/bin/frcode)
	@$(call install_copy, findutils, 0, 0, 0755, $(FINDUTILS_DBASE_PATH))
endif
	@$(call install_finish, findutils)

	@$(call touch)

# vim: syntax=make
