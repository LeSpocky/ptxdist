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
LIBTAG_VERSION		:= 2.1.1
LIBTAG_MD5		:= 9feffe76b4643eb724185310879c3123
LIBTAG			:= taglib-$(LIBTAG_VERSION)
LIBTAG_SUFFIX		:= tar.gz
LIBTAG_URL		:= https://taglib.org/releases/$(LIBTAG).$(LIBTAG_SUFFIX)
LIBTAG_SOURCE		:= $(SRCDIR)/$(LIBTAG).$(LIBTAG_SUFFIX)
LIBTAG_DIR		:= $(BUILDDIR)/$(LIBTAG)
LIBTAG_LICENSE		:= LGPL-2.1-only OR MPL-1.1
LIBTAG_LICENSE_FILES	:= \
	file://taglib/tag.h;startline=6;endline=24;md5=2e05d2813b45b33c4853a90dd4c161ed \
	file://COPYING.LGPL;md5=4fbd65380cdd255951079008b364516c \
	file://COPYING.MPL;md5=bfe1f75d606912a4111c90743d6c7325

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBTAG_CONF_TOOL	:= cmake
LIBTAG_CONF_OPT		:= \
	$(CROSS_CMAKE_USR) \
	-DBUILD_BINDINGS=OFF \
	-DBUILD_EXAMPLES=OFF \
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_TESTING=OFF \
	-DTRACE_IN_RELEASE=OFF \
	-DUTF8_INSTALL=OFF \
	-DUTF8_SAMPLES=OFF \
	-DUTF8_TESTS=OFF \
	-DWITH_APE=ON \
	-DWITH_ASF=ON \
	-DWITH_DSF=ON \
	-DWITH_MOD=ON \
	-DWITH_MP4=ON \
	-DWITH_RIFF=ON \
	-DWITH_SHORTEN=ON \
	-DWITH_TRUEAUDIO=ON \
	-DWITH_VORBIS=ON \
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
