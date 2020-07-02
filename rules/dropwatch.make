# -*-makefile-*-
#
# Copyright (C) 2017 by Alexander Dahl <post@lespocky.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DROPWATCH) += dropwatch

#
# Paths and names
#
DROPWATCH_VERSION	:= 1.5.3
DROPWATCH_MD5		:= 64527bb669393e45b9b21f0b91c574c0
DROPWATCH		:= dropwatch-$(DROPWATCH_VERSION)
DROPWATCH_SUFFIX	:= tar.gz
DROPWATCH_URL		:= https://github.com/nhorman/dropwatch/archive/v$(DROPWATCH_VERSION).${DROPWATCH_SUFFIX}
DROPWATCH_SOURCE	:= $(SRCDIR)/$(DROPWATCH).$(DROPWATCH_SUFFIX)
DROPWATCH_DIR		:= $(BUILDDIR)/$(DROPWATCH)
DROPWATCH_LICENSE	:= GPL-2.0-or-later
DROPWATCH_LICENSE_FILES	:= file://COPYING;md5=eb723b61539feef013de476e68b5c50a

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
DROPWATCH_CONF_TOOL	:= autoconf
DROPWATCH_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--with-bfd

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dropwatch.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dropwatch)
	@$(call install_fixup, dropwatch,PRIORITY,optional)
	@$(call install_fixup, dropwatch,SECTION,base)
	@$(call install_fixup, dropwatch,AUTHOR,"Alexander Dahl <post@lespocky.de>")
	@$(call install_fixup, dropwatch,DESCRIPTION,missing)

	@$(call install_copy, dropwatch, 0, 0, 0755, -, /usr/bin/dropwatch)
	@$(call install_copy, dropwatch, 0, 0, 0755, -, /usr/bin/dwdump)

	@$(call install_finish, dropwatch)

	@$(call touch)

# vim: ft=make noet
