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
PACKAGES-$(PTXCONF_LIBBYTESIZE) += libbytesize

#
# Paths and names
#
LIBBYTESIZE_VERSION		:= 2.10
LIBBYTESIZE_MD5			:= 2ed2ad2e44c4017f016e1ca55be83e62
LIBBYTESIZE			:= libbytesize-$(LIBBYTESIZE_VERSION)
LIBBYTESIZE_SUFFIX		:= tar.gz
LIBBYTESIZE_URL			:= https://github.com/storaged-project/libbytesize/releases/download/$(LIBBYTESIZE_VERSION)/$(LIBBYTESIZE).$(LIBBYTESIZE_SUFFIX)
LIBBYTESIZE_SOURCE		:= $(SRCDIR)/$(LIBBYTESIZE).$(LIBBYTESIZE_SUFFIX)
LIBBYTESIZE_DIR			:= $(BUILDDIR)/$(LIBBYTESIZE)
LIBBYTESIZE_LICENSE		:= LGPL-2.1-or-later
LIBBYTESIZE_LICENSE_FILES	:= \
	file://LICENSE;md5=c07cb499d259452f324bb90c3067d85c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBBYTESIZE_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_path_XGETTEXT=: \
	ac_cv_path_MSGFMT=: \
	ac_cv_path_MSGMERGE=: \
	ac_cv_path_python3=$(PTXDIST_SYSROOT_HOST)/usr/lib/wrapper/$(SYSTEMPYTHON3)

#
# autoconf
#
LIBBYTESIZE_CONF_TOOL	:= autoconf
LIBBYTESIZE_CONF_OPT	:=  \
	$(CROSS_AUTOCONF_USR) \
	--with-python3 \
	--without-gtk-doc \
	--without-tools

LIBBYTESIZE_MAKE_OPT	:= \
	-C src

LIBBYTESIZE_INSTALL_OPT	:= \
	-C src \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libbytesize.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libbytesize)
	@$(call install_fixup, libbytesize,PRIORITY,optional)
	@$(call install_fixup, libbytesize,SECTION,base)
	@$(call install_fixup, libbytesize,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libbytesize,DESCRIPTION,missing)

	@$(call install_lib, libbytesize, 0, 0, 0644, libbytesize)

	@$(call install_finish, libbytesize)

	@$(call touch)

# vim: syntax=make
