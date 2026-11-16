# -*-makefile-*-
#
# Copyright (C) 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SELINUX_PYTHON) += selinux-python

#
# Paths and names
#
SELINUX_PYTHON_VERSION	:= $(SELINUX_VERSION)
SELINUX_PYTHON_SHA256	:= f854d7fe67981d80c612067e97c1804f641a9dfcca2d38baeb3efe52b7875398
SELINUX_PYTHON		:= selinux-python-$(SELINUX_PYTHON_VERSION)
SELINUX_PYTHON_SUFFIX	:= tar.gz
SELINUX_PYTHON_URL	:= $(SELINUX_URL)/$(SELINUX_PYTHON).$(SELINUX_PYTHON_SUFFIX)
SELINUX_PYTHON_SOURCE	:= $(SRCDIR)/$(SELINUX_PYTHON).$(SELINUX_PYTHON_SUFFIX)
SELINUX_PYTHON_DIR	:= $(BUILDDIR)/$(SELINUX_PYTHON)
SELINUX_PYTHON_LICENSE	:= GPL-2.0-only
SELINUX_PYTHON_LICENSE_FILES	:= file://LICENSE;md5=393a5ca445f6965873eca0259a17f833

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SELINUX_PYTHON_CONF_TOOL	:= NO
SELINUX_PYTHON_MAKE_ENV		:= $(CROSS_ENV)
SELINUX_PYTHON_MAKE_OPT		= \
	SUBDIRS="sepolgen audit2allow" \
	PREFIX=/usr \
	BINDIR=/usr/bin \
	PYTHON=$(CROSS_PYTHON3) \
	PYTHONLIBDIR=$(PYTHON3_SITEPACKAGES) \
	CFLAGS="-O2 -Wall -g"
SELINUX_PYTHON_INSTALL_OPT	= \
	$(SELINUX_PYTHON_MAKE_OPT) \
	install

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/selinux-python.install:
	@$(call targetinfo)
	@$(call world/install, SELINUX_PYTHON)
	@$(CROSS_PYTHON3) -m compileall -q -d $(PYTHON3_SITEPACKAGES) \
		$(SELINUX_PYTHON_PKGDIR)$(PYTHON3_SITEPACKAGES)
	@$(call world/env, SELINUX_PYTHON) ptxd_make_world_install_python_cleanup
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/selinux-python.targetinstall:
	@$(call targetinfo)

	@$(call install_init, selinux-python)
	@$(call install_fixup, selinux-python,PRIORITY,optional)
	@$(call install_fixup, selinux-python,SECTION,base)
	@$(call install_fixup, selinux-python,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, selinux-python,DESCRIPTION,missing)

	@$(call install_glob, selinux-python, 0, 0, -, $(PYTHON3_SITEPACKAGES),, *.py)
	@$(call install_alternative, selinux-python, 0, 0, 0644, /var/lib/sepolgen/perm_map)
	@$(call install_copy, selinux-python, 0, 0, 0755, -, /usr/bin/audit2allow)
	@$(call install_link, selinux-python, audit2allow, /usr/bin/audit2why)
	@$(call install_copy, selinux-python, 0, 0, 0755, -, /usr/bin/sepolgen-ifgen)
	@$(call install_copy, selinux-python, 0, 0, 0755, -, /usr/bin/sepolgen-ifgen-attr-helper)

	@$(call install_finish, selinux-python)

	@$(call touch)

# vim: syntax=make
