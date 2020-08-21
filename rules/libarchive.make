# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBARCHIVE) += libarchive

#
# Paths and names
#
LIBARCHIVE_VERSION	:= 3.3.2
LIBARCHIVE_MD5		:= 4583bd6b2ebf7e0e8963d90879eb1b27
LIBARCHIVE		:= libarchive-$(LIBARCHIVE_VERSION)
LIBARCHIVE_SUFFIX	:= tar.gz
LIBARCHIVE_URL		:= http://www.libarchive.org/downloads/$(LIBARCHIVE).$(LIBARCHIVE_SUFFIX)
LIBARCHIVE_SOURCE	:= $(SRCDIR)/$(LIBARCHIVE).$(LIBARCHIVE_SUFFIX)
LIBARCHIVE_DIR		:= $(BUILDDIR)/$(LIBARCHIVE)
LIBARCHIVE_LICENSE	:= BSD-2-Clause AND BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBARCHIVE_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_have_decl_EXT2_IOC_GETFLAGS=no \
	ac_cv_header_ext2fs_ext2_fs_h=no

#
# autoconf
#
LIBARCHIVE_CONF_TOOL	:= autoconf
LIBARCHIVE_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_LIBARCHIVE_BSDTAR)-bsdtar \
	--$(call ptx/endis, PTXCONF_LIBARCHIVE_BSDCAT)-bsdcat \
	--$(call ptx/endis, PTXCONF_LIBARCHIVE_BSDCPIO)-bsdcpio \
	--disable-rpath \
	--enable-posix-regex-lib=libc \
	--disable-xattr \
	--disable-acl \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--with-zlib \
	--$(call ptx/wwo, PTXCONF_LIBARCHIVE_BZIP2)-bz2lib \
	--without-iconv \
	--without-lz4 \
	--$(call ptx/wwo, PTXCONF_LIBARCHIVE_LZMA)-lzma \
	--without-lzo2 \
	--without-cng \
	--without-nettle \
	--without-openssl \
	--without-xml2 \
	--without-expat

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libarchive.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libarchive)
	@$(call install_fixup, libarchive,PRIORITY,optional)
	@$(call install_fixup, libarchive,SECTION,base)
	@$(call install_fixup, libarchive,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libarchive,DESCRIPTION,missing)

	@$(call install_lib, libarchive, 0, 0, 0644, libarchive)
ifdef PTXCONF_LIBARCHIVE_BSDTAR
	@$(call install_copy, libarchive, 0, 0, 0755, -, /usr/bin/bsdtar)
endif
ifdef PTXCONF_LIBARCHIVE_BSDCAT
	@$(call install_copy, libarchive, 0, 0, 0755, -, /usr/bin/bsdcat)
endif
ifdef PTXCONF_LIBARCHIVE_BSDCPIO
	@$(call install_copy, libarchive, 0, 0, 0755, -, /usr/bin/bsdcpio)
endif

	@$(call install_finish, libarchive)

	@$(call touch)

# vim: syntax=make
