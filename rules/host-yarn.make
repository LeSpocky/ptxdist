# -*-makefile-*-
#
# Copyright (C) 2017 by Juergen Borleis <jbe@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#
# 2019-May-05, Daniel Arnold, Updated to yarn 1.15.2
# 2020-January-09, Björn Esser, Updated to yarn 1.21.1

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_YARN) += host-yarn

#
# Paths and names
#
HOST_YARN_VERSION	:= 1.21.1
HOST_YARN_MD5		:= cf49e663e0f56aa15f1740c77354ebe2
HOST_YARN		:= yarn-$(HOST_YARN_VERSION)
HOST_YARN_SUFFIX	:= js
HOST_YARN_URL		:= https://github.com/yarnpkg/yarn/releases/download/v$(HOST_YARN_VERSION)/$(HOST_YARN).$(HOST_YARN_SUFFIX)
HOST_YARN_SOURCE	:= $(SRCDIR)/$(HOST_YARN).$(HOST_YARN_SUFFIX)
HOST_YARN_LICENSE	:= BSD-2-Clause

# ----------------------------------------------------------------------------
# Extract (nothing to be done here)
# ----------------------------------------------------------------------------

$(STATEDIR)/host-yarn.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare (nothing to be done here)
# ----------------------------------------------------------------------------

$(STATEDIR)/host-yarn.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile (nothing to be done here)
# ----------------------------------------------------------------------------

$(STATEDIR)/host-yarn.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-yarn.install:
	@$(call targetinfo)
	@$(call world/execute, HOST_YARN, \
		install -vDm 0755 $(HOST_YARN_SOURCE) \
		$(HOST_YARN_PKGDIR)/bin/yarn)
	@$(call touch)

# vim: syntax=make
