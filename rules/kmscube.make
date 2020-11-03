# -*-makefile-*-
#
# Copyright (C) 2017 by Markus Niebel <Markus.Niebel@tq-group.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_KMSCUBE) += kmscube

#
# Paths and names
#
# No tags: use a fake descriptive commit-ish to include the date
KMSCUBE_VERSION	:= 2020-10-28-ge6386d1b
KMSCUBE		:= kmscube-$(KMSCUBE_VERSION)
KMSCUBE_MD5	:= cd5fbb6e53545f29e22e20aea3309570
KMSCUBE_SUFFIX	:= tar.gz
KMSCUBE_URL	:= https://gitlab.freedesktop.org/mesa/kmscube/-/archive/$(KMSCUBE_VERSION)/$(KMSCUBE).$(KMSCUBE_SUFFIX)
KMSCUBE_SOURCE	:= $(SRCDIR)/$(KMSCUBE).$(KMSCUBE_SUFFIX)
KMSCUBE_DIR	:= $(BUILDDIR)/$(KMSCUBE)
KMSCUBE_LICENSE	:= MIT
KMSCUBE_LICENSE_FILES := \
	file://COPYING;md5=2a12bf7a66f5f663d75186bf01eb607b

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
KMSCUBE_CONF_TOOL	:= meson
KMSCUBE_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dgstreamer=disabled

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/kmscube.targetinstall:
	@$(call targetinfo)

	@$(call install_init, kmscube)
	@$(call install_fixup, kmscube, PRIORITY, optional)
	@$(call install_fixup, kmscube, SECTION, base)
	@$(call install_fixup, kmscube, AUTHOR, "Markus Niebel <Markus.Niebel@tq-group.com>")
	@$(call install_fixup, kmscube, DESCRIPTION, missing)

	@$(call install_copy, kmscube, 0, 0, 0755, -, /usr/bin/kmscube)

	@$(call install_finish, kmscube)

	@$(call touch)

# vim: syntax=make
