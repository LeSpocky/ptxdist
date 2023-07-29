# -*-makefile-*-
#
# Copyright (C) 2021 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SYSTEMD_HWDB) += systemd-hwdb

SYSTEMD_HWDB_VERSION	:= 1
SYSTEMD_HWDB		:= systemd-hwdb-$(SYSTEMD_HWDB_VERSION)
SYSTEMD_HWDB_LICENSE	:= ignore

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/systemd-hwdb.install:
	@$(call targetinfo)
	@$(call world/execute, SYSTEMD_HWDB, \
		install -vd -m 755 $(SYSTEMD_HWDB_PKGDIR)/usr/lib/udev/hwdb.d)
	@$(call execute, SYSTEMD_HWDB, \
		cp $(SYSROOT)/usr/lib/udev/hwdb.d/* $(SYSTEMD_HWDB_PKGDIR)/usr/lib/udev/hwdb.d/)
	@$(call execute, SYSTEMD_HWDB, \
		$(PTXDIST_SYSROOT_HOST)/usr/bin/systemd-hwdb update --usr --root $(SYSTEMD_HWDB_PKGDIR))
#	# remove the files again, they are already in sysroot
	@$(call execute, SYSTEMD_HWDB, \
		rm -r $(SYSTEMD_HWDB_PKGDIR)/usr/lib/udev/hwdb.d)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/systemd-hwdb.targetinstall:
	@$(call targetinfo)

	@$(call install_init, systemd-hwdb)
	@$(call install_fixup,systemd-hwdb,PRIORITY,optional)
	@$(call install_fixup,systemd-hwdb,SECTION,base)
	@$(call install_fixup,systemd-hwdb,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup,systemd-hwdb,DESCRIPTION,missing)

	@$(call install_copy, systemd-hwdb, 0, 0, 0644, -, /usr/lib/udev/hwdb.bin)

	@$(call install_finish,systemd-hwdb)

	@$(call touch)

# vim: syntax=make
