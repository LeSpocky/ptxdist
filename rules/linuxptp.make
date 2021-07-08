# -*-makefile-*-
#
# Copyright (C) 2015 by Steffen Trumtrar <s.trumtrar@pengutronix.de>
#           (C) 2016 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LINUXPTP) += linuxptp

#
# Paths and names
#
LINUXPTP_VERSION	:= 3.1.1
LINUXPTP_MD5		:= 3b79ab5e77c5b5cf06bc1c8350d405bb
LINUXPTP		:= linuxptp-$(LINUXPTP_VERSION)
LINUXPTP_SUFFIX		:= tgz
LINUXPTP_URL		:= $(call ptx/mirror, SF, linuxptp/$(LINUXPTP).$(LINUXPTP_SUFFIX))
LINUXPTP_SOURCE		:= $(SRCDIR)/$(LINUXPTP).$(LINUXPTP_SUFFIX)
LINUXPTP_DIR		:= $(BUILDDIR)/$(LINUXPTP)
LINUXPTP_LICENSE	:= GPL-2.0-or-later
LINUXPTP_LICENSE_FILES	:= \
	file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
	file://version.c;startline=6;endline=14;md5=89ff91d940b4bc09b6de0300b34a888f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LINUXPTP_CONF_TOOL	:= NO

LINUXPTP_MAKE_ENV	:= \
	$(CROSS_ENV) \
	CROSS_COMPILE=$(COMPILER_PREFIX) \
	KBUILD_OUTPUT=$(PTXDIST_SYSROOT_TOOLCHAIN)

LINUXPTP_MAKE_OPT	:= \
	prefix=/usr

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

LINUXPTP_INSTALL_OPT	:= \
	prefix=/usr \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/linuxptp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, linuxptp)
	@$(call install_fixup, linuxptp,PRIORITY,optional)
	@$(call install_fixup, linuxptp,SECTION,base)
	@$(call install_fixup, linuxptp,AUTHOR,"Steffen Trumtrar <s.trumtrar@pengutronix.de>")
	@$(call install_fixup, linuxptp,DESCRIPTION,missing)

	@$(call install_copy, linuxptp, 0, 0, 0755, -, /usr/sbin/ptp4l)
	@$(call install_copy, linuxptp, 0, 0, 0755, -, /usr/sbin/phc2sys)
	@$(call install_copy, linuxptp, 0, 0, 0755, -, /usr/sbin/pmc)
	@$(call install_copy, linuxptp, 0, 0, 0755, -, /usr/sbin/hwstamp_ctl)
	@$(call install_copy, linuxptp, 0, 0, 0755, -, /usr/sbin/phc_ctl)
	@$(call install_copy, linuxptp, 0, 0, 0755, -, /usr/sbin/nsm)
	@$(call install_copy, linuxptp, 0, 0, 0755, -, /usr/sbin/timemaster)

ifdef PTXCONF_LINUXPTP_SYSTEMD_SERVICE
	@$(call install_alternative, linuxptp, 0, 0, 0644, /usr/lib/systemd/system/ptp4l.service)
	@$(call install_alternative, linuxptp, 0, 0, 0644, /usr/lib/systemd/system/phc2sys.service)

	@$(call install_link, linuxptp, ../ptp4l.service, \
		/usr/lib/systemd/system/multi-user.target.wants/ptp4l.service)

ifdef PTXCONF_LINUXPTP_PHC2SYS_SYSTEMD_SERVICE
	@$(call install_link, linuxptp, ../phc2sys.service, \
		/usr/lib/systemd/system/multi-user.target.wants/phc2sys.service)
endif
endif

	@$(call install_finish, linuxptp)

	@$(call touch)

# vim: syntax=make
