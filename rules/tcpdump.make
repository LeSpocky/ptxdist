# -*-makefile-*-
#
# Copyright (C) 2004-2009 by Robert Schwebel
# Copyright (C) 2016 Juergen Borleis
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TCPDUMP) += tcpdump

#
# Paths and names
#
TCPDUMP_VERSION	:= 4.9.2
TCPDUMP_MD5	:= 9bbc1ee33dab61302411b02dd0515576
TCPDUMP		:= tcpdump-$(TCPDUMP_VERSION)
TCPDUMP_SUFFIX	:= tar.gz
TCPDUMP_URL	:= http://www.tcpdump.org/release/$(TCPDUMP).$(TCPDUMP_SUFFIX)
TCPDUMP_SOURCE	:= $(SRCDIR)/$(TCPDUMP).$(TCPDUMP_SUFFIX)
TCPDUMP_DIR	:= $(BUILDDIR)/$(TCPDUMP)
TCPDUMP_LICENSE := BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

TCPDUMP_CONF_ENV	= \
	$(CROSS_ENV) \
	ac_cv_linux_vers=$(KERNEL_HEADER_VERSION_MAJOR) \
	td_cv_buggygetaddrinfo=no

#
# autoconf
#
TCPDUMP_CONF_TOOL	:= autoconf
TCPDUMP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-universal \
	--$(call ptx/endis,PTXCONF_TCPDUMP_SMB)-smb \
	--with-gcc \
	--without-smi \
	--without-sandbox-capsicum \
	--with-system-libpcap \
	--$(call ptx/wwo,PTXCONF_TCPDUMP_ENABLE_CRYPTO)-crypto \
	--$(call ptx/wwo,PTXCONF_TCPDUMP_ENABLE_LIBCAP_NG)-cap-ng

# FIXME: Unsupported switches yet
#  --with-user=USERNAME    drop privileges by default to USERNAME
#  --with-chroot=DIRECTORY when dropping privileges, chroot to DIRECTORY

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tcpdump.targetinstall:
	@$(call targetinfo)

	@$(call install_init, tcpdump)
	@$(call install_fixup, tcpdump,PRIORITY,optional)
	@$(call install_fixup, tcpdump,SECTION,base)
	@$(call install_fixup, tcpdump,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, tcpdump,DESCRIPTION,"TCP analyze tool")

	@$(call install_copy, tcpdump, 0, 0, 0755, -, /usr/sbin/tcpdump)

	@$(call install_finish, tcpdump)

	@$(call touch)

# vim: syntax=make
