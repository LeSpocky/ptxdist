# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#                       Pengutronix <info@pengutronix.de>, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBPNG125) += libpng125

#
# Paths and names
#
LIBPNG125_VERSION	= 1.2.8
LIBPNG125		= libpng-$(LIBPNG125_VERSION)-config
LIBPNG125_SUFFIX	= tar.gz
LIBPNG125_URL		= $(PTXCONF_SETUP_SFMIRROR)/libpng/$(LIBPNG125).$(LIBPNG125_SUFFIX)
LIBPNG125_SOURCE	= $(SRCDIR)/$(LIBPNG125).$(LIBPNG125_SUFFIX)
LIBPNG125_DIR		= $(BUILDDIR)/$(LIBPNG125)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libpng125_get: $(STATEDIR)/libpng125.get

$(STATEDIR)/libpng125.get: $(libpng125_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBPNG125_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBPNG125_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libpng125_extract: $(STATEDIR)/libpng125.extract

$(STATEDIR)/libpng125.extract: $(libpng125_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBPNG125_DIR))
	@$(call extract, $(LIBPNG125_SOURCE))
	@$(call patchin, $(LIBPNG125))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libpng125_prepare: $(STATEDIR)/libpng125.prepare

LIBPNG125_PATH	   = PATH=$(CROSS_PATH)
LIBPNG125_ENV      = $(CROSS_ENV)

LIBPNG125_AUTOCONF =  $(CROSS_AUTOCONF_USR)
# FIXME: this should be fixed upstream, the package doesn't take care of
# DESTDIR. When fixed, the following option shouldn't be needed any
# more.  
LIBPNG125_AUTOCONF += --with-pkgconfigdir=$(SYSROOT)/lib

$(STATEDIR)/libpng125.prepare: $(libpng125_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBPNG125_BUILDDIR))
	@echo "FIXME: broken autoconf, see .make file"
	cd $(LIBPNG125_DIR) && \
		$(LIBPNG125_PATH) $(LIBPNG125_ENV) \
		./configure $(LIBPNG125_AUTOCONF)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libpng125_compile: $(STATEDIR)/libpng125.compile

$(STATEDIR)/libpng125.compile: $(libpng125_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBPNG125_DIR) && $(LIBPNG125_PATH) $(LIBPNG125_ENV) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libpng125_install: $(STATEDIR)/libpng125.install

$(STATEDIR)/libpng125.install: $(libpng125_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBPNG125)
# and now the ugly part
#	cd $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/libpng12 && \
#		ln -s ../zlib.h .
#	cd $(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/include/libpng12 && \
#		ln -s ../zconf.h .
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libpng125_targetinstall: $(STATEDIR)/libpng125.targetinstall

$(STATEDIR)/libpng125.targetinstall: $(libpng125_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,libpng125)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(LIBPNG125_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, \
		$(LIBPNG125_DIR)/.libs/libpng12.so.0.0.0, \
		/usr/lib/libpng12.so.0.0.0)
	@$(call install_link, libpng12.so.0.0.0, /usr/lib/libpng12.so.0.0)
	@$(call install_link, libpng12.so.0.0.0, /usr/lib/libpng12.so.0)

	@$(call install_copy, 0, 0, 0644, \
		$(LIBPNG125_DIR)/.libs/libpng.so.3.0.0, \
		/usr/lib/libpng.so.3.0.0)
	@$(call install_link, libpng.so.3.0.0, /usr/lib/libpng.so.3.0)
	@$(call install_link, libpng.so.3.0.0, /usr/lib/libpng.so.3)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libpng125_clean:
	rm -rf $(STATEDIR)/libpng125.*
	rm -rf $(IMAGEDIR)/libpng125_*
	rm -rf $(LIBPNG125_DIR)

# vim: syntax=make
