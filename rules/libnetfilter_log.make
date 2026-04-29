# -*-makefile-*-
#
# Copyright (C) 2011 by Hans Kortenoeven <hans.kortenoeven@home.nl>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNETFILTER_LOG) += libnetfilter_log

#
# Paths and names
#
LIBNETFILTER_LOG_VERSION	:= 1.0.2
LIBNETFILTER_LOG_MD5		:= 12825abf68cfcc150a31ccb88ae9f42d
LIBNETFILTER_LOG		:= libnetfilter_log-$(LIBNETFILTER_LOG_VERSION)
LIBNETFILTER_LOG_SUFFIX		:= tar.bz2
LIBNETFILTER_LOG_URL		:= https://ftp.netfilter.org/pub/libnetfilter_log/$(LIBNETFILTER_LOG).$(LIBNETFILTER_LOG_SUFFIX)
LIBNETFILTER_LOG_SOURCE		:= $(SRCDIR)/$(LIBNETFILTER_LOG).$(LIBNETFILTER_LOG_SUFFIX)
LIBNETFILTER_LOG_DIR		:= $(BUILDDIR)/$(LIBNETFILTER_LOG)
LIBNETFILTER_LOG_LICENSE	:= GPL-2.0-or-later
LIBNETFILTER_LOG_LICENSE_FILES	:= \
	file://COPYING;md5=8ca43cbc842c2336e835926c2166c28b

#
# autoconf
#
LIBNETFILTER_LOG_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libnetfilter_log.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libnetfilter_log)
	@$(call install_fixup, libnetfilter_log,PRIORITY,optional)
	@$(call install_fixup, libnetfilter_log,SECTION,base)
	@$(call install_fixup, libnetfilter_log,AUTHOR,"Hans Kortenoeven <hans.kortenoeven@home.nl>")
	@$(call install_fixup, libnetfilter_log,DESCRIPTION,missing)

	@$(call install_lib, libnetfilter_log, 0, 0, 0644, libnetfilter_log)
	@$(call install_lib, libnetfilter_log, 0, 0, 0644, libnetfilter_log_libipulog)

	@$(call install_finish, libnetfilter_log)
	@$(call touch)

