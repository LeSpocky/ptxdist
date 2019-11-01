# -*-makefile-*-
#
# Copyright (C) 2019 by Ladislav Michl <ladis@linux-mips.org>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CASYNC) += host-casync

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CASYNC_CONF_TOOL	:= meson
HOST_CASYNC_CONF_OPT	:= \
	$(HOST_MESON_OPT) \
	-Dfuse=false \
	-Dselinux=false \
	-Dudev=false \
	-Dudevrulesdir=no \
	-Dman=false \
	-Dlibzstd=disabled \
	-Dliblzma=enabled \
	-Dlibz=enabled \
	-Doss-fuzz=false \
	-Dllvm-fuzz=false \
	-Dbashcompletiondir=no

# vim: syntax=make
