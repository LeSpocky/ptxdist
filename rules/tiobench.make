# -*-makefile-*-
#
# Copyright (C) 2009 by Juergen Beisert
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TIOBENCH) += tiobench

#
# Paths and names
#
TIOBENCH_VERSION	:= 0.3.3
TIOBENCH_MD5		:= bf485bf820e693c79e6bd2a38702a128
TIOBENCH		:= tiobench-$(TIOBENCH_VERSION)
TIOBENCH_SUFFIX		:= tar.gz
TIOBENCH_URL		:= $(call ptx/mirror, SF, tiobench/$(TIOBENCH).$(TIOBENCH_SUFFIX))
TIOBENCH_SOURCE		:= $(SRCDIR)/$(TIOBENCH).$(TIOBENCH_SUFFIX)
TIOBENCH_DIR		:= $(BUILDDIR)/$(TIOBENCH)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

TIOBENCH_ENV_TOOL	:= NO
TIOBENCH_MAKE_OPT	:= \
	$(CROSS_ENV_CC) \
	LINK=$(CROSS_CC)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tiobench.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tiobench.targetinstall:
	@$(call targetinfo)

	@$(call install_init, tiobench)
	@$(call install_fixup, tiobench,PRIORITY,optional)
	@$(call install_fixup, tiobench,SECTION,base)
	@$(call install_fixup, tiobench,AUTHOR,"Juergen Beisert <jbeisert@pengutronix.de>")
	@$(call install_fixup, tiobench,DESCRIPTION,missing)

	@$(call install_copy, tiobench, 0, 0, 0755, $(TIOBENCH_DIR)/tiotest, \
		/usr/bin/tiotest)

	@$(call install_finish, tiobench)

	@$(call touch)

# vim: syntax=make
