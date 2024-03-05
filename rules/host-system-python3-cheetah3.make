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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3_CHEETAH3) += host-system-python3-cheetah3

#
# Paths and names
#
HOST_SYSTEM_PYTHON3_CHEETAH3_VERSION		:= 3.3.3
HOST_SYSTEM_PYTHON3_CHEETAH3_MD5		:= 2cd8711cbaac7f58239755b4a20cd861
HOST_SYSTEM_PYTHON3_CHEETAH3			:= cheetah3-$(HOST_SYSTEM_PYTHON3_CHEETAH3_VERSION)
HOST_SYSTEM_PYTHON3_CHEETAH3_SUFFIX		:= tar.gz
# project on PyPI was renamed to CT3
HOST_SYSTEM_PYTHON3_CHEETAH3_URL		:= $(call ptx/mirror-pypi, CT3, CT3-$(HOST_SYSTEM_PYTHON3_CHEETAH3_VERSION).$(HOST_SYSTEM_PYTHON3_CHEETAH3_SUFFIX))
HOST_SYSTEM_PYTHON3_CHEETAH3_SOURCE		:= $(SRCDIR)/$(HOST_SYSTEM_PYTHON3_CHEETAH3).$(HOST_SYSTEM_PYTHON3_CHEETAH3_SUFFIX)
HOST_SYSTEM_PYTHON3_CHEETAH3_DIR		:= $(HOST_BUILDDIR)/$(HOST_SYSTEM_PYTHON3_CHEETAH3)
HOST_SYSTEM_PYTHON3_CHEETAH3_LICENSE		:= MIT
HOST_SYSTEM_PYTHON3_CHEETAH3_LICENSE_FILES	:= \
	file://LICENSE;md5=be4ebd20a0d448789acb1cdd9ceb6026

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SYSTEM_PYTHON3_CHEETAH3_CONF_TOOL	:= python3

# vim: syntax=make
