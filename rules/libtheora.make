# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBTHEORA) += libtheora

#
# Paths and names
#
LIBTHEORA_VERSION	:= 1.1.1
LIBTHEORA_MD5		:= bb4dc37f0dc97db98333e7160bfbb52b
LIBTHEORA		:= libtheora-$(LIBTHEORA_VERSION)
LIBTHEORA_SUFFIX	:= tar.gz
LIBTHEORA_URL		:= http://downloads.xiph.org/releases/theora/$(LIBTHEORA).$(LIBTHEORA_SUFFIX)
LIBTHEORA_SOURCE	:= $(SRCDIR)/$(LIBTHEORA).$(LIBTHEORA_SUFFIX)
LIBTHEORA_DIR		:= $(BUILDDIR)/$(LIBTHEORA)
LIBTHEORA_LICENSE	:= BSD-3-Clause
LIBTHEORA_LICENSE_FILES	:= \
	file://COPYING;md5=cf91718f59eb6a83d06dc7bcaf411132 \
	file://LICENSE;md5=82ccf023e3ce1aa18043edc61f948e2c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBTHEORA_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_prog_HAVE_DOXYGEN=false \
	ac_cv_prog_HAVE_PDFLATEX=no \
	ac_cv_prog_HAVE_BIBTEX=no \
	ac_cv_prog_HAVE_TRANSFIG=no

#
# autoconf
#
LIBTHEORA_CONF_TOOL	:= autoconf
LIBTHEORA_CONF_OPT	 := \
	$(CROSS_AUTOCONF_USR) \
	--enable-asm \
	--disable-examples \
	--disable-spec \
	--disable-valgrind-testing \
	--disable-telemetry \
	--disable-examples \
	--enable-ogg \
	--$(call ptx/endis, PTXCONF_LIBTHEORA_VORBIS)-vorbis \
	--$(call ptx/endis, PTXCONF_LIBTHEORA_SDL)-sdl \
	--$(call ptx/endis, PTXCONF_LIBTHEORA_FLOAT)-float \
	--$(call ptx/endis, PTXCONF_LIBTHEORA_ENCODING)-encode

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libtheora.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libtheora)
	@$(call install_fixup, libtheora,PRIORITY,optional)
	@$(call install_fixup, libtheora,SECTION,base)
	@$(call install_fixup, libtheora,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libtheora,DESCRIPTION,missing)

	@$(call install_lib, libtheora, 0, 0, 0644, libtheora)
	@$(call install_lib, libtheora, 0, 0, 0644, libtheoradec)
ifdef PTXCONF_LIBTHEORA_ENCODING
	@$(call install_lib, libtheora, 0, 0, 0644, libtheoraenc)
endif

	@$(call install_finish, libtheora)

	@$(call touch)

# vim: syntax=make
