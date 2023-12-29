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
LIBCDIO_VERSION		:= 2.1.0
LIBCDIO_MD5		:= aa7629e8f73662a762f64c444b901055
LIBCDIO			:= libcdio-$(LIBCDIO_VERSION)
LIBCDIO_SUFFIX		:= tar.bz2
LIBCDIO_URL		:= $(call ptx/mirror, GNU, libcdio/$(LIBCDIO).$(LIBCDIO_SUFFIX))
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
	$(GLOBAL_LARGE_FILE_OPTION) \
	--$(call ptx/endis, PTXCONF_LIBCDIO_CXX)-cxx \
	--disable-example-progs \
	--without-cd-drive \
	--without-cd-info \
	--without-cdda-player \
	--without-cd-read \
	--without-iso-info \
	--without-iso-read

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
