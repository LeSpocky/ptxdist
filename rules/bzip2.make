# -*-makefile-*-
#
# Copyright (C) 2009 by Luotao Fu <l.fu@pengutronix.de>
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BZIP2) += bzip2

#
# Paths and names
#
BZIP2_VERSION	:= 1.0.8
BZIP2_MD5	:= 67e051268d0c475ea773822f7500d0e5
BZIP2		:= bzip2-$(BZIP2_VERSION)
BZIP2_SUFFIX	:= tar.gz
BZIP2_URL	:= \
	https://sourceware.org/pub/bzip2/$(BZIP2).$(BZIP2_SUFFIX) \
	https://distfiles.gentoo.org/distfiles/$(BZIP2).$(BZIP2_SUFFIX)
BZIP2_SOURCE	:= $(SRCDIR)/$(BZIP2).$(BZIP2_SUFFIX)
BZIP2_DIR	:= $(BUILDDIR)/$(BZIP2)
BZIP2_LICENSE	:= bzip2-1.0.6
BZIP2_LICENSE_FILES	:= file://LICENSE;md5=1e5cffe65fc786f83a11a4b225495c0b

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BZIP2_MAKE_OPT		:= $(CROSS_ENV)
BZIP2_INSTALL_OPT	:= PREFIX=/usr install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bzip2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bzip2)
	@$(call install_fixup, bzip2,PRIORITY,optional)
	@$(call install_fixup, bzip2,SECTION,base)
	@$(call install_fixup, bzip2,AUTHOR,"Luotao Fu <l.fu@pengutronix.de>")
	@$(call install_fixup, bzip2,DESCRIPTION,missing)

ifdef PTXCONF_BZIP2_LIBBZ2
	@$(call install_lib, bzip2, 0, 0, 0644, libbz2)
endif

ifdef PTXCONF_BZIP2_BZIP2
	@$(call install_copy, bzip2, 0, 0, 0755, -, /usr/bin/bzip2)
endif

ifdef PTXCONF_BZIP2_BZIP2RECOVER
	@$(call install_copy, bzip2, 0, 0, 0755, -, /usr/bin/bzip2recover)
endif

	@$(call install_finish, bzip2)

	@$(call touch)

# vim: syntax=make
