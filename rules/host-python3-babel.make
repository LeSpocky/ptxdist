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
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_BABEL) += host-python3-babel

#
# Paths and names
#
HOST_PYTHON3_BABEL_VERSION		:= v2.10.1
HOST_PYTHON3_BABEL_SHA256		:= 7a61207b1d269a09462313ef3065d7bc1b54c9a14ae00f5006e169639674b230
HOST_PYTHON3_BABEL			:= babel-$(HOST_PYTHON3_BABEL_VERSION)
HOST_PYTHON3_BABEL_SUFFIX		:= tar.gz
HOST_PYTHON3_BABEL_URL			:= https://github.com/python-babel/babel/archive/$(HOST_PYTHON3_BABEL_VERSION).$(HOST_PYTHON3_BABEL_SUFFIX)
HOST_PYTHON3_BABEL_SOURCE		:= $(SRCDIR)/$(HOST_PYTHON3_BABEL).$(HOST_PYTHON3_BABEL_SUFFIX)
HOST_PYTHON3_BABEL_DIR			:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_BABEL)
HOST_PYTHON3_BABEL_LICENSE		:= BSD-3-Clause
HOST_PYTHON3_BABEL_LICENSE_FILES	:= file://LICENSE;md5=1b3f4650099e6d6a73e5a7fc8774ff18

HOST_PYTHON3_BABEL_CLDR_VERSION		:= 33
HOST_PYTHON3_BABEL_CLDR_SHA256		:= fa3490082c086d21257153609642f54fcf788fcfda4966fe67f3f6daca0d58b9
HOST_PYTHON3_BABEL_CLDR_URL		:= https://unicode.org/Public/cldr/$(HOST_PYTHON3_BABEL_CLDR_VERSION)/core.zip
HOST_PYTHON3_BABEL_CLDR_SOURCE		:= $(SRCDIR)/cldr-core-$(HOST_PYTHON3_BABEL_CLDR_VERSION).0.zip
HOST_PYTHON3_BABEL_CLDR_DIR		:= $(HOST_PYTHON3_BABEL_DIR)/cldr

HOST_PYTHON3_BABEL_PARTS		+= HOST_PYTHON3_BABEL_CLDR

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_BABEL_CONF_TOOL    := python3

$(STATEDIR)/host-python3-babel.prepare:
	@$(call targetinfo)
	@$(call world/execute, HOST_PYTHON3_BABEL, \
		$(HOSTPYTHON3) scripts/import_cldr.py $(HOST_PYTHON3_BABEL_CLDR_DIR))
	@$(call world/prepare, HOST_PYTHON3_BABEL)
	@$(call touch)

# vim: syntax=make
