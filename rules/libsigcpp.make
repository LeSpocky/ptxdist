# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
#               2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSIGCPP) += libsigcpp

#
# Paths and names
#
LIBSIGCPP_VERSION	:= 3.6.0
LIBSIGCPP_MD5		:= b7205d5465ac15fbc0c781d39b4011be
LIBSIGCPP		:= libsigc++-$(LIBSIGCPP_VERSION)
LIBSIGCPP_SUFFIX	:= tar.xz
LIBSIGCPP_URL		:= $(call ptx/mirror, GNOME, libsigc++/$(basename $(LIBSIGCPP_VERSION))/$(LIBSIGCPP).$(LIBSIGCPP_SUFFIX))
LIBSIGCPP_SOURCE	:= $(SRCDIR)/$(LIBSIGCPP).$(LIBSIGCPP_SUFFIX)
LIBSIGCPP_DIR		:= $(BUILDDIR)/$(LIBSIGCPP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# meson
#
LIBSIGCPP_CONF_TOOL	:= meson
LIBSIGCPP_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dbenchmark=false \
	-Dbuild-deprecated-api=false \
	-Dbuild-documentation=false \
	-Dbuild-examples=false \
	-Dbuild-pdf=false \
	-Dbuild-tests=false \
	-Ddist-warnings=fatal \
	-Dmaintainer-mode=false \
	-Dvalidation=false \
	-Dwarnings=min

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsigcpp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsigcpp)
	@$(call install_fixup, libsigcpp,PRIORITY,optional)
	@$(call install_fixup, libsigcpp,SECTION,base)
	@$(call install_fixup, libsigcpp,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libsigcpp,DESCRIPTION,missing)

	@$(call install_lib, libsigcpp, 0, 0, 0644, libsigc-3.0)

	@$(call install_finish, libsigcpp)

	@$(call touch)

# vim: syntax=make
