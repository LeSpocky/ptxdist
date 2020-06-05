# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
# 		2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBLIST) += liblist

#
# Paths and names
#
LIBLIST_VERSION	:= 1.0.3
LIBLIST_MD5	:= 2db72c0718f6ecb16077fec055638e9f
LIBLIST		:= liblist-$(LIBLIST_VERSION)
LIBLIST_SUFFIX	:= tar.gz
LIBLIST_URL	:= http://www.pengutronix.de/software/liblist/download/$(LIBLIST).$(LIBLIST_SUFFIX)
LIBLIST_SOURCE	:= $(SRCDIR)/$(LIBLIST).$(LIBLIST_SUFFIX)
LIBLIST_DIR	:= $(BUILDDIR)/$(LIBLIST)
LIBLIST_LICENSE	:= GPL-2.0-or-later
LIBLIST_LICENSE_FILES	:= file://src/list.c;startline=10;endline=22;md5=5ace59915d77ffe5be6f93a68f12a9c4

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBLIST_PATH	:= PATH=$(CROSS_PATH)
LIBLIST_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBLIST_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/liblist.targetinstall:
	@$(call targetinfo)

	@$(call install_init, liblist)
	@$(call install_fixup, liblist,PRIORITY,optional)
	@$(call install_fixup, liblist,SECTION,base)
	@$(call install_fixup, liblist,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, liblist,DESCRIPTION,missing)

	@$(call install_lib, liblist, 0, 0, 0644, libptxlist)

	@$(call install_finish, liblist)

	@$(call touch)

# vim: syntax=make
