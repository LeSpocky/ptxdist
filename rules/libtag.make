# -*-makefile-*-
#
# Copyright (C) 2023 by Ladislav Michl <ladis@linux-mips.org>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBTAG) += libtag

#
# Paths and names
#
LIBTAG_VERSION		:= 1.13.1
LIBTAG_MD5		:= 2fe6089da73ad414aa1b982b83415362
LIBTAG			:= taglib-$(LIBTAG_VERSION)
LIBTAG_SUFFIX		:= tar.gz
LIBTAG_URL		:= https://taglib.org/releases/$(LIBTAG).$(LIBTAG_SUFFIX)
LIBTAG_SOURCE		:= $(SRCDIR)/$(LIBTAG).$(LIBTAG_SUFFIX)
LIBTAG_DIR		:= $(BUILDDIR)/$(LIBTAG)
LIBTAG_LICENSE		:= LGPL-2.1-or-later
LIBTAG_LICENSE_FILES	:= \
	file://COPYING.LGPL;md5=4fbd65380cdd255951079008b364516c \
	file://COPYING.MPL;md5=bfe1f75d606912a4111c90743d6c7325

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBTAG_CONF_TOOL	:= cmake
LIBTAG_CONF_OPT		:= \
	$(CROSS_CMAKE_USR) \
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_TESTING=OFF \
	-DBUILD_EXAMPLES=OFF \
	-DWITH_ZLIB=$(call ptx/onoff, PTXCONF_LIBTAG_ZLIB)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libtag.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libtag)
	@$(call install_fixup, libtag,PRIORITY,optional)
	@$(call install_fixup, libtag,SECTION,base)
	@$(call install_fixup, libtag,AUTHOR,"Ladislav Michl <ladis@linux-mips.org>")
	@$(call install_fixup, libtag,DESCRIPTION,missing)

	$(call install_lib, libtag, 0, 0, 0644, libtag)

	@$(call install_finish, libtag)

	@$(call touch)

# vim: syntax=make
