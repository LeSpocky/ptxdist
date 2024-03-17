# -*-makefile-*-
#
# Copyright (C) 2014 by Jon Ringle <jringle@gridpoint.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_AUTOSSH) += autossh

#
# Paths and names
#
AUTOSSH_VERSION		:= 1.4g
AUTOSSH_MD5		:= 2b804bc1bf6d2f2afaa526d02df7c0a2
AUTOSSH			:= autossh-$(AUTOSSH_VERSION)
AUTOSSH_SUFFIX		:= tgz
AUTOSSH_URL		:= https://www.harding.motd.ca/autossh/$(AUTOSSH).$(AUTOSSH_SUFFIX)
AUTOSSH_SOURCE		:= $(SRCDIR)/$(AUTOSSH).$(AUTOSSH_SUFFIX)
AUTOSSH_DIR		:= $(BUILDDIR)/$(AUTOSSH)
AUTOSSH_LICENSE		:= custom
AUTOSSH_LICENSE_FILES	:= \
	file://autossh.c;startline=7;endline=22;md5=9ae0c9b04856148d77984ef58536732b

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# use ac_cv_path_ssh= because --with-ssh= is broken
AUTOSSH_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_path_ssh=/usr/bin/ssh

AUTOSSH_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/autossh.targetinstall:
	@$(call targetinfo)

	@$(call install_init, autossh)
	@$(call install_fixup, autossh,PRIORITY,optional)
	@$(call install_fixup, autossh,SECTION,base)
	@$(call install_fixup, autossh,AUTHOR,"Jon Ringle <jringle@gridpoint.com>")
	@$(call install_fixup, autossh,DESCRIPTION,missing)

	@$(call install_copy, autossh, 0, 0, 0755, -, /usr/bin/autossh)

	@$(call install_finish, autossh)

	@$(call touch)

# vim: syntax=make
