# -*-makefile-*-
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_LIBPCSCLITE) += host-system-libpcsclite

#
# Paths and names
#
HOST_SYSTEM_LIBPCSCLITE_VERSION	:= 0
HOST_SYSTEM_LIBPCSCLITE		:= system-libpcsclite
HOST_SYSTEM_LIBPCSCLITE_LICENSE	:= ignore

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_LIBPCSCLITE_PATH	:= PATH=$(subst $(PTXDIST_SYSROOT_HOST)/usr/bin:,,$(HOST_PATH))

$(STATEDIR)/host-system-libpcsclite.prepare:
	@$(call targetinfo)
	@$(HOST_SYSTEM_LIBPCSCLITE_PATH) pkg-config libpcsclite || \
		ptxd_bailout "system libpcsclite not found! \
	Please install libpcsclite-dev (debian)"
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-system-libpcsclite.install:
	@$(call targetinfo)
#	# import libpcsclite.pc directly into sysroot to avoid mangling
	@mkdir -p $(PTXDIST_SYSROOT_HOST)/usr/lib/pkgconfig/
	cp $(wildcard $(addsuffix /libpcsclite.pc,$(subst :,$(space),$(shell $(HOST_SYSTEM_LIBPCSCLITE_PATH) pkg-config --variable pc_path pkg-config)))) \
		$(PTXDIST_SYSROOT_HOST)/usr/lib/pkgconfig/
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/host-system-libpcsclite.clean:
	@$(call targetinfo)
	@$(call clean_pkg, HOST_SYSTEM_LIBPCSCLITE)
	@rm -vf $(PTXDIST_SYSROOT_HOST)/usr/lib/pkgconfig/libpcsclite.pc

# vim: syntax=make
