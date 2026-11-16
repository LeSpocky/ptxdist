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
PACKAGES-$(PTXCONF_CHECKPOLICY) += checkpolicy

#
# Paths and names
#
CHECKPOLICY_VERSION	:= $(SELINUX_VERSION)
CHECKPOLICY_SHA256	:= 9b81bfceef7fa9d02f9872e56a786f343dc58ef4b5713dce0d5c416e5b84cefa
CHECKPOLICY		:= checkpolicy-$(CHECKPOLICY_VERSION)
CHECKPOLICY_SUFFIX	:= tar.gz
CHECKPOLICY_URL		:= $(SELINUX_URL)/$(CHECKPOLICY).$(CHECKPOLICY_SUFFIX)
CHECKPOLICY_SOURCE	:= $(SRCDIR)/$(CHECKPOLICY).$(CHECKPOLICY_SUFFIX)
CHECKPOLICY_DIR		:= $(BUILDDIR)/$(CHECKPOLICY)
CHECKPOLICY_LICENSE	:= GPL-2.0-only AND LGPL-2.1-or-later
CHECKPOLICY_LICENSE_FILES	:= file://LICENSE;md5=393a5ca445f6965873eca0259a17f833

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CHECKPOLICY_CONF_TOOL	:= NO
CHECKPOLICY_MAKE_ENV	:= $(CROSS_ENV)
CHECKPOLICY_MAKE_OPT	:= \
	CFLAGS="-O2 -Wall -g"
CHECKPOLICY_INSTALL_OPT	:= \
	$(CHECKPOLICY_MAKE_OPT) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/checkpolicy.targetinstall:
	@$(call targetinfo)

	@$(call install_init, checkpolicy)
	@$(call install_fixup, checkpolicy,PRIORITY,optional)
	@$(call install_fixup, checkpolicy,SECTION,base)
	@$(call install_fixup, checkpolicy,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, checkpolicy,DESCRIPTION,missing)

	@$(call install_copy, checkpolicy, 0, 0, 0755, -, /usr/bin/checkpolicy)
	@$(call install_copy, checkpolicy, 0, 0, 0755, -, /usr/bin/checkmodule)

	@$(call install_finish, checkpolicy)

	@$(call touch)

# vim: syntax=make
