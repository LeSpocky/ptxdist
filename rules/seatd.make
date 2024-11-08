# -*-makefile-*-
#
# Copyright (C) 2021 by Philipp Zabel <p.zabel@pengutronix.de>
#               2021 by Michael Tretter <m.tretter@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SEATD) += seatd

#
# Paths and names
#
SEATD_VERSION		:= 0.9.1
SEATD_MD5		:= 964a9c59cdfe39f9130508c274e8ae21
SEATD			:= seatd-$(SEATD_VERSION)
SEATD_SUFFIX		:= tar.gz
SEATD_URL		:= https://git.sr.ht/~kennylevinsen/seatd/archive/$(SEATD_VERSION).$(SEATD_SUFFIX)
SEATD_SOURCE		:= $(SRCDIR)/$(SEATD).$(SEATD_SUFFIX)
SEATD_DIR		:= $(BUILDDIR)/$(SEATD)
SEATD_LICENSE		:= MIT
SEATD_LICENSE_FILES	:= file://LICENSE;md5=715a99d2dd552e6188e74d4ed2914d5a


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
SEATD_CONF_TOOL	:= meson
SEATD_CONF_OPT	:=  \
	$(CROSS_MESON_USR) \
	-Ddefaultpath= \
	-Dexamples=disabled \
	-Dlibseat-builtin=disabled \
	-Dlibseat-logind=$(call ptx/ifdef,PTXCONF_SEATD_SYSTEMD_LOGIND,systemd,disabled) \
	-Dlibseat-seatd=$(call ptx/endis,PTXCONF_SEATD_SEATD)d \
	-Dman-pages=disabled \
	-Dserver=$(call ptx/endis,PTXCONF_SEATD_SEATD)d

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/seatd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, seatd)
	@$(call install_fixup, seatd,PRIORITY,optional)
	@$(call install_fixup, seatd,SECTION,base)
	@$(call install_fixup, seatd,AUTHOR,"Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, seatd,DESCRIPTION,missing)

	@$(call install_lib, seatd, 0, 0, 0644, libseat)

ifdef PTXCONF_SEATD_SEATD
	@$(call install_copy, seatd, 0, 0, 0755, -, /usr/bin/seatd)
	@$(call install_copy, seatd, 0, 0, 0755, -, /usr/bin/seatd-launch)
ifdef PTXCONF_SEATD_SEATD_SYSTEMD_UNIT
	@$(call install_alternative, seatd, 0, 0, 0644, \
		/usr/lib/systemd/system/seatd.service)
	@$(call install_link, seatd, ../seatd.service, \
		/usr/lib/systemd/system/multi-user.target.wants/seatd.service)
endif
endif

	@$(call install_finish, seatd)

	@$(call touch)

# vim: syntax=make
