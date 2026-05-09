# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TRACE_CMD) += trace-cmd

#
# Paths and names
#
TRACE_CMD_VERSION	:= 3.3.1
TRACE_CMD_SHA256	:= 2efe103389367e93c764c4a788880ba51018a65dec21b0411965a5f06a6338c1
TRACE_CMD		:= trace-cmd-v$(TRACE_CMD_VERSION)
TRACE_CMD_SUFFIX	:= tar.gz
TRACE_CMD_URL		:= https://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git/snapshot/$(TRACE_CMD).$(TRACE_CMD_SUFFIX)
TRACE_CMD_SOURCE	:= $(SRCDIR)/$(TRACE_CMD).$(TRACE_CMD_SUFFIX)
TRACE_CMD_DIR		:= $(BUILDDIR)/$(TRACE_CMD)
TRACE_CMD_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

TRACE_CMD_CONF_TOOL	:= meson

TRACE_CMD_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Ddoc=false \
	-Dptrace=false \
	-Dpython=false \
	-Dutest=false \
	-Dvsock=false

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/trace-cmd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, trace-cmd)
	@$(call install_fixup, trace-cmd,PRIORITY,optional)
	@$(call install_fixup, trace-cmd,SECTION,base)
	@$(call install_fixup, trace-cmd,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, trace-cmd,DESCRIPTION,missing)

	@$(call install_copy, trace-cmd, 0, 0, 0755, -, /usr/bin/trace-cmd)

	@$(call install_finish, trace-cmd)

	@$(call touch)

# vim: syntax=make
