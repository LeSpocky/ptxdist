# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FREEGLUT) += freeglut

#
# Paths and names
#
FREEGLUT_VERSION	:= 3.2.1
FREEGLUT_MD5		:= cd5c670c1086358598a6d4a9d166949d
FREEGLUT		:= freeglut-$(FREEGLUT_VERSION)
FREEGLUT_SUFFIX		:= tar.gz
FREEGLUT_URL		:= $(call ptx/mirror, SF, freeglut/$(FREEGLUT).$(FREEGLUT_SUFFIX))
FREEGLUT_SOURCE		:= $(SRCDIR)/$(FREEGLUT).$(FREEGLUT_SUFFIX)
FREEGLUT_DIR		:= $(BUILDDIR)/$(FREEGLUT)
FREEGLUT_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
FREEGLUT_CONF_TOOL	:= cmake
FREEGLUT_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DFREEGLUT_BUILD_DEMOS=OFF \
	-DFREEGLUT_BUILD_SHARED_LIBS=ON \
	-DFREEGLUT_BUILD_STATIC_LIBS=OFF \
	-DFREEGLUT_GLES=OFF \
	-DFREEGLUT_PRINT_ERRORS=ON \
	-DFREEGLUT_PRINT_WARNINGS=ON \
	-DFREEGLUT_REPLACE_GLUT=ON \
	-DFREEGLUT_WAYLAND=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/freeglut.targetinstall:
	@$(call targetinfo)

	@$(call install_init, freeglut)
	@$(call install_fixup, freeglut,PRIORITY,optional)
	@$(call install_fixup, freeglut,SECTION,base)
	@$(call install_fixup, freeglut,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, freeglut,DESCRIPTION,missing)

	@$(call install_lib, freeglut, 0, 0, 0644, libglut)

	@$(call install_finish, freeglut)

	@$(call touch)

# vim: syntax=make
