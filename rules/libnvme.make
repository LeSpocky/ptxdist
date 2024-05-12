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
PACKAGES-$(PTXCONF_LIBNVME) += libnvme

#
# Paths and names
#
LIBNVME_VERSION		:= 1.8
LIBNVME_MD5		:= ff72b83dc2ada1da0bd528570154eed3
LIBNVME			:= libnvme-$(LIBNVME_VERSION)
LIBNVME_SUFFIX		:= tar.gz
LIBNVME_URL		:= https://github.com/linux-nvme/libnvme/archive/refs/tags/v$(LIBNVME_VERSION).$(LIBNVME_SUFFIX)
LIBNVME_SOURCE		:= $(SRCDIR)/$(LIBNVME).$(LIBNVME_SUFFIX)
LIBNVME_DIR		:= $(BUILDDIR)/$(LIBNVME)
LIBNVME_LICENSE		:= LGPL-2.1-or-later AND GPL-2.0-or-later
LIBNVME_LICENSE_FILES	:= \
	file://COPYING;md5=4fbd65380cdd255951079008b364516c \
	file://src/nvme/base64.c;startline=1;endline=2;md5=cfa333c28b94c54d228eecd95f238319

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
LIBNVME_CONF_TOOL	:= meson
LIBNVME_CONF_OPT	:=  \
	$(CROSS_MESON_USR) \
	-Ddocs=false \
	-Ddocs-build=false \
	-Djson-c=disabled \
	-Dkeyutils=disabled \
	-Dlibdbus=disabled \
	-Dopenssl=disabled \
	-Dpython=disabled \
	-Dtests=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libnvme.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libnvme)
	@$(call install_fixup, libnvme,PRIORITY,optional)
	@$(call install_fixup, libnvme,SECTION,base)
	@$(call install_fixup, libnvme,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libnvme,DESCRIPTION,missing)

	@$(call install_lib, libnvme, 0, 0, 0644, libnvme)

	@$(call install_finish, libnvme)

	@$(call touch)

# vim: syntax=make
