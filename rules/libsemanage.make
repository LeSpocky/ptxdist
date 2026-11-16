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
PACKAGES-$(PTXCONF_LIBSEMANAGE) += libsemanage

#
# Paths and names
#
LIBSEMANAGE_VERSION	:= $(SELINUX_VERSION)
LIBSEMANAGE_SHA256	:= e76160286bbfb0821602c6c0c3220ebcf366ad3246d3b9d0a0fbefcd35e86043
LIBSEMANAGE		:= libsemanage-$(LIBSEMANAGE_VERSION)
LIBSEMANAGE_SUFFIX	:= tar.gz
LIBSEMANAGE_URL		:= $(SELINUX_URL)/$(LIBSEMANAGE).$(LIBSEMANAGE_SUFFIX)
LIBSEMANAGE_SOURCE	:= $(SRCDIR)/$(LIBSEMANAGE).$(LIBSEMANAGE_SUFFIX)
LIBSEMANAGE_DIR		:= $(BUILDDIR)/$(LIBSEMANAGE)
LIBSEMANAGE_LICENSE	:= LGPL-2.1-or-later
LIBSEMANAGE_LICENSE_FILES	:= file://LICENSE;md5=03068f550c635f6520e0f0252da412fc
LIBSEMANAGE_CVE_PRODUCT	:= selinuxproject:libsemanage

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBSEMANAGE_CONF_TOOL	:= NO
LIBSEMANAGE_MAKE_ENV	:= $(CROSS_ENV)
LIBSEMANAGE_MAKE_OPT	= \
	PREFIX=/usr \
	LIBDIR=/usr/lib \
	INCLUDEDIR=/usr/include \
	SYSCONFDIR=/etc \
	DISABLE_SHARED=n \
	CFLAGS="-O2 -Wall -g"

ifdef PTXCONF_LIBSEMANAGE_PYTHON
LIBSEMANAGE_MAKE_OPT	+= \
	PYTHON=$(CROSS_PYTHON3) \
	PYTHONLIBDIR=$(PYTHON3_SITEPACKAGES) \
	PYCEXT=$(shell $(CROSS_PYTHON3) -c 'import sysconfig; print(sysconfig.get_config_var("EXT_SUFFIX"))')
endif

LIBSEMANAGE_INSTALL_OPT	= \
	$(LIBSEMANAGE_MAKE_OPT) \
	install

ifdef PTXCONF_LIBSEMANAGE_PYTHON
LIBSEMANAGE_MAKE_OPT	+= pywrap
LIBSEMANAGE_INSTALL_OPT	+= install-pywrap
endif

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsemanage.install:
	@$(call targetinfo)
	@$(call world/install, LIBSEMANAGE)
ifdef PTXCONF_LIBSEMANAGE_PYTHON
	@$(CROSS_PYTHON3) -m compileall -q -d $(PYTHON3_SITEPACKAGES) \
		$(LIBSEMANAGE_PKGDIR)$(PYTHON3_SITEPACKAGES)
	@$(call world/env, LIBSEMANAGE) ptxd_make_world_install_python_cleanup
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsemanage.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsemanage)
	@$(call install_fixup, libsemanage,PRIORITY,optional)
	@$(call install_fixup, libsemanage,SECTION,base)
	@$(call install_fixup, libsemanage,AUTHOR,"Wolfram Sang <w.sang@pengutronix.de>")
	@$(call install_fixup, libsemanage,DESCRIPTION,missing)

	@$(call install_lib, libsemanage, 0, 0, 0644, libsemanage)
	@$(call install_alternative, libsemanage, 0, 0, 0644, /etc/selinux/semanage.conf)

ifdef PTXCONF_LIBSEMANAGE_PYTHON
	@$(call install_glob, libsemanage, 0, 0, -, $(PYTHON3_SITEPACKAGES),, *.py)
endif
	@$(call install_finish, libsemanage)

	@$(call touch)

# vim: syntax=make
