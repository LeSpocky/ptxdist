# -*-makefile-*-
#
# Copyright (C) 2009 by Luotao Fu <l.fu@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IOZONE) += iozone

#
# Paths and names
#
IOZONE_VERSION	:= 510
IOZONE_SHA256	:= 9284601c4665a1bb171307e8b9e1d62360d6598e4b0e7a5641320966d9a6a5f7
IOZONE		:= iozone3_$(IOZONE_VERSION)
IOZONE_SUFFIX	:= tar
IOZONE_URL	:= http://www.iozone.org/src/current/$(IOZONE).$(IOZONE_SUFFIX)
IOZONE_SOURCE	:= $(SRCDIR)/$(IOZONE).$(IOZONE_SUFFIX)
IOZONE_DIR	:= $(BUILDDIR)/$(IOZONE)
IOZONE_SUBDIR	:= src/current
IOZONE_LICENSE	:= Freeware

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

IOZONE_CONF_TOOL	:= NO

IOZONE_CFLAGS		:= \
	-DHAVE_PREADV \
	-DHAVE_PWRITEV \
	-std=gnu99

# parallel building is broken, multiple files are compiled in one target
IOZONE_MAKE_OPT		:= \
	$(CROSS_ENV_CC) \
	$(PARALLELMFLAGS_BROKEN) \
	linux

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/iozone.install:
	@$(call targetinfo)
	@$(call world/execute, IOZONE, \
		install -v -m 755 -t $(IOZONE_PKGDIR)/usr/bin \
			$(IOZONE_DIR)/src/current/{iozone$(comma)fileop})
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/iozone.targetinstall:
	@$(call targetinfo)

	@$(call install_init, iozone)
	@$(call install_fixup, iozone,PRIORITY,optional)
	@$(call install_fixup, iozone,SECTION,base)
	@$(call install_fixup, iozone,AUTHOR,"Luotao Fu <l.fu@pengutronix.de>")
	@$(call install_fixup, iozone,DESCRIPTION,missing)

	@$(call install_copy, iozone, 0, 0, 0755, -, /usr/bin/iozone)
	@$(call install_copy, iozone, 0, 0, 0755, -, /usr/bin/fileop)

	@$(call install_finish, iozone)

	@$(call touch)

# vim: syntax=make
