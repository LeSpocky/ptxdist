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
GRAPHENE_VERSION	:= 1.9.2
GRAPHENE_MD5		:= 4e274bb09ae3e04647763163be4f0a77
GRAPHENE		:= graphene-$(GRAPHENE_VERSION)
GRAPHENE_SUFFIX		:= tar.xz
GRAPHENE_URL		:= https://github.com/ebassi/graphene/releases/download/$(GRAPHENE_VERSION)/$(GRAPHENE).$(GRAPHENE_SUFFIX)
GRAPHENE_SOURCE		:= $(SRCDIR)/$(GRAPHENE).$(GRAPHENE_SUFFIX)
GRAPHENE_DIR		:= $(BUILDDIR)/$(GRAPHENE)
GRAPHENE_LICENSE	:= MIT
GRAPHENE_LICENSE_FILES	:= file://LICENSE;md5=a7d871d9e23c450c421a85bb2819f648

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
	-Dbenchmarks=false \
	-Dgcc_vector=true \
	-Dgobject_types=true \
	-Dgtk_doc=false \
	-Dintrospection=$(call ptx/truefalse, PTXCONF_GRAPHENE_INTROSPECTION) \
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
