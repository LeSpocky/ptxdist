# -*-makefile-*-
#
# Copyright (C) 2020 by Steffen Trumtrar <s.trumtrar@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBURING) += liburing

#
# Paths and names
#
LIBURING_VERSION	:= 0.7
LIBURING_MD5		:= 5a045dbf48a7a3fac228d92a9a049424
LIBURING		:= liburing-$(LIBURING_VERSION)
LIBURING_SUFFIX		:= tar.gz
LIBURING_URL		:= https://github.com/axboe/liburing/archive/$(LIBURING).$(LIBURING_SUFFIX)
LIBURING_SOURCE		:= $(SRCDIR)/$(LIBURING).$(LIBURING_SUFFIX)
LIBURING_DIR		:= $(BUILDDIR)/$(LIBURING)
LIBURING_LICENSE	:= MIT
LIBURIGN_LICENSE_FILES	:= file://LICENSE;md5=f7c2200d2f904868b214103d0cbab6a9

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBURING_CONF_TOOL	:= NO
LIBURING_MAKE_ENV	:= $(CROSS_ENV)

ifdef PTXCONF_KERNEL_HEADER
LIBURING_CPPFLAGS	:= \
	-isystem $(KERNEL_HEADERS_INCLUDE_DIR)
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/liburing.targetinstall:
	@$(call targetinfo)

	@$(call install_init, liburing)
	@$(call install_fixup, liburing,PRIORITY,optional)
	@$(call install_fixup, liburing,SECTION,base)
	@$(call install_fixup, liburing,AUTHOR,"Steffen Trumtrar <s.trumtrar@pengutronix.de>")
	@$(call install_fixup, liburing,DESCRIPTION,missing)

	@$(call install_lib, liburing, 0, 0, 0644, liburing)

	@$(call install_finish, liburing)

	@$(call touch)

# vim: syntax=make
