# -*-makefile-*-
#
# Copyright (C) 2012 by Bernhard Sessler <bernhard.sessler@corscience.de>
#                       Corscience GmbH & Co. KG <info@corscience.de>, Germany
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LOG4CPLUS) += log4cplus

#
# Paths and names
#
LOG4CPLUS_VERSION	:= 1.2.2
LOG4CPLUS_MD5		:= cfe73421b5fe8e7ec06f084a163c8995
LOG4CPLUS		:= log4cplus-$(LOG4CPLUS_VERSION)
LOG4CPLUS_SUFFIX	:= tar.xz
LOG4CPLUS_URL		:= $(call ptx/mirror, SF, log4cplus/$(LOG4CPLUS).$(LOG4CPLUS_SUFFIX))
LOG4CPLUS_SOURCE	:= $(SRCDIR)/$(LOG4CPLUS).$(LOG4CPLUS_SUFFIX)
LOG4CPLUS_DIR		:= $(BUILDDIR)/$(LOG4CPLUS)
LOG4CPLUS_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LOG4CPLUS_CONF_TOOL	:= cmake

LOG4CPLUS_CONF_OPT	:= $(CROSS_CMAKE_USR)
LOG4CPLUS_CONF_OPT	+= \
	-DLOG4CPLUS_BUILD_TESTING=OFF \
	-DLOG4CPLUS_QT4=OFF

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/log4cplus.targetinstall:
	@$(call targetinfo)

	@$(call install_init, log4cplus)
	@$(call install_fixup, log4cplus, PRIORITY, optional)
	@$(call install_fixup, log4cplus, SECTION, base)
	@$(call install_fixup, log4cplus, AUTHOR, \
		"Bernhard Sessler <bernhard.sessler@corscience.de>")
	@$(call install_fixup, log4cplus,DESCRIPTION,missing)

	@$(call install_lib, log4cplus, 0, 0, 0644, liblog4cplus)
	@$(call install_copy, log4cplus, 0, 0, 0755, -, /usr/bin/loggingserver)

	@$(call install_finish, log4cplus)

	@$(call touch)

# vim: syntax=make
