# -*-makefile-*-
#
# Copyright (C) 2014 by Alexander Dahl <post@lespocky.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBTAR) += libtar

#
# Paths and names
#
LIBTAR_VERSION	:= 1.2.20
LIBTAR_SHA256	:= 3152fc61cf03c82efbf99645596efdadba297eac3e85a52ae189902a072c9a16
LIBTAR		:= libtar-$(LIBTAR_VERSION)
LIBTAR_SUFFIX	:= tar.gz
LIBTAR_URL	:= git://repo.or.cz/libtar.git;tag=v$(LIBTAR_VERSION)
LIBTAR_SOURCE	:= $(SRCDIR)/$(LIBTAR).$(LIBTAR_SUFFIX)
LIBTAR_DIR	:= $(BUILDDIR)/$(LIBTAR)
LIBTAR_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#LIBTAR_CONF_ENV	:= $(CROSS_ENV)

#
# autoconf
#
LIBTAR_CONF_TOOL	:= autoconf
LIBTAR_CONF_OPT	:= $(CROSS_AUTOCONF_USR) \
	--disable-encap \
	--disable-epkg-install \
	--with-zlib=$(SYSROOT)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libtar.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libtar)
	@$(call install_fixup, libtar,PRIORITY,optional)
	@$(call install_fixup, libtar,SECTION,base)
	@$(call install_fixup, libtar,AUTHOR,"Alexander Dahl <post@lespocky.de>")
	@$(call install_fixup, libtar,DESCRIPTION,missing)

	@$(call install_lib, libtar, 0, 0, 0644, libtar)

	@$(call install_finish, libtar)

	@$(call touch)

# vim: ft=make noet
