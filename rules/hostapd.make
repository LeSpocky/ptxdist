# -*-makefile-*-
#
# Copyright (C) 2013 by Matthias Fend <matthias.fend@wolfvision.com>
#               2015 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HOSTAPD) += hostapd

#
# Paths and names
#
HOSTAPD_NAME	:= hostapd
HOSTAPD_VERSION	:= 2.10
HOSTAPD_MD5	:= 0be43e9e09ab94a7ebf82de0d1c57761
HOSTAPD		:= $(HOSTAPD_NAME)-$(HOSTAPD_VERSION)
HOSTAPD_SUFFIX	:= tar.gz
HOSTAPD_URL	:= http://w1.fi/releases/$(HOSTAPD).$(HOSTAPD_SUFFIX)
HOSTAPD_SOURCE	:= $(SRCDIR)/$(HOSTAPD).$(HOSTAPD_SUFFIX)
HOSTAPD_DIR	:= $(BUILDDIR)/$(HOSTAPD)
HOSTAPD_SUBDIR	:= $(HOSTAPD_NAME)
# Use '=' to delay $(shell ...) calls until this is needed
HOSTAPD_CONFIG	 = $(call ptx/get-alternative, config/hostapd, defconfig)
HOSTAPD_DOTCONFIG := $(BUILDDIR)/$(HOSTAPD)/$(HOSTAPD_SUBDIR)/.config
HOSTAPD_LICENSE	:= BSD-3-Clause
HOSTAPD_LICENSE_FILES := \
	file://COPYING;md5=5ebcb90236d1ad640558c3d3cd3035df \
	file://README;md5=e3d2f6c2948991e37c1ca4960de84747

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOSTAPD_MAKE_ENV := \
	$(CROSS_ENV) \
	BINDIR=/usr/sbin

$(STATEDIR)/hostapd.prepare:
	@$(call targetinfo)
#	# run 'make clean' as hostapd's build system does not recognize config changes
	@-$(HOSTAPD_MAKE_ENV) $(MAKE) -C $(HOSTAPD_DIR)/$(HOSTAPD_SUBDIR) clean
	@cp $(HOSTAPD_CONFIG) $(HOSTAPD_DOTCONFIG)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/hostapd.install:
	@$(call targetinfo)
	@$(call world/install, HOSTAPD)
	@install -v -m644 -D $(HOSTAPD_DIR)/hostapd/hostapd.conf \
		$(HOSTAPD_PKGDIR)/etc/hostapd/hostapd.conf
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/hostapd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, hostapd)
	@$(call install_fixup, hostapd,PRIORITY,optional)
	@$(call install_fixup, hostapd,SECTION,base)
	@$(call install_fixup, hostapd,AUTHOR,"Matthias Fend <matthias.fend@wolfvision.com>")
	@$(call install_fixup, hostapd,DESCRIPTION,missing)

	@$(call install_copy, hostapd, 0, 0, 0755, -, /usr/sbin/hostapd)
	@$(call install_alternative, hostapd, 0, 0, 0644, /etc/hostapd/hostapd.conf)

ifdef PTXCONF_HOSTAPD_SYSTEMD_UNIT
	@$(call install_alternative, hostapd, 0, 0, 0644, \
		/usr/lib/systemd/system/hostapd.service)
	@$(call install_link, hostapd, ../hostapd.service, \
		/lib/systemd/system/multi-user.target.wants/hostapd.service)
endif

	@$(call install_finish, hostapd)

	@$(call touch)

# vim: syntax=make
