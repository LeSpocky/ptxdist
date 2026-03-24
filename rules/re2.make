# -*-makefile-*-
#
# Copyright (C) 2026 by Lars Pedersen <lapeddk@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RE2) += re2

#
# Paths and names
#
RE2_VERSION		:= 2025-11-05
RE2_MD5			:= 2a26009d8c226fd0a8721fbce7132a83
RE2			:= re2-$(RE2_VERSION)
RE2_SUFFIX		:= tar.gz
RE2_URL			:= https://github.com/google/re2/archive/$(RE2_VERSION).$(RE2_SUFFIX)
RE2_SOURCE		:= $(SRCDIR)/$(RE2).$(RE2_SUFFIX)
RE2_DIR			:= $(BUILDDIR)/$(RE2)
RE2_LICENSE		:= BSD-3-Clause
RE2_LICENSE_FILES	:= \
	file://LICENSE;md5=3b5c31eb512bdf3cb11ffd5713963760

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
RE2_CONF_TOOL	:= cmake
RE2_CONF_OPT	:=  \
	$(CROSS_CMAKE_USR) \
	-DBUILD_SHARED_LIBS=ON

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/re2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, re2)
	@$(call install_fixup, re2, PRIORITY, optional)
	@$(call install_fixup, re2, SECTION, base)
	@$(call install_fixup, re2, AUTHOR, "Lars Pedersen <lapeddk@gmail.com>")
	@$(call install_fixup, re2, DESCRIPTION, missing)

	@$(call install_lib, re2, 0, 0, 0644, libre2)

	@$(call install_finish, re2)

	@$(call touch)

# vim: ft=make
