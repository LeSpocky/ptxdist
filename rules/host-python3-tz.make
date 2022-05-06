# -*-makefile-*-
#
# Copyright (C) 2019 by Robin van der Gracht <robin@protonic.nl>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_TZ) += host-python3-tz

#
# Paths and names
#
HOST_PYTHON3_TZ_VERSION		:= 2018.9
HOST_PYTHON3_TZ_MD5		:= 0f57d76c64d0965e7429c9b871f6b711
HOST_PYTHON3_TZ			:= pytz-$(HOST_PYTHON3_TZ_VERSION)
HOST_PYTHON3_TZ_SUFFIX		:= tar.gz
HOST_PYTHON3_TZ_URL		:= $(call ptx/mirror-pypi, pytz, $(HOST_PYTHON3_TZ).$(PYTHON3_IFADDR_SUFFIX))
HOST_PYTHON3_TZ_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_TZ).$(HOST_PYTHON3_TZ_SUFFIX)
HOST_PYTHON3_TZ_DIR		:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_TZ)
HOST_PYTHON3_TZ_LICENSE		:= MIT
HOST_PYTHON3_TZ_LICENSE_FILES	:= file://LICENSE.txt;md5=4878a915709225bceab739bdc2a18e8d

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_TZ_CONF_TOOL := python3

# vim: syntax=make
