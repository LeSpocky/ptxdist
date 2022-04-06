# -*-makefile-*-
#
# Copyright (C) 2020 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GRAPHENE) += graphene

#
# Paths and names
#
GRAPHENE_VERSION	:= 1.10.8
GRAPHENE_MD5		:= 32660faa6ab717ee1600566ede027e9d
GRAPHENE		:= graphene-$(GRAPHENE_VERSION)
GRAPHENE_SUFFIX		:= tar.gz
GRAPHENE_URL		:= https://github.com/ebassi/graphene/archive/refs/tags/$(GRAPHENE_VERSION).$(GRAPHENE_SUFFIX)
GRAPHENE_SOURCE		:= $(SRCDIR)/$(GRAPHENE).$(GRAPHENE_SUFFIX)
GRAPHENE_DIR		:= $(BUILDDIR)/$(GRAPHENE)
GRAPHENE_LICENSE	:= MIT
GRAPHENE_LICENSE_FILES	:= file://LICENSE.txt;md5=a7d871d9e23c450c421a85bb2819f648

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
GRAPHENE_CONF_TOOL	:= meson
GRAPHENE_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Darm_neon=$(call ptx/truefalse, PTXCONF_ARCH_ARM_NEON) \
	-Dgcc_vector=true \
	-Dgobject_types=true \
	-Dgtk_doc=false \
	-Dinstalled_tests=false \
	-Dintrospection=$(call ptx/endis, PTXCONF_GRAPHENE_INTROSPECTION)d \
	-Dsse2=$(call ptx/truefalse, PTXCONF_ARCH_X86) \
	-Dtests=false


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/graphene.targetinstall:
	@$(call targetinfo)

	@$(call install_init, graphene)
	@$(call install_fixup, graphene,PRIORITY,optional)
	@$(call install_fixup, graphene,SECTION,base)
	@$(call install_fixup, graphene,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, graphene,DESCRIPTION,missing)

	@$(call install_lib, graphene, 0, 0, 0644, libgraphene-1.0)
ifdef PTXCONF_GRAPHENE_INTROSPECTION
	@$(call install_copy, graphene, 0, 0, 0644, -, \
		/usr/lib/girepository-1.0/Graphene-1.0.typelib)
endif

	@$(call install_finish, graphene)

	@$(call touch)

# vim: syntax=make
