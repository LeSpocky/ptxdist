# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LSOF) += lsof

#
# Paths and names
#
LSOF_VERSION	:= 4.99.3
LSOF_MD5	:= 0fa5cfcaaca77a2fb3579c17de016353
LSOF_SUFFIX	:= tar.gz
LSOF		:= lsof-$(LSOF_VERSION)
LSOF_URL	:= https://github.com/lsof-org/lsof/releases/download/$(LSOF_VERSION)/$(LSOF).$(LSOF_SUFFIX)
LSOF_SOURCE	:= $(SRCDIR)/$(LSOF).$(LSOF_SUFFIX)
LSOF_DIR	:= $(BUILDDIR)/$(LSOF)
LSOF_LICENSE	:= custom
LSOF_LICENSE_FILES	:= file://00README;startline=633;endline=664;md5=3161a245910921b0f58644299e268d39

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LSOF_CONF_TOOL	:= autoconf
LSOF_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-liblsof \
	--enable-security \
	--disable-no-sock-security \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--with-libtirpc  \
	--without-selinux


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lsof.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lsof)
	@$(call install_fixup, lsof,PRIORITY,optional)
	@$(call install_fixup, lsof,SECTION,base)
	@$(call install_fixup, lsof,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, lsof,DESCRIPTION,missing)

	@$(call install_copy, lsof, 0, 0, 0755, -, /usr/bin/lsof)

	@$(call install_finish, lsof)

	@$(call touch)

# vim: syntax=make
