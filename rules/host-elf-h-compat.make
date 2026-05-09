# -*-makefile-*-
#
# Copyright (C) 2012 by Bernhard Walle <bernhard@bwalle.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
LAZY_PACKAGES-$(PTXCONF_HOST_ELF_H_COMPAT) += host-elf-h-compat

#
# Paths and names
#
HOST_ELF_H_COMPAT_VERSION	:= 0.2
HOST_ELF_H_COMPAT_SHA256	:= 886e74c1c3a510b71a43afc58b73cd88cae007365be96f81d72099103cda4321
HOST_ELF_H_COMPAT		:= elf-h-compat-$(HOST_ELF_H_COMPAT_VERSION)
HOST_ELF_H_COMPAT_SUFFIX	:= tar.bz2
HOST_ELF_H_COMPAT_URL		:= http://bwalle.de/programme/$(HOST_ELF_H_COMPAT).$(HOST_ELF_H_COMPAT_SUFFIX)
HOST_ELF_H_COMPAT_SOURCE	:= $(SRCDIR)/$(HOST_ELF_H_COMPAT).$(HOST_ELF_H_COMPAT_SUFFIX)
HOST_ELF_H_COMPAT_DIR		:= $(HOST_BUILDDIR)/$(HOST_ELF_H_COMPAT)
HOST_ELF_H_COMPAT_LICENSE	:= GPL-2.0-or-later

#
# autoconf
#
HOST_ELF_H_COMPAT_CONF_TOOL	:= autoconf

ifneq ($(call ptx/force-sh, uname -s),Linux)
$(STATEDIR)/base.prepare: $(STATEDIR)/host-elf-h-compat.install.post
endif

# vim: syntax=make
