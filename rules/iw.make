# -*-makefile-*-
#
# Copyright (C) 2012 by Jan Luebbe <jlu@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IW) += iw

#
# Paths and names
#
IW_VERSION	:= 5.4
IW_MD5		:= 0d8bd345449c14249e39ce4b1f09cd64
IW		:= iw-$(IW_VERSION)
IW_SUFFIX	:= tar.xz
IW_URL		:= https://www.kernel.org/pub/software/network/iw/$(IW).$(IW_SUFFIX)
IW_SOURCE	:= $(SRCDIR)/$(IW).$(IW_SUFFIX)
IW_DIR		:= $(BUILDDIR)/$(IW)
IW_LICENSE	:= ISC

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

IW_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

# use .nogit as the makefile tries to figure out a tag if it runs inside a git
# repo
IW_MAKE_ENV	:= \
	$(CROSS_ENV) \
	GIT_DIR="$(IW_DIR)/.nogit" \
	CFLAGS="$(CROSS_CPPFLAGS) -O2 -g"

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/iw.targetinstall:
	@$(call targetinfo)

	@$(call install_init, iw)
	@$(call install_fixup, iw,PRIORITY,optional)
	@$(call install_fixup, iw,SECTION,base)
	@$(call install_fixup, iw,AUTHOR,"Jan Luebbe <jlu@pengutronix.de>")
	@$(call install_fixup, iw,DESCRIPTION,missing)

	@$(call install_copy, iw, 0, 0, 0755, -, /usr/sbin/iw)

	@$(call install_finish, iw)

	@$(call touch)

# vim: syntax=make
