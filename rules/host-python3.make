# -*-makefile-*-
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3) += host-python3

#
# Paths and names
#
HOST_PYTHON3_DIR	= $(HOST_BUILDDIR)/$(PYTHON3)

HOSTPYTHON3		= $(PTXDIST_SYSROOT_HOST)/bin/python$(PYTHON3_MAJORMINOR)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# Note: the LDFLAGS are used by setup.py for manual searches
HOST_PYTHON3_ENV	:= \
	$(HOST_ENV) \
	ac_sys_system=Linux \
	ac_sys_release=2 \
	MACHDEP=linux \
	LDFLAGS="-L$(PTXDIST_SYSROOT_HOST)/lib"

#
# autoconf
#
HOST_PYTHON3_CONF_TOOL	:= autoconf
# The include path is added to _sysconfigdata_*.py by parsing Makefile
# Needed for setup.py to find things in sysroot-host
HOST_PYTHON3_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--includedir=$(PTXDIST_SYSROOT_HOST)/include \
	--enable-shared \
	--disable-profiling \
	--disable-optimizations \
	--disable-loadable-sqlite-extensions \
	--without-pydebug \
	--without-assertions \
	--without-lto \
	--with-system-expat \
	--without-system-libmpdec \
	--with-dbmliborder= \
	--without-doc-strings \
	--with-pymalloc \
	--with-c-locale-coercion \
	--without-valgrind \
	--without-dtrace \
	--with-computed-gotos \
	--without-ensurepip \
	--with-openssl=$(PTXDIST_SYSROOT_HOST)

$(STATEDIR)/host-python3.prepare:
	@$(call targetinfo)
	@$(call world/prepare, HOST_PYTHON3)
#	# make sure SOABI for host and target never match
	@sed -i 's;\(\(EXT_SUFFIX\|SOABI\)=.*\)linux-gnu\>;\1host-gnu;' \
		$(HOST_PYTHON3_DIR)/Makefile
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

# reset INCLUDEDIR for the installation
HOST_PYTHON3_INSTALL_OPT := \
	INCLUDEDIR=/include \
	install

$(STATEDIR)/host-python3.install:
	@$(call targetinfo)
	@$(call install, HOST_PYTHON3,,h)
#
# remove "python" so that it doesn't interfere with the build
# machine's python
#
# the target build proces will only use python with the
# python-$(PYTHON3_MAJORMINOR)
#
	@rm -v \
		"$(HOST_PYTHON3_PKGDIR)/bin/python3" \
		"$(HOST_PYTHON3_PKGDIR)/bin/python3-config"
	@$(call touch)

$(STATEDIR)/host-python3.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_PYTHON3)
	@sed -i 's;prefix_build="";prefix_build="$(PTXDIST_SYSROOT_HOST)";' \
		$(PTXDIST_SYSROOT_HOST)/bin/python3*-config
	@$(call touch)

# vim: syntax=make
