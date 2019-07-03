# -*-makefile-*-
#
# Copyright (C) 2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PRELINK) += prelink

#
# Paths and names
#
PRELINK_VERSION	:= 0.0.20090925
PRELINK_MD5	:= ed90412ad4ee7f5b5e8fff3d6649e49b
PRELINK_SUFFIX	:= orig.tar.gz
PRELINK		:= prelink-$(PRELINK_VERSION)
PRELINK_TARBALL	:= prelink_$(PRELINK_VERSION).$(PRELINK_SUFFIX)
PRELINK_URL	:= $(call ptx/mirror, DEB, pool/main/p/prelink/$(PRELINK_TARBALL))
PRELINK_SOURCE	:= $(SRCDIR)/$(PRELINK_TARBALL)
PRELINK_DIR	:= $(BUILDDIR)/$(PRELINK)
PRELINK_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PRELINK_PATH	:= PATH=$(CROSS_PATH)
PRELINK_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
PRELINK_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/prelink.targetinstall:
	@$(call targetinfo)

	@$(call install_init, prelink)
	@$(call install_fixup, prelink,PRIORITY,optional)
	@$(call install_fixup, prelink,SECTION,base)
	@$(call install_fixup, prelink,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, prelink,DESCRIPTION,missing)

	@$(call install_alternative, prelink, 0, 0, 0644, /etc/prelink.conf)
	@$(call install_copy, prelink, 0, 0, 0755, -, /usr/sbin/prelink)

ifdef PTXCONF_PRELINK_RC_ONCE
	@$(call install_alternative, prelink, 0, 0, 0755, /etc/rc.once.d/prelink)
ifdef PTXCONF_PRELINK_SKIP_ON_NFSROOT
	@$(call install_replace, prelink, /etc/rc.once.d/prelink, @NFSSKIP@, yes)
else
	@$(call install_replace, prelink, /etc/rc.once.d/prelink, @NFSSKIP@, no)
endif
endif

	@$(call install_finish, prelink)

	@$(call touch)

# vim: syntax=make
