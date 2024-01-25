# -*-makefile-*-
#
# Copyright (C) 2019 by David Jander <david@protonic.nl>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_UVLOOP) += python3-uvloop

#
# Paths and names
#
PYTHON3_UVLOOP_VERSION		:= v0.17.0
PYTHON3_UVLOOP_MD5		:= d64fa7d6f7ca753132e076106592bf1c
PYTHON3_UVLOOP			:= python3-uvloop-$(PYTHON3_UVLOOP_VERSION)
PYTHON3_UVLOOP_SUFFIX		:= tar.gz
PYTHON3_UVLOOP_URL		:= https://github.com/MagicStack/uvloop/archive/$(PYTHON3_UVLOOP_VERSION).$(PYTHON3_UVLOOP_SUFFIX)
PYTHON3_UVLOOP_SOURCE		:= $(SRCDIR)/$(PYTHON3_UVLOOP).$(PYTHON3_UVLOOP_SUFFIX)
PYTHON3_UVLOOP_DIR		:= $(BUILDDIR)/$(PYTHON3_UVLOOP)
PYTHON3_UVLOOP_LICENSE		:= Apache-2.0 OR MIT
PYTHON3_UVLOOP_LICENSE_FILES	:= \
	file://LICENSE-APACHE;md5=bb92739ddad0a2811957bd98bdb90474 \
	file://LICENSE-MIT;md5=489c8bc34154e4b59f5c58e664f7d70f

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_UVLOOP_CONF_TOOL	:= python3
PYTHON3_UVLOOP_MAKE_OPT		:= build build_py build_ext --use-system-libuv
PYTHON3_UVLOOP_INSTALL_OPT	:= build_ext --use-system-libuv install --prefix=/usr

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-uvloop.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-uvloop)
	@$(call install_fixup, python3-uvloop, PRIORITY, optional)
	@$(call install_fixup, python3-uvloop, SECTION, base)
	@$(call install_fixup, python3-uvloop, AUTHOR, "David Jander <david@protonic.nl>")
	@$(call install_fixup, python3-uvloop, DESCRIPTION, missing)

	@$(call install_glob, python3-uvloop, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/uvloop, *.pyc *.so)

	@$(call install_finish, python3-uvloop)

	@$(call touch)

# vim: syntax=make
