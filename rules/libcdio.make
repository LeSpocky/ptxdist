# -*-makefile-*-
#
# Copyright (C) 2023 by Ladislav Michl <ladis@linux-mips.org>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBCDIO) += libcdio

#
# Paths and names
#
LIBCDIO_VERSION		:= 2.2.0
LIBCDIO_MD5		:= 9364577aca7cbcdb5c01b7b1233b9fa4
LIBCDIO			:= libcdio-$(LIBCDIO_VERSION)
LIBCDIO_SUFFIX		:= tar.gz
LIBCDIO_URL		:= https://github.com/libcdio/libcdio/releases/download/$(LIBCDIO_VERSION)/$(LIBCDIO).$(LIBCDIO_SUFFIX)
LIBCDIO_SOURCE		:= $(SRCDIR)/$(LIBCDIO).$(LIBCDIO_SUFFIX)
LIBCDIO_DIR		:= $(BUILDDIR)/$(LIBCDIO)
LIBCDIO_LICENSE		:= GPL-3.0-or-later
LIBCDIO_LICENSE_FILES	:= \
	file://COPYING;md5=d32239bcb673463ab874e80d47fae504

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBCDIO_CONF_TOOL	:= autoconf
LIBCDIO_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_LIBCDIO_CXX)-cxx \
	--disable-cpp-progs \
	--disable-example-progs \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-rpath \
	--enable-joliet \
	--enable-rock \
	--disable-cddb \
	--disable-compatibility \
	--disable-vcd-info \
	--without-cd-drive \
	--without-cd-info \
	--without-cdda-player \
	--without-cd-read \
	--without-iso-info \
	--without-iso-read \
	--with-versioned-libs

# needed for lseek64() to be defined
LIBCDIO_CFLAGS	:= -D_LARGEFILE64_SOURCE

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

LIBCDIO_LIBS-y				:= libcdio libiso9660 libudf
LIBCDIO_LIBS-$(PTXCONF_LIBCDIO_CXX)	+= libcdio++ libiso9660++

$(STATEDIR)/libcdio.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libcdio)
	@$(call install_fixup, libcdio,PRIORITY,optional)
	@$(call install_fixup, libcdio,SECTION,base)
	@$(call install_fixup, libcdio,AUTHOR,"Ladislav Michl <ladis@linux-mips.org>")
	@$(call install_fixup, libcdio,DESCRIPTION,missing)

	@$(foreach lib, $(LIBCDIO_LIBS-y), \
		$(call install_lib, libcdio, 0, 0, 0644, $(lib))$(ptx/nl))

	@$(call install_finish, libcdio)

	@$(call touch)

# vim: syntax=make
