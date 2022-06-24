# -*-makefile-*-
#
# Copyright (C) 2022 by Enrico Joerns <e.joerns@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_IDNA_SSL) += python3-idna-ssl

#
# Paths and names
#
PYTHON3_IDNA_SSL_VERSION	:= 1.1.0
PYTHON3_IDNA_SSL_MD5		:= dd44ec53bac36e68446766fd8d3835bd
PYTHON3_IDNA_SSL		:= idna-ssl-$(PYTHON3_IDNA_SSL_VERSION)
PYTHON3_IDNA_SSL_SUFFIX		:= tar.gz
PYTHON3_IDNA_SSL_URL		:= https://pypi.python.org/packages/source/i/idna_ssl/$(PYTHON3_IDNA_SSL).$(PYTHON3_IDNA_SSL_SUFFIX)
PYTHON3_IDNA_SSL_SOURCE		:= $(SRCDIR)/$(PYTHON3_IDNA_SSL).$(PYTHON3_IDNA_SSL_SUFFIX)
PYTHON3_IDNA_SSL_DIR		:= $(BUILDDIR)/$(PYTHON3_IDNA_SSL)
PYTHON3_IDNA_SSL_LICENSE	:= MIT
PYTHON3_ATTRS_LICENSE_FILES := \
	file://LICENSE;md5=d4ab25949a73fe7d4fdee93bcbdbf8ff

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

PYTHON3_IDNA_SSL_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-idna-ssl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-idna-ssl)
	@$(call install_fixup, python3-idna-ssl,PRIORITY,optional)
	@$(call install_fixup, python3-idna-ssl,SECTION,base)
	@$(call install_fixup, python3-idna-ssl,AUTHOR,"Enrico Joerns <e.joerns@pengutronix.de>")
	@$(call install_fixup, python3-idna-ssl,DESCRIPTION,missing)

	@$(call install_copy, python3-idna-ssl, 0, 0, 0644, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/idna_ssl.py)

	@$(call install_finish, python3-idna-ssl)

	@$(call touch)

# vim: syntax=make
