# -*-makefile-*-
#
# Copyright (C) 2023 by Ian Abbott <abbotti@mev.co.uk>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBTAHU) += libtahu

#
# Paths and names
#
LIBTAHU_VERSION	:= 1.0.1
LIBTAHU_MD5	:= 7e980ed17e34a78d6d61c000e4957292
LIBTAHU		:= libtahu-$(LIBTAHU_VERSION)
LIBTAHU_SUFFIX	:= tar.gz
LIBTAHU_URL	:= https://github.com/eclipse/tahu/archive/refs/tags/v$(LIBTAHU_VERSION).$(LIBTAHU_SUFFIX)
LIBTAHU_SOURCE	:= $(SRCDIR)/$(LIBTAHU).$(LIBTAHU_SUFFIX)
LIBTAHU_DIR	:= $(BUILDDIR)/$(LIBTAHU)
LIBTAHU_SUBDIR	:= c/core
LIBTAHU_LICENSE	:= EPL-2.0
LIBTAHU_LICENSE_FILES	:= \
	file://LICENCE;md5=c7cc8aa73fb5717f8291fcec5ce9ed6c \
	file://notice.html;md5=618d2440fc58e15450a9416cd6804477

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBTAHU_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

#LIBTAHU_MAKE_ENV	:= $(CROSS_ENV)

# Just build the dynamic library.
LIBTAHU_MAKE_OPT	:= \
	$(CROSS_ENV_PROGS) \
	lib/libtahu.so

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libtahu.install:
	@$(call targetinfo)
	@install -m 644 -v -D -t "$(LIBTAHU_PKGDIR)/usr/lib" \
		"$(LIBTAHU_DIR)/$(LIBTAHU_SUBDIR)/lib/libtahu.so"
	@install -m 644 -v -D -t "$(LIBTAHU_PKGDIR)/usr/include" \
		"$(LIBTAHU_DIR)/$(LIBTAHU_SUBDIR)/include/pb.h" \
		"$(LIBTAHU_DIR)/$(LIBTAHU_SUBDIR)/include/pb_common.h" \
		"$(LIBTAHU_DIR)/$(LIBTAHU_SUBDIR)/include/pb_decode.h" \
		"$(LIBTAHU_DIR)/$(LIBTAHU_SUBDIR)/include/pb_encode.h" \
		"$(LIBTAHU_DIR)/$(LIBTAHU_SUBDIR)/include/tahu.h" \
		"$(LIBTAHU_DIR)/$(LIBTAHU_SUBDIR)/include/tahu.pb.h"
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libtahu.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libtahu)
	@$(call install_fixup, libtahu,PRIORITY,optional)
	@$(call install_fixup, libtahu,SECTION,base)
	@$(call install_fixup, libtahu,AUTHOR,"Ian Abbott <abbotti@mev.co.uk>")
	@$(call install_fixup, libtahu,DESCRIPTION,missing)

	@$(call install_lib, libtahu, 0, 0, 0644, libtahu)

	@$(call install_finish, libtahu)

	@$(call touch)

# vim: syntax=make
