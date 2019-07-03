# -*-makefile-*-
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_JSVC) += jsvc

#
# Paths and names
#
JSVC		:= jsvc
JSVC_VERSION	:= none
JSVC_SUFFIX	:= tar.gz
JSVC_DIR	:= $(BUILDDIR)/$(JSVC)-src

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/jsvc.extract: $(STATEDIR)/tomcat.extract
	@$(call targetinfo)
	@$(call clean, $(JSVC_DIR))
	cd $(BUILDDIR) && tar xf $(TOMCAT_DIR)/bin/$(JSVC).$(JSVC_SUFFIX)
	chmod +x $(JSVC_DIR)/configure
	@$(call patchin, JSVC, $(JSVC_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

JSVC_PATH	:= PATH=$(CROSS_PATH)
JSVC_ENV	:= $(CROSS_ENV)

#
# autoconf
#
JSVC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-java=$(PTXCONF_SETUP_JAVA_SDK)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/jsvc.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/jsvc.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  jsvc)
	@$(call install_fixup, jsvc,PRIORITY,optional)
	@$(call install_fixup, jsvc,SECTION,base)
	@$(call install_fixup, jsvc,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, jsvc,DESCRIPTION,missing)

	@$(call install_copy, jsvc, 0, 0, 0755, $(JSVC_DIR)/jsvc, /usr/bin/jsvc)

	@$(call install_finish, jsvc)

	@$(call touch)

# vim: syntax=make
