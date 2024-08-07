# -*-makefile-*-
#
# Copyright (C) 2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GLU) += glu

#
# Paths and names
#
GLU_VERSION	:= 9.0.2
GLU_MD5		:= 2b0f13fa5b949bfb3a995927c6e35125
GLU		:= glu-$(GLU_VERSION)
GLU_SUFFIX	:= tar.xz
GLU_URL		:= https://mesa.freedesktop.org/archive/glu/$(GLU).$(GLU_SUFFIX)
GLU_SOURCE	:= $(SRCDIR)/$(GLU).$(GLU_SUFFIX)
GLU_DIR		:= $(BUILDDIR)/$(GLU)
GLU_LICENSE	:= SGI-B-2.0 AND SGI-B-1.1
GLU_LICENSE_FILES := \
	file://src/libutil/glue.c;startline=2;endline=28;md5=76832a1e3b436747980ebbc1cd89bfac \
	file://src/libnurbs/internals/bin.cc;startline=2;endline=32;md5=f2807b3ac0a293c6faaac74d8933bb1f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
GLU_CONF_TOOL	:= meson
GLU_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Ddefault_library=shared \
	-Dgl_provider=gl

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/glu.targetinstall:
	@$(call targetinfo)

	@$(call install_init, glu)
	@$(call install_fixup, glu,PRIORITY,optional)
	@$(call install_fixup, glu,SECTION,base)
	@$(call install_fixup, glu,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, glu,DESCRIPTION,missing)

	@$(call install_lib, glu, 0, 0, 0644, libGLU)

	@$(call install_finish, glu)

	@$(call touch)

# vim: syntax=make
