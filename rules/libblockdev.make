# -*-makefile-*-
#
# Copyright (C) 2024 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBBLOCKDEV) += libblockdev

#
# Paths and names
#
LIBBLOCKDEV_VERSION		:= 3.1.1
LIBBLOCKDEV_MD5			:= 28d43f2d6bff85245502a8c4c478c5a3
LIBBLOCKDEV			:= libblockdev-$(LIBBLOCKDEV_VERSION)
LIBBLOCKDEV_SUFFIX		:= tar.gz
LIBBLOCKDEV_URL			:= https://github.com/storaged-project/libblockdev/releases/download/3.1.1-1/$(LIBBLOCKDEV).$(LIBBLOCKDEV_SUFFIX)
LIBBLOCKDEV_SOURCE		:= $(SRCDIR)/$(LIBBLOCKDEV).$(LIBBLOCKDEV_SUFFIX)
LIBBLOCKDEV_DIR			:= $(BUILDDIR)/$(LIBBLOCKDEV)
LIBBLOCKDEV_LICENSE		:= LGPL-2.1-or-later
LIBBLOCKDEV_LICENSE_FILES	:= \
	file://LICENSE;md5=c07cb499d259452f324bb90c3067d85c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBBLOCKDEV_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_path_python3=$(PTXDIST_SYSROOT_HOST)/usr/lib/wrapper/$(SYSTEMPYTHON3)

#
# autoconf
#
LIBBLOCKDEV_CONF_TOOL	:= autoconf
LIBBLOCKDEV_CONF_OPT	:=  \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug \
	--disable-introspection \
	--disable-tests \
	--without-s390 \
	--with-python3 \
	--without-gtk-doc \
	--without-escrow \
	--without-tools \
	--with-nvme \
	--without-btrfs \
	--with-crypto \
	--without-dm \
	--with-loop \
	--without-lvm \
	--without-lvm_dbus \
	--with-mdraid \
	--without-mpath \
	--with-swap \
	--with-part \
	--with-fs \
	--without-nvdimm

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

LIBBLOCKDEV_MODULES	:= \
	crypto \
	fs \
	loop \
	mdraid \
	nvme \
	part \
	swap \
	utils

$(STATEDIR)/libblockdev.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libblockdev)
	@$(call install_fixup, libblockdev,PRIORITY,optional)
	@$(call install_fixup, libblockdev,SECTION,base)
	@$(call install_fixup, libblockdev,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libblockdev,DESCRIPTION,missing)

	@$(call install_lib, libblockdev, 0, 0, 0644, libblockdev)

	@$(foreach module,$(LIBBLOCKDEV_MODULES), \
		$(call install_lib, libblockdev, 0, 0, 0644, libbd_$(module))$(ptx/nl))

	@$(call install_finish, libblockdev)

	@$(call touch)

# vim: syntax=make
