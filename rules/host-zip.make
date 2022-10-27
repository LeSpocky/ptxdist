# -*-makefile-*-
#
# Copyright (C) 2022 by Thorsten Scherer <t.scherer@eckelmann.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_ZIP) += host-zip

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_ZIP_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

HOST_ZIP_MAKE_OPT	:= \
    -f unix/Makefile generic

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

# Use = instead of := because host-zip.make being included before zip.make
HOST_ZIP_INSTALL_OPT	= \
    $(HOST_ENV) \
    prefix=$(HOST_ZIP_PKGDIR)/usr \
    -f unix/Makefile install

# vim: syntax=make
