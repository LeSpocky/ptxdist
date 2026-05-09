# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_JVISU) += jvisu

#
# Paths and names
#
JVISU_VERSION	:= 1.0.1
JVISU_SHA256	:= 3f71123e984296f59dddb073d4a39af3401b7b614c7ca04f61975a50ed450234
JVISU		:= JVisu-$(JVISU_VERSION)
JVISU_SUFFIX	:= tgz
JVISU_URL	:= http://www.pengutronix.de/software/jvisu/download/archive/$(JVISU).$(JVISU_SUFFIX)
JVISU_SOURCE	:= $(SRCDIR)/$(JVISU).$(JVISU_SUFFIX)
JVISU_DIR	:= $(BUILDDIR)/$(JVISU)


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------


JVISU_PATH	:= PATH=$(PTXCONF_SETUP_JAVA_SDK)/bin:$(CROSS_PATH)
JVISU_MAKE_ENV	:= \
	$(CROSS_ENV) \
	ANT_OPTS="-Dfile.encoding=iso-8859-1" \
	JAVA_HOME=$(PTXCONF_SETUP_JAVA_SDK)

$(STATEDIR)/jvisu.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/jvisu.compile:
	@$(call targetinfo)
	@$(call world/execute, JVISU, $(SHELL) ./build.sh jar)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/jvisu.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/jvisu.targetinstall:
	@$(call targetinfo)

	@$(call install_init, jvisu)
	@$(call install_fixup, jvisu,PRIORITY,optional)
	@$(call install_fixup, jvisu,SECTION,base)
	@$(call install_fixup, jvisu,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, jvisu,DESCRIPTION,missing)

ifdef PTXCONF_JVISU_APPLET
	# User: www; Group: www
	@$(call install_copy, jvisu, 12, 102, 0644, $(JVISU_DIR)/jar/jvisu.jar, $(PTXCONF_JVISU_APPLET_PATH)/jvisu.jar, n)
endif

	@$(call install_finish, jvisu)

	@$(call touch)

# vim: syntax=make
