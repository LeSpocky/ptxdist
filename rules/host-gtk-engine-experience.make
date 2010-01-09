# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GTK_ENGINE_EXPERIENCE) += host-gtk-engine-experience

#
# Paths and names
#
HOST_GTK_ENGINE_EXPERIENCE_DIR	= $(HOST_BUILDDIR)/$(GTK_ENGINE_EXPERIENCE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-gtk-engine-experience.get: $(STATEDIR)/gtk-engine-experience.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_GTK_ENGINE_EXPERIENCE_PATH	:= PATH=$(HOST_PATH)
HOST_GTK_ENGINE_EXPERIENCE_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_GTK_ENGINE_EXPERIENCE_AUTOCONF	:= $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-gtk-engine-experience_clean:
	rm -rf $(STATEDIR)/host-gtk-engine-experience.*
	rm -rf $(HOST_GTK_ENGINE_EXPERIENCE_DIR)

# vim: syntax=make
