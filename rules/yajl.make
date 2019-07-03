# -*-makefile-*-
#
# Copyright (C) 2016 by Denis Osterland <Denis.Osterland@diehl.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_YAJL) += yajl

#
# Paths and names
#
YAJL_VERSION	:= 2.1.0
YAJL_MD5	:= 8df8a92a2799bc949577e8e7a9f43670 6887e0ed7479d2549761a4d284d3ecb0
YAJL		:= yajl-$(YAJL_VERSION)
YAJL_SUFFIX	:= tar.gz
YAJL_URL	:= https://github.com/lloyd/yajl/archive/$(YAJL_VERSION).$(YAJL_SUFFIX)
YAJL_SOURCE	:= $(SRCDIR)/$(YAJL).$(YAJL_SUFFIX)
YAJL_DIR	:= $(BUILDDIR)/$(YAJL)
YAJL_LICENSE	:= ISC
YAJL_LICENSE_FILES := file://COPYING;md5=39af6eb42999852bdd3ea00ad120a36d

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
YAJL_CONF_TOOL	:= cmake

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/yajl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, yajl)
	@$(call install_fixup, yajl,PRIORITY,optional)
	@$(call install_fixup, yajl,SECTION,base)
	@$(call install_fixup, yajl,AUTHOR,"Denis Osterland <Denis.Osterland@diehl.com>")
	@$(call install_fixup, yajl,DESCRIPTION,missing)

	@$(call install_lib, yajl, 0, 0, 0644, libyajl)

	@$(call install_finish, yajl)

	@$(call touch)

# vim: syntax=make
