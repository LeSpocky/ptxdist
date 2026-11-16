# -*-makefile-*-
#
# Copyright (C) 2012 by Wolfram Sang <w.sang@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSELINUX) += libselinux

#
# Paths and names
#
LIBSELINUX_VERSION	:= $(SELINUX_VERSION)
LIBSELINUX_SHA256	:= 73d419c6e20e874adaa4019372cbd097eecf4d276e13f27ec5e67d35c0bd203c
LIBSELINUX		:= libselinux-$(LIBSELINUX_VERSION)
LIBSELINUX_SUFFIX	:= tar.gz
LIBSELINUX_URL		:= $(SELINUX_URL)/$(LIBSELINUX).$(LIBSELINUX_SUFFIX)
LIBSELINUX_SOURCE	:= $(SRCDIR)/$(LIBSELINUX).$(LIBSELINUX_SUFFIX)
LIBSELINUX_DIR		:= $(BUILDDIR)/$(LIBSELINUX)
LIBSELINUX_LICENSE	:= public_domain
LIBSELINUX_LICENSE_FILES	:= file://LICENSE;md5=84b4d2c6ef954a2d4081e775a270d0d0
LIBSELINUX_CVE_PRODUCT	:= selinuxproject:libselinux

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBSELINUX_CONF_TOOL	:= NO
LIBSELINUX_MAKE_ENV	:= $(CROSS_ENV)
LIBSELINUX_MAKE_OPT	= \
	PREFIX=/usr \
	LIBDIR=/usr/lib \
	SHLIBDIR=/usr/lib \
	INCLUDEDIR=/usr/include \
	SBINDIR=/usr/sbin \
	USE_PCRE2=y \
	USE_LFS=y \
	DISABLE_SHARED=n \
	DISABLE_BOOL=n \
	DISABLE_SETRANS=n \
	DISABLE_RPM=n \
	DISABLE_X11=y \
	ANDROID_HOST=n \
	LABEL_BACKEND_ANDROID=n \
	CFLAGS="-O2 -Wall -g"

LIBSELINUX_INSTALL_OPT	= \
	$(LIBSELINUX_MAKE_OPT) \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

LIBSELINUX_PROGS-$(PTXCONF_LIBSELINUX_UTILS) := \
	avcstat \
	compute_av \
	compute_create \
	compute_member \
	compute_relabel \
	getconlist \
	getdefaultcon \
	getfilecon \
	getpidcon \
	getseuser \
	policyvers \
	sefcontext_compile \
	selinux_check_securetty_context \
	selinuxexeccon \
	setfilecon \
	togglesebool

LIBSELINUX_PROGS-$(PTXCONF_LIBSELINUX_GETENFORCE)	+= getenforce
LIBSELINUX_PROGS-$(PTXCONF_LIBSELINUX_GETSEBOOL)	+= getsebool
LIBSELINUX_PROGS-$(PTXCONF_LIBSELINUX_MATCHPATHCON)	+= matchpathcon
LIBSELINUX_PROGS-$(PTXCONF_LIBSELINUX_SELINUXENABLED)	+= selinuxenabled
LIBSELINUX_PROGS-$(PTXCONF_LIBSELINUX_SETENFORCE)	+= setenforce

$(STATEDIR)/libselinux.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libselinux)
	@$(call install_fixup, libselinux,PRIORITY,optional)
	@$(call install_fixup, libselinux,SECTION,base)
	@$(call install_fixup, libselinux,AUTHOR,"Wolfram Sang <w.sang@pengutronix.de>")
	@$(call install_fixup, libselinux,DESCRIPTION,missing)

	@$(call install_lib, libselinux, 0, 0, 0644, libselinux)

	@$(foreach prog, $(LIBSELINUX_PROGS-y), \
		$(call install_copy, libselinux, 0, 0, 0755, -, /usr/sbin/$(prog))$(ptx/nl))

	@$(call install_finish, libselinux)

	@$(call touch)

# vim: syntax=make
