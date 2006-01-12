# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# Paths and names
#

HOST_PACKAGES-$(PTXCONF_HOST_UTIL-LINUX) += host-util-linux

HOST_UTIL-LINUX_DIR	= $(HOST_BUILDDIR)/$(UTIL-LINUX)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Hosttool Extract
# ----------------------------------------------------------------------------

host-util-linux_extract: $(STATEDIR)/host-util-linux.extract

$(STATEDIR)/host-util-linux.extract: $(host-util-linux_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(UTIL-LINUX_DIR))
	@$(call extract, $(UTIL-LINUX_SOURCE), $(HOST_BUILDDIR))
	@$(call patchin, $(UTIL-LINUX),$(HOST_UTIL-LINUX_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Hosttool Prepare
# ----------------------------------------------------------------------------

host-util-linux_prepare: $(STATEDIR)/host-util-linux.prepare

$(STATEDIR)/host-util-linux.prepare: $(host-util-linux_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_UTIL-LINUX_DIR) && \
		$(HOSTCC_ENV) ./configure
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Hosttool Compile
# ----------------------------------------------------------------------------

host-util-linux_compile: $(STATEDIR)/host-util-linux.compile

$(STATEDIR)/host-util-linux.compile: $(host-util-linux_compile_deps_default)
	@$(call targetinfo, $@)

ifdef PTXCONF_UTLNX_SFDISK
	$(UTIL-LINUX_PATH) make -C $(HOST_UTIL-LINUX_DIR)/fdisk sfdisk
endif

ifdef PTXCONF_UTLNX_FDISK
	$(UTIL-LINUX_PATH) make -C $(HOST_UTIL-LINUX_DIR)/fdisk fdisk
endif

ifdef PTXCONF_UTLNX_CFFDISK
	$(UTIL-LINUX_PATH) make -C $(HOST_UTIL-LINUX_DIR)/fdisk cfdisk
endif

# ----------------------------------------------------------------------------
# Hosttool Install
# ----------------------------------------------------------------------------

host-util-linux_install: $(STATEDIR)/host-util-linux.install

$(STATEDIR)/host-util-linux.install: $(STATEDIR)/host-util-linux.compile
	@$(call targetinfo, $@)

	# FIXME: packetize

ifdef PTXCONF_UTLNX_SFDISK
	install -D $(HOST_UTIL-LINUX_DIR)/fdisk/sfdisk \
		$(PTXCONF_PREFIX)/sbin/sfdisk
endif

ifdef PTXCONF_UTLNX_FDISK
	install -D $(HOST_UTIL-LINUX_DIR)/fdisk/sfdisk \
		$(PTXCONF_PREFIX)/sbin/sfdisk
endif

ifdef PTXCONF_UTLNX_CFFDISK
	install -D $(HOST_UTIL-LINUX_DIR)/fdisk/sfdisk \
		$(PTXCONF_PREFIX)/sbin/sfdisk
endif

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Hosttool Clean
# ----------------------------------------------------------------------------

host-util-linux_clean:
	rm -rf $(STATEDIR)/host-util-linux.*
	rm -rf $(HOST_UTIL-LINUX_DIR)

# vim: syntax=make
