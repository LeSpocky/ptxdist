# -*-makefile-*-
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_JSON_C) += json-c

#
# Paths and names
#
JSON_C_VERSION		:= 0.19
JSON_C_SHA256		:= 37ad0249902e301bd9052bf712e511fcc6acff4ecaad4b5900aad9ce564e26de
JSON_C			:= json-c-$(JSON_C_VERSION)
JSON_C_SUFFIX		:= tar.gz
JSON_C_URL		:= https://s3.amazonaws.com/json-c_releases/releases/$(JSON_C).$(JSON_C_SUFFIX)
JSON_C_SOURCE		:= $(SRCDIR)/$(JSON_C).$(JSON_C_SUFFIX)
JSON_C_DIR		:= $(BUILDDIR)/$(JSON_C)
JSON_C_LICENSE		:= MIT
JSON_C_LICENSE_FILES	:= file://COPYING;md5=de54b60fbbc35123ba193fea8ee216f2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

JSON_C_CONF_TOOL	:= cmake
JSON_C_CONF_OPT		:= \
	$(CROSS_CMAKE_USR) \
	-DBUILD_APPS:BOOL=OFF \
	-DBUILD_SHARED_LIBS:BOOL=ON \
	-DBUILD_STATIC_LIBS:BOOL=OFF \
	-DBUILD_TESTING:BOOL=OFF \
	-DDISABLE_BSYMBOLIC:BOOL=ON \
	-DDISABLE_EXTRA_LIBS:BOOL=ON \
	-DDISABLE_JSON_PATCH=OFF \
	-DDISABLE_JSON_POINTER=OFF \
	-DDISABLE_THREAD_LOCAL_STORAGE=OFF \
	-DDISABLE_WERROR:BOOL=ON \
	-DENABLE_RDRAND:BOOL=OFF \
	-DENABLE_THREADING:BOOL=OFF \
	-DNEWLOCALE_NEEDS_FREELOCALE=OFF \
	-DOVERRIDE_GET_RANDOM_SEED=OFF

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/json-c.install:
	@$(call targetinfo)
	@$(call world/install, JSON_C)
	@ln -sv json-c.pc $(JSON_C_PKGDIR)/usr/lib/pkgconfig/json.pc
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/json-c.targetinstall:
	@$(call targetinfo)

	@$(call install_init, json-c)
	@$(call install_fixup, json-c,PRIORITY,optional)
	@$(call install_fixup, json-c,SECTION,base)
	@$(call install_fixup, json-c,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, json-c,DESCRIPTION,missing)

	@$(call install_lib, json-c, 0, 0, 0644, libjson-c)

	@$(call install_finish, json-c)

	@$(call touch)

# vim: ft=make noet
