# -*-makefile-*-
#
# Copyright (C) 2010 by Erwin Rol <erwin@erwinrol.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FLAC) += flac

#
# Paths and names
#
FLAC_VERSION	:= 1.5.0
FLAC_MD5	:= 0bb45bcf74338b00efeec121fff27367
FLAC		:= flac-$(FLAC_VERSION)
FLAC_SUFFIX	:= tar.xz
FLAC_URL	:= http://downloads.xiph.org/releases/flac/$(FLAC).$(FLAC_SUFFIX)
FLAC_SOURCE	:= $(SRCDIR)/$(FLAC).$(FLAC_SUFFIX)
FLAC_DIR	:= $(BUILDDIR)/$(FLAC)
FLAC_LICENSE	:= BSD-3-Clause AND GPL-2.0-or-later AND LGPL-2.0-or-later
FLAC_LICENSE_FILES := \
	file://COPYING.Xiph;md5=78a131b2ea50675d245d280ccc34f8b6 \
	file://src/flac/analyze.c;startline=1;endline=18;md5=1e826b5083ba1e028852fe7ceec6a8ad \
	file://COPYING.GPL;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
	file://src/share/grabbag/file.c;startline=1;endline=18;md5=f34f4ffcfadff8326f08de1da2f18a7e \
	file://COPYING.LGPL;md5=fbc093901857fcd118f065f900982c24

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
FLAC_CONF_TOOL	:= autoconf
FLAC_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-asm-optimizations \
	--$(call ptx/endis, PTXCONF_ARCH_X86_64)-avx \
	--disable-thorough-tests \
	--disable-exhaustive-tests \
	--disable-werror \
	--enable-stack-smash-protection \
	--disable-fortify-source \
	--disable-64-bit-words \
	--disable-valgrind-testing \
	--disable-doxygen-docs \
	--disable-cpplibs \
	--disable-oss-fuzzers \
	--enable-ogg \
	--disable-oggtest \
	--enable-programs \
	--disable-examples \
	--disable-version-from-git \
	--enable-multithreading \
	--disable-rpath \


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/flac.targetinstall:
	@$(call targetinfo)

	@$(call install_init, flac)
	@$(call install_fixup, flac,PRIORITY,optional)
	@$(call install_fixup, flac,SECTION,base)
	@$(call install_fixup, flac,AUTHOR,"Erwin Rol <erwin@erwinrol.com>")
	@$(call install_fixup, flac,DESCRIPTION,missing)

	@$(call install_lib, flac, 0, 0, 0644, libFLAC)

ifdef PTXCONF_FLAC_INSTALL_FLAC
	@$(call install_copy, flac, 0, 0, 0755, -, /usr/bin/flac)
endif
ifdef PTXCONF_FLAC_INSTALL_METAFLAC
	@$(call install_copy, flac, 0, 0, 0755, -, /usr/bin/metaflac)
endif

	@$(call install_finish, flac)

	@$(call touch)

# vim: syntax=make
