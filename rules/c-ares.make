# -*-makefile-*-
#
# Copyright (C) 2014 Dr. Neuhaus Telekommunikation GmbH, Hamburg Germany, Oliver Graute <oliver.graute@neuhaus.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_C_ARES) += c-ares

#
# Paths and names
#
C_ARES_VERSION	:= 1.34.5
C_ARES_MD5	:= 2c6dae580c2ef4ca03c1a27959bb9727
C_ARES		:= c-ares-$(C_ARES_VERSION)
C_ARES_SUFFIX	:= tar.gz
C_ARES_URL	:= https://github.com/c-ares/c-ares/releases/download/v$(C_ARES_VERSION)/$(C_ARES).$(C_ARES_SUFFIX)
C_ARES_SOURCE	:= $(SRCDIR)/$(C_ARES).$(C_ARES_SUFFIX)
C_ARES_DIR	:= $(BUILDDIR)/$(C_ARES)
C_ARES_LICENSE	:= MIT AND BSD-3-Clause
C_ARES_LICENSE_FILES	:= \
	file://LICENSE.md;md5=d3e72a10e08191f2ca1be3f3228d78f3 \
	file://src/lib/ares_sortaddrinfo.c;startline=6;endline=37;md5=e2512b3f20a893b8f7a986d97376cfac


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
C_ARES_CONF_TOOL      := autoconf
C_ARES_CONF_OPT              := \
	$(CROSS_AUTOCONF_USR) \
	--enable-warnings \
	--enable-symbol-hiding \
	--disable-tests \
	--enable-cares-threads \
	--disable-code-coverage \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-libgcc \
	--disable-tests-crossbuild \
	--with-random=/dev/urandom

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/c-ares.targetinstall:
	@$(call targetinfo)

	@$(call install_init, c-ares)
	@$(call install_fixup, c-ares,PRIORITY,optional)
	@$(call install_fixup, c-ares,SECTION,base)
	@$(call install_fixup, c-ares,AUTHOR,"<oliver.graute@neuhaus.de>")
	@$(call install_fixup, c-ares,DESCRIPTION,missing)

	@$(call install_lib, c-ares, 0, 0, 0644, libcares)

	@$(call install_finish, c-ares)


	@$(call touch)

# vim: syntax=make
