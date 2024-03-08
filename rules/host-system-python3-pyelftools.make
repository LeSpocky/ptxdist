# -*-makefile-*-
#
# Copyright (C) 2024 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_PYELFTOOLS) += host-system-python3-pyelftools

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_PYELFTOOLS_VERSION		:= 0.30
HOST_SYSTEM_PYTHON3_PYELFTOOLS_MD5		:= 2b4f82fd30436834b9357a5e74b8ceb7
HOST_SYSTEM_PYTHON3_PYELFTOOLS			:= system-pyelftools-$(HOST_SYSTEM_PYTHON3_PYELFTOOLS_VERSION)
HOST_SYSTEM_PYTHON3_PYELFTOOLS_SUFFIX		:= tar.gz
HOST_SYSTEM_PYTHON3_PYELFTOOLS_URL		:= $(call ptx/mirror-pypi, pyelftools, pyelftools-$(HOST_SYSTEM_PYTHON3_PYELFTOOLS_VERSION).$(HOST_SYSTEM_PYTHON3_PYELFTOOLS_SUFFIX))
HOST_SYSTEM_PYTHON3_PYELFTOOLS_SOURCE		:= $(SRCDIR)/$(HOST_SYSTEM_PYTHON3_PYELFTOOLS).$(HOST_SYSTEM_PYTHON3_PYELFTOOLS_SUFFIX)
HOST_SYSTEM_PYTHON3_PYELFTOOLS_DIR		:= $(HOST_BUILDDIR)/$(HOST_SYSTEM_PYTHON3_PYELFTOOLS)
HOST_SYSTEM_PYTHON3_PYELFTOOLS_LICENSE		:= Unlicense
HOST_SYSTEM_PYTHON3_PYELFTOOLS_LICENSE_FILES	:= \
	file://LICENSE;md5=5ce2a2b07fca326bc7c146d10105ccfc

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_PYELFTOOLS_CONF_TOOL	:= python3

# vim: syntax=make
