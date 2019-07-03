# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FAKE_OVERLAYFS) += fake-overlayfs

# dummy version for xpkg
FAKE_OVERLAYFS_VERSION	:= 1.0

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ifdef PTXCONF_FAKE_OVERLAYFS_VAR
FAKE_OVERLAYFS_BASE_DIRS += /var
endif
ifdef PTXCONF_FAKE_OVERLAYFS_VAR_LIB
FAKE_OVERLAYFS_BASE_DIRS += /var/lib
endif
ifdef PTXCONF_FAKE_OVERLAYFS_VAR_TMP
FAKE_OVERLAYFS_BASE_DIRS += /var/tmp
endif
ifdef PTXCONF_FAKE_OVERLAYFS_VAR_CACHE
FAKE_OVERLAYFS_BASE_DIRS += /var/cache
endif

FAKE_OVERLAYFS_DIRS = $(call remove_quotes, $(PTXCONF_FAKE_OVERLAYFS_OTHER)):$(subst $(space),:,$(FAKE_OVERLAYFS_BASE_DIRS))


$(STATEDIR)/fake-overlayfs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fake-overlayfs)
	@$(call install_fixup, fake-overlayfs,PRIORITY,optional)
	@$(call install_fixup, fake-overlayfs,SECTION,base)
	@$(call install_fixup, fake-overlayfs,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, fake-overlayfs,DESCRIPTION,missing)

	@$(call install_alternative, fake-overlayfs, 0, 0, 0755, \
		/usr/sbin/fake-overlayfs)
	@$(call install_replace, fake-overlayfs, /usr/sbin/fake-overlayfs, \
		@OVERLAY_DIRLIST@, $(FAKE_OVERLAYFS_DIRS))

ifdef PTXCONF_INITMETHOD_BBINIT
	@$(call install_alternative, fake-overlayfs, 0, 0, 0755, \
		/etc/init.d/fake-overlayfs)

ifneq ($(call remove_quotes,$(PTXCONF_FAKE_OVERLAYFS_BBINIT_LINK)),)
	@$(call install_link, fake-overlayfs, \
		../init.d/fake-overlayfs, \
		/etc/rc.d/$(PTXCONF_FAKE_OVERLAYFS_BBINIT_LINK))
endif
endif
ifdef PTXCONF_FAKE_OVERLAYFS_SYSTEMD
	@$(call install_alternative, fake-overlayfs, 0, 0, 0644, \
		/usr/lib/systemd/system/fake-overlayfs.service)
	@$(call install_link, fake-overlayfs, ../fake-overlayfs.service, \
		/usr/lib/systemd/system/sysinit.target.wants/fake-overlayfs.service)
endif

	@$(call install_finish, fake-overlayfs)

	@$(call touch)

# vim: syntax=make
