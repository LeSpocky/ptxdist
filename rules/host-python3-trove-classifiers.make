# -*-makefile-*-
#
# Copyright (C) 2024 by Lars Pedersen <lapeddk@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_TROVE_CLASSIFIERS) += host-python3-trove-classifiers

#
# Paths and names
#
HOST_PYTHON3_TROVE_CLASSIFIERS_VERSION		:= 2024.10.21.16
HOST_PYTHON3_TROVE_CLASSIFIERS_MD5		:= c2820cfbb09e91d84ade85e0e65d87ae
HOST_PYTHON3_TROVE_CLASSIFIERS			:= trove_classifiers-$(HOST_PYTHON3_TROVE_CLASSIFIERS_VERSION)
HOST_PYTHON3_TROVE_CLASSIFIERS_SUFFIX		:= tar.gz
HOST_PYTHON3_TROVE_CLASSIFIERS_URL		:= $(call ptx/mirror-pypi, trove-classifiers, $(HOST_PYTHON3_TROVE_CLASSIFIERS).$(HOST_PYTHON3_TROVE_CLASSIFIERS_SUFFIX))
HOST_PYTHON3_TROVE_CLASSIFIERS_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_TROVE_CLASSIFIERS).$(HOST_PYTHON3_TROVE_CLASSIFIERS_SUFFIX)
HOST_PYTHON3_TROVE_CLASSIFIERS_DIR		:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_TROVE_CLASSIFIERS)
HOST_PYTHON3_TROVE_CLASSIFIERS_LICENSE		:= Apache-2.0
HOST_PYTHON3_TROVE_CLASSIFIERS_LICENSE_FILES	:= file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_TROVE_CLASSIFIERS_CONF_TOOL	:= python3

# vim: syntax=make
