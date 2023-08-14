# -*-makefile-*-
#
# Copyright (C) 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSNDFILE) += libsndfile

#
# Paths and names
#
LIBSNDFILE_VERSION	:= 1.2.2
LIBSNDFILE_MD5		:= 04e2e6f726da7c5dc87f8cf72f250d04
LIBSNDFILE		:= libsndfile-$(LIBSNDFILE_VERSION)
LIBSNDFILE_SUFFIX	:= tar.xz
LIBSNDFILE_URL		:= https://github.com/libsndfile/libsndfile/releases/download/$(LIBSNDFILE_VERSION)/$(LIBSNDFILE).$(LIBSNDFILE_SUFFIX)
LIBSNDFILE_SOURCE	:= $(SRCDIR)/$(LIBSNDFILE).$(LIBSNDFILE_SUFFIX)
LIBSNDFILE_DIR		:= $(BUILDDIR)/$(LIBSNDFILE)
LIBSNDFILE_LICENSE	:= LGPL-2.1-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBSNDFILE_CONF_TOOL := autoconf
LIBSNDFILE_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-experimental \
	--disable-werror \
	--disable-cpu-clip \
	--disable-bow-docs \
	--disable-sqlite \
	--disable-alsa \
	--$(call ptx/endis,PTXCONF_LIBSNDFILE_EXT_LIBS)-external-libs \
	--disable-mpeg \
	--disable-octave \
	--enable-full-suite \
	--disable-test-coverage \
	--disable-ossfuzzers \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--without-mkoctfile \
	--without-octave-config

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

LIBSNDFILE_PROGS := \
	sndfile-cmp \
	sndfile-concat \
	sndfile-convert \
	sndfile-deinterleave \
	sndfile-info \
	sndfile-interleave \
	sndfile-metadata-get \
	sndfile-metadata-set \
	sndfile-play \
	sndfile-salvage

$(STATEDIR)/libsndfile.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsndfile)
	@$(call install_fixup, libsndfile,PRIORITY,optional)
	@$(call install_fixup, libsndfile,SECTION,base)
	@$(call install_fixup, libsndfile,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libsndfile,DESCRIPTION,missing)

	@$(call install_lib, libsndfile, 0, 0, 0644, libsndfile)

ifdef PTXCONF_LIBSNDFILE_TOOLS
	@$(foreach prog, $(LIBSNDFILE_PROGS), \
		$(call install_copy, libsndfile, 0, 0, 0755, -, \
			/usr/bin/$(prog))$(ptx/nl))
endif

	@$(call install_finish, libsndfile)

	@$(call touch)

# vim: syntax=make
