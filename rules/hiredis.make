# -*-makefile-*-
#
# Copyright (C) 2022 by Clemens Gruber <clemens.gruber@pqgruber.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HIREDIS) += hiredis

#
# Paths and names
#
HIREDIS_VERSION		:= 1.2.0
HIREDIS_MD5		:= 119767d178cfa79718a80c83e0d0e849
HIREDIS			:= hiredis-$(HIREDIS_VERSION)
HIREDIS_SUFFIX		:= tar.gz
HIREDIS_URL		:= https://github.com/redis/hiredis/archive/v$(HIREDIS_VERSION).$(HIREDIS_SUFFIX)
HIREDIS_SOURCE		:= $(SRCDIR)/$(HIREDIS).$(HIREDIS_SUFFIX)
HIREDIS_DIR		:= $(BUILDDIR)/$(HIREDIS)
HIREDIS_LICENSE		:= BSD-3-Clause
HIREDIS_LICENSE_FILES	:= file://COPYING;md5=d84d659a35c666d23233e54503aaea51

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
HIREDIS_CONF_TOOL	:= cmake

HIREDIS_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DDISABLE_TESTS=ON \
	-DENABLE_SSL=OFF


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/hiredis.targetinstall:
	@$(call targetinfo)

	@$(call install_init, hiredis)
	@$(call install_fixup, hiredis,PRIORITY,optional)
	@$(call install_fixup, hiredis,SECTION,base)
	@$(call install_fixup, hiredis,AUTHOR,"Clemens Gruber <clemens.gruber@pqgruber.com>")
	@$(call install_fixup, hiredis,DESCRIPTION,"Minimalistic C client for Redis")

	@$(call install_lib, hiredis, 0, 0, 0644, libhiredis)

	@$(call install_finish, hiredis)

	@$(call touch)

# vim: syntax=make
