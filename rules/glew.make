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
PACKAGES-$(PTXCONF_GLEW) += glew

#
# Paths and names
#
GLEW_VERSION	:= 2.3.1
GLEW_SHA256	:= b64790f94b926acd7e8f84c5d6000a86cb43967bd1e688b03089079799c9e889
GLEW		:= glew-$(GLEW_VERSION)
GLEW_SUFFIX	:= tgz
GLEW_URL	:= $(call ptx/mirror, SF, glew/$(GLEW_VERSION)/$(GLEW).$(GLEW_SUFFIX))
GLEW_SOURCE	:= $(SRCDIR)/$(GLEW).$(GLEW_SUFFIX)
GLEW_DIR	:= $(BUILDDIR)/$(GLEW)
GLEW_SUBDIR	:= build/cmake
GLEW_LICENSE	:= BSD-3-Clause AND MIT
GLEW_LICENSE_FILES := \
	file://LICENSE.txt;md5=2ac251558de685c6b9478d89be3149c2 \
	file://src/glew.c;startline=1;endline=31;md5=badb89ecb458e9499c83d75d444708a5

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GLEW_CONF_TOOL	:= cmake
# mesa is built without glvnd, so there is no libGLX and the GLX
# functions are part of libGL.
GLEW_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DOpenGL_GL_PREFERENCE=LEGACY \
	-DOPENGL_glx_LIBRARY=-lGL \
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_UTILS=OFF \
	-DGLEW_EGL=OFF \
	-DGLEW_OSMESA=OFF \
	-DGLEW_REGAL=OFF \
	-DGLEW_X11=ON

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/glew.targetinstall:
	@$(call targetinfo)

	@$(call install_init, glew)
	@$(call install_fixup, glew,PRIORITY,optional)
	@$(call install_fixup, glew,SECTION,base)
	@$(call install_fixup, glew,AUTHOR,"Erwin Rol <erwin@erwinrol.com>")
	@$(call install_fixup, glew,DESCRIPTION,missing)

	@$(call install_lib, glew, 0, 0, 0644, libGLEW)

	@$(call install_finish, glew)

	@$(call touch)

# vim: syntax=make
