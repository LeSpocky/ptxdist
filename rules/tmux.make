# -*-makefile-*-
#
# Copyright (C) 2012 by Bernhard Walle <bernhard@bwalle.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TMUX) += tmux

#
# Paths and names
#
TMUX_VERSION	:= 3.4
TMUX_MD5	:= f6e35f957f91af5bb07cb8449228f5cd
TMUX		:= tmux-$(TMUX_VERSION)
TMUX_SUFFIX	:= tar.gz
TMUX_URL	:= https://github.com/tmux/tmux/releases/download/$(TMUX_VERSION)/$(TMUX).$(TMUX_SUFFIX)
TMUX_SOURCE	:= $(SRCDIR)/$(TMUX).$(TMUX_SUFFIX)
TMUX_DIR	:= $(BUILDDIR)/$(TMUX)
TMUX_LICENSE	:= ISC

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
TMUX_CONF_TOOL	:= autoconf
TMUX_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-fuzzing \
	--disable-debug \
	--disable-static \
	--disable-utempter \
	--disable-utf8proc \
	--disable-systemd \
	--disable-cgroups \
	--disable-sixel

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tmux.targetinstall:
	@$(call targetinfo)

	@$(call install_init, tmux)
	@$(call install_fixup, tmux,PRIORITY,optional)
	@$(call install_fixup, tmux,SECTION,base)
	@$(call install_fixup, tmux,AUTHOR,"Bernhard Walle <bernhard@bwalle.de>")
	@$(call install_fixup, tmux,DESCRIPTION,missing)

	@$(call install_copy, tmux, 0, 0, 0755, -, /usr/bin/tmux)

	@$(call install_finish, tmux)

	@$(call touch)

# vim: syntax=make
