# -*-makefile-*-
#
# Copyright (C) 2024 by Lucas Sinn <lucas.sinn@wolfvision.net>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GLIBMM) += glibmm

#
# Paths and names
#
GLIBMM_VERSION	:= 2.78.1
GLIBMM_MD5	:= 52b93bf93de45e5a6b3c321bc832cd9c
GLIBMM		:= glibmm-$(GLIBMM_VERSION)
GLIBMM_SUFFIX	:= tar.xz
GLIBMM_URL	:= $(call ptx/mirror, GNOME, glibmm/$(basename $(GLIBMM_VERSION))/$(GLIBMM).$(GLIBMM_SUFFIX))
GLIBMM_SOURCE	:= $(SRCDIR)/$(GLIBMM).$(GLIBMM_SUFFIX)
GLIBMM_DIR	:= $(BUILDDIR)/$(GLIBMM)
GLIBMM_LICENSE	:= LGPL-2.1-only AND GPL-2.0-only
GLIBMM_LICENSE_FILES	:= \
	file://COPYING;md5=42dfffebc56fec7527aac53b7a89d1d8 \
	file://COPYING.tools;md5=751419260aa954499f7abaabaa882bbe

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
GLIBMM_CONF_TOOL  := meson
GLIBMM_CONF_OPT   := \
        $(CROSS_MESON_USR) \
        -Dbuild-deprecated-api=false \
        -Dbuild-documentation=false \
        -Dbuild-examples=false \
        -Ddebug-refcounting=false \
        -Ddist-warnings=fatal \
        -Dmaintainer-mode=false \
        -Dmsvc14x-parallel-installable=false \
        -Dwarnings=max

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/glibmm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, glibmm)
	@$(call install_fixup, glibmm,PRIORITY,optional)
	@$(call install_fixup, glibmm,SECTION,base)
	@$(call install_fixup, glibmm,AUTHOR,"Lucas Sinn <lucas.sinn@wolfvision.net>")
	@$(call install_fixup, glibmm,DESCRIPTION,missing)

	@$(call install_lib, glibmm, 0, 0, 0644, libglibmm-2.68)
	@$(call install_lib, glibmm, 0, 0, 0644, libgiomm-2.68)

	@$(call install_finish, glibmm)

	@$(call touch)

# vim: syntax=make
