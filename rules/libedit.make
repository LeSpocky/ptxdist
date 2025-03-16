# -*-makefile-*-
#
# Copyright (C) 2009 by Erwin Rol
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBEDIT) += libedit

#
# Paths and names
#
LIBEDIT_VERSION	:= 20250104-3.1
LIBEDIT_MD5	:= 3b2c3c4ab30374bf975d69b5bcc220b6
LIBEDIT		:= libedit-$(LIBEDIT_VERSION)
LIBEDIT_SUFFIX	:= tar.gz
LIBEDIT_URL	:= http://www.thrysoee.dk/editline/$(LIBEDIT).$(LIBEDIT_SUFFIX)
LIBEDIT_SOURCE	:= $(SRCDIR)/$(LIBEDIT).$(LIBEDIT_SUFFIX)
LIBEDIT_DIR	:= $(BUILDDIR)/$(LIBEDIT)
LIBEDIT_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBEDIT_CONF_TOOL	:= autoconf
LIBEDIT_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-examples

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libedit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libedit)
	@$(call install_fixup, libedit,PRIORITY,optional)
	@$(call install_fixup, libedit,SECTION,base)
	@$(call install_fixup, libedit,AUTHOR,"Erwin Rol")
	@$(call install_fixup, libedit,DESCRIPTION,missing)

	@$(call install_lib, libedit, 0, 0, 0644, libedit)

	@$(call install_finish, libedit)

	@$(call touch)

# vim: syntax=make
