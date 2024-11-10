# -*-makefile-*-
#
# Copyright (C) 2017 Clemens Gruber <clemens.gruber@pqgruber.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HARFBUZZ) += harfbuzz

#
# Paths and names
#
HARFBUZZ_VERSION	:= 8.3.0
HARFBUZZ_MD5		:= 7bf11a21c51a4f3ce0728decc4c557d4
HARFBUZZ		:= harfbuzz-$(HARFBUZZ_VERSION)
HARFBUZZ_SUFFIX		:= tar.xz
HARFBUZZ_URL		:= https://github.com/harfbuzz/harfbuzz/releases/download/$(HARFBUZZ_VERSION)/$(HARFBUZZ).$(HARFBUZZ_SUFFIX)
HARFBUZZ_SOURCE		:= $(SRCDIR)/$(HARFBUZZ).$(HARFBUZZ_SUFFIX)
HARFBUZZ_DIR		:= $(BUILDDIR)/$(HARFBUZZ)
HARFBUZZ_LICENSE	:= MIT
HARFBUZZ_LICENSE_FILES	:= \
	file://COPYING;md5=b98429b8e8e3c2a67cfef01e99e4893d

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HARFBUZZ_CONF_TOOL	:= meson
HARFBUZZ_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dbenchmark=disabled \
	-Dcairo=disabled \
	-Dchafa=disabled \
	-Dcoretext=disabled \
	-Ddirectwrite=disabled \
	-Ddoc_tests=false \
	-Ddocs=disabled \
	-Dexperimental_api=false \
	-Dfreetype=enabled \
	-Dfuzzer_ldflags="" \
	-Dgdi=disabled \
	-Dglib=enabled \
	-Dgobject=$(call ptx/endis, PTXCONF_HARFBUZZ_INTROSPECTION)d \
	-Dgraphite=disabled \
	-Dgraphite2=$(call ptx/endis, PTXCONF_HARFBUZZ_GRAPHITE)d \
	-Dicu=$(call ptx/endis, PTXCONF_HARFBUZZ_ICU)d \
	-Dicu_builtin=false \
	-Dintrospection=$(call ptx/endis, PTXCONF_HARFBUZZ_INTROSPECTION)d \
	-Dragel_subproject=false \
	-Dtests=disabled \
	-Dutilities=disabled \
	-Dwasm=disabled

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/harfbuzz.targetinstall:
	@$(call targetinfo)

	@$(call install_init, harfbuzz)
	@$(call install_fixup, harfbuzz,PRIORITY,optional)
	@$(call install_fixup, harfbuzz,SECTION,base)
	@$(call install_fixup, harfbuzz,AUTHOR,"Clemens Gruber <clemens.gruber@pqgruber.com>")
	@$(call install_fixup, harfbuzz,DESCRIPTION, "OpenType text shaping engine")

	@$(call install_lib, harfbuzz, 0, 0, 0644, libharfbuzz)
ifdef PTXCONF_HARFBUZZ_SUBSET
	@$(call install_lib, harfbuzz, 0, 0, 0644, libharfbuzz-subset)
endif
ifdef PTXCONF_HARFBUZZ_ICU
	@$(call install_lib, harfbuzz, 0, 0, 0644, libharfbuzz-icu)
endif

	@$(call install_finish, harfbuzz)

	@$(call touch)

# vim: syntax=make
