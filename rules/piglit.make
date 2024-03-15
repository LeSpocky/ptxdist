# -*-makefile-*-
#
# Copyright (C) 2017 by Lucas Stach <l.stach@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PIGLIT) += piglit

#
# Paths and names
#
PIGLIT_VERSION	:= 2024-03-09-gb32186ee5313
PIGLIT_MD5	:= 404aec6973480d5ac54588c01f0c8fd4
PIGLIT		:= piglit-$(PIGLIT_VERSION)
PIGLIT_SUFFIX	:= tar.gz
PIGLIT_URL	:= https://gitlab.freedesktop.org/mesa/piglit/-/archive/$(PIGLIT_VERSION)/$(PIGLIT).$(PIGLIT_SUFFIX)
PIGLIT_SOURCE	:= $(SRCDIR)/$(PIGLIT).$(PIGLIT_SUFFIX)
PIGLIT_DIR	:= $(BUILDDIR)/$(PIGLIT)
PIGLIT_LICENSE	:= MIT AND GPLv2+ AND GPLv3 AND LGPLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PIGLIT_BUILD_OOT	:= NO
PIGLIT_CONF_TOOL	:= cmake

PIGLIT_CONF_OPT		:= $(CROSS_CMAKE_USR) \
	-G Ninja \
	-DCMAKE_DISABLE_FIND_PACKAGE_Git=TRUE \
	-DPYTHON_EXECUTABLE:FILEPATH=$(SYSTEMPYTHON3) \
	-DPIGLIT_USE_WAFFLE=1 \
	-DPIGLIT_BUILD_GL_TESTS=$(call ptx/ifdef, PTXCONF_PIGLIT_TESTS_OPENGL,1,0) \
	-DPIGLIT_BUILD_GLES1_TESTS=$(call ptx/ifdef, PTXCONF_PIGLIT_TESTS_OPENGLES1,1,0) \
	-DPIGLIT_BUILD_GLES2_TESTS=$(call ptx/ifdef, PTXCONF_PIGLIT_TESTS_OPENGLES2,1,0) \
	-DPIGLIT_BUILD_GLES3_TESTS=$(call ptx/ifdef, PTXCONF_PIGLIT_TESTS_OPENGLES3,1,0) \
	-DPIGLIT_BUILD_CL_TESTS=0 \
	-DPIGLIT_BUILD_VK_TESTS=$(call ptx/ifdef, PTXCONF_PIGLIT_TESTS_VULKAN,1,0) \
	-DHAVE_LIBCACA:BOOL=NO

PIGLIT_MAKE_ENV		:= \
	TMPDIR=$(PTXDIST_TEMPDIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/piglit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, piglit)
	@$(call install_fixup, piglit,PRIORITY,optional)
	@$(call install_fixup, piglit,SECTION,base)
	@$(call install_fixup, piglit,AUTHOR,"Lucas Stach <l.stach@pengutronix.de>")
	@$(call install_fixup, piglit,DESCRIPTION,missing)

	@$(call install_copy, piglit, 0, 0, 0755, -, /usr/bin/piglit)
	@$(call install_tree, piglit, 0, 0, -, /usr/lib/piglit, n)

	@$(call install_finish, piglit)

	@$(call touch)

# vim: syntax=make
