# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
# Copyright (C) 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_LTT
PACKAGES += ltt
endif

#
# Paths and names 
#
LTT_VERSION		= 0.9.5
LTT			= TraceToolkit-$(LTT_VERSION)
LTT_SUFFIX		= tgz
# FIXME: beat upstream for "a" syntax...
LTT_URL			= http://www.opersys.com/ftp/pub/LTT/$(LTT)a.$(LTT_SUFFIX)
LTT_SOURCE		= $(SRCDIR)/$(LTT)a.$(LTT_SUFFIX)
LTT_DIR			= $(BUILDDIR)/$(LTT)
LTT_BUILDDIR		= $(BUILDDIR)/$(LTT)-build

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ltt_get: $(STATEDIR)/ltt.get

ltt_get_deps = $(LTT_SOURCE)

$(STATEDIR)/ltt.get: $(ltt_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(LTT))
	touch $@

$(LTT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LTT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ltt_extract: $(STATEDIR)/ltt.extract

ltt_extract_deps =  $(STATEDIR)/ltt.get

$(STATEDIR)/ltt.extract: $(ltt_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LTT_DIR))
	@$(call extract, $(LTT_SOURCE))
	@$(call patchin, $(LTT))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ltt_prepare: $(STATEDIR)/ltt.prepare

LTT_PATH	=  PATH=$(CROSS_PATH)
LTT_ENV		=  $(CROSS_ENV)
LTT_ENV		+= ac_cv_func_setvbuf_reversed=no ltt_cv_have_mbstate_t=yes

LTT_AUTOCONF	=  $(CROSS_AUTOCONF)
LTT_AUTOCONF	+= --prefix=/usr
LTT_AUTOCONF	+= --with-gtk=no

#
# dependencies
#
ltt_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/ltt.extract 

$(STATEDIR)/ltt.prepare: $(ltt_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LTT_BUILDDIR))
	mkdir -p $(LTT_BUILDDIR)
	cd $(LTT_BUILDDIR) && \
		$(LTT_PATH) $(LTT_ENV) \
		$(LTT_DIR)/configure $(LTT_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ltt_compile: $(STATEDIR)/ltt.compile

ltt_compile_deps = $(STATEDIR)/ltt.prepare

$(STATEDIR)/ltt.compile: $(STATEDIR)/ltt.prepare 
	@$(call targetinfo, $@)

	$(LTT_PATH) make -C $(LTT_BUILDDIR)/LibUserTrace UserTrace.o
	$(LTT_PATH) make -C $(LTT_BUILDDIR)/LibUserTrace LDFLAGS="-static"
	$(LTT_PATH) make -C $(LTT_BUILDDIR)/Daemon LDFLAGS="-static"

	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ltt_install: $(STATEDIR)/ltt.install

ltt_install_deps = \
	$(STATEDIR)/ltt.compile \
	$(STATEDIR)/xchain-ltt.compile

$(STATEDIR)/ltt.install: $(ltt_install_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ltt_targetinstall: $(STATEDIR)/ltt.targetinstall

$(STATEDIR)/ltt.targetinstall: $(STATEDIR)/ltt.install
	@$(call targetinfo, $@)
	mkdir -p $(ROOTDIR)/usr/sbin

	install $(LTT_BUILDDIR)/Daemon/tracedaemon $(ROOTDIR)/usr/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/sbin/tracedaemon

	install $(LTT_DIR)/createdev.sh $(ROOTDIR)/usr/sbin/tracecreatedev
	cp $(LTT_DIR)/Daemon/Scripts/trace* $(ROOTDIR)/usr/sbin
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ltt_clean: 
	rm -rf $(STATEDIR)/ltt.* $(LTT_DIR)

# vim: syntax=make
