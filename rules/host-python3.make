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

HOSTPYTHON3		= $(PTXDIST_SYSROOT_HOST)/usr/bin/python$(PYTHON3_MAJORMINOR)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# Note: the LDFLAGS are used by setup.py for manual searches
HOST_PYTHON3_CONF_ENV	:= \
	$(HOST_ENV) \
	ac_sys_system=Linux \
	ac_sys_release=2 \
	MACHDEP=linux \
	LDFLAGS="-L$(PTXDIST_SYSROOT_HOST)/usr/lib"

#
# autoconf
#
HOST_PYTHON3_CONF_TOOL	:= autoconf
# The include path is added to _sysconfigdata_*.py by parsing Makefile
# Needed for setup.py to find things in sysroot-host
HOST_PYTHON3_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
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
	--with-openssl=$(PTXDIST_SYSROOT_HOST)/usr

$(STATEDIR)/host-python3.prepare:
	@$(call targetinfo)
	@$(call world/prepare, HOST_PYTHON3)
#	# make sure SOABI for host and target never match
#	# make sure libffi is detected correctly
	@sed -i \
		-e 's;\(\(EXT_SUFFIX\|SOABI\)=.*\)linux-gnu\>;\1host-gnu;' \
		-e "s;LIBFFI_INCLUDEDIR=*;LIBFFI_INCLUDEDIR=$(PTXDIST_SYSROOT_HOST)/usr/include;" \
		$(HOST_PYTHON3_DIR)/Makefile
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-python3.install:
	@$(call targetinfo)
	@$(call world/install, HOST_PYTHON3)
#
# remove "python" so that it doesn't interfere with the build
# machine's python
#
# the target build process will only use python with the
# python-$(PYTHON3_MAJORMINOR)
#
	@rm -v \
		"$(HOST_PYTHON3_PKGDIR)/usr/bin/python3" \
		"$(HOST_PYTHON3_PKGDIR)/usr/bin/python3-config"
	@sed -i \
		-e "s;\([' ]\)\(/usr/include\);\1$(PTXDIST_SYSROOT_HOST)\2;g" \
		$(HOST_PYTHON3_PKGDIR)/usr/lib/python$(PYTHON3_MAJORMINOR)/_sysconfigdata_*-linux-gnu.py
	@$(call touch)

# vim: syntax=make
