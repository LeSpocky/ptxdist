# -*-makefile-*-
#
# Copyright (C) 2024 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBATASMART) += libatasmart

#
# Paths and names
#
LIBATASMART_VERSION		:= 0.19
LIBATASMART_MD5			:= 9566992138a0fcf1e1ca1f84bf336a7e
LIBATASMART			:= libatasmart-$(LIBATASMART_VERSION)
LIBATASMART_SUFFIX		:= tar.gz
LIBATASMART_URL			:= git+https://git.0pointer.net/clone/libatasmart.git;tag=v$(LIBATASMART_VERSION)
LIBATASMART_SOURCE		:= $(SRCDIR)/$(LIBATASMART).$(LIBATASMART_SUFFIX)
LIBATASMART_DIR			:= $(BUILDDIR)/$(LIBATASMART)
LIBATASMART_LICENSE		:= LGPL-2.1-or-later
LIBATASMART_LICENSE_FILES	:= \
	file://LGPL;md5=2d5025d4aa3495befef8f17206a5b0a1

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBATASMART_CONF_TOOL	:= autoconf
LIBATASMART_CONF_OPT	:=  \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libatasmart.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libatasmart)
	@$(call install_fixup, libatasmart,PRIORITY,optional)
	@$(call install_fixup, libatasmart,SECTION,base)
	@$(call install_fixup, libatasmart,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libatasmart,DESCRIPTION,missing)

	@$(call install_lib, libatasmart, 0, 0, 0644, libatasmart)

	@$(call install_finish, libatasmart)

	@$(call touch)

# vim: syntax=make
