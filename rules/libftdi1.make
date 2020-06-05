# -*-makefile-*-
#
# Copyright (C) 2013 by Andreas Helmcke <ahe@helmcke.name>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBFTDI1) += libftdi1

#
# Paths and names
#
LIBFTDI1_VERSION	:= 1.4
LIBFTDI1_MD5		:= 0c09fb2bb19a57c839fa6845c6c780a2
LIBFTDI1		:= libftdi1-$(LIBFTDI1_VERSION)
LIBFTDI1_SUFFIX		:= tar.bz2
LIBFTDI1_URL		:= http://www.intra2net.com/en/developer/libftdi/download/$(LIBFTDI1).$(LIBFTDI1_SUFFIX)
LIBFTDI1_SOURCE		:= $(SRCDIR)/$(LIBFTDI1).$(LIBFTDI1_SUFFIX)
LIBFTDI1_DIR		:= $(BUILDDIR)/$(LIBFTDI1)
LIBFTDI1_LICENSE	:= LGPL-2.1-only
ifdef PTXCONF_LIBFTDI1_EXAMPLES
LIBFTDI1_DEVPKG		:= NO
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
LIBFTDI1_CONF_TOOL	:= cmake
LIBFTDI1_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DCMAKE_SKIP_RPATH=ON \
	-DDOCUMENTATION=OFF \
	-DPYTHON_BINDINGS=OFF \
	-DSTATICLIBS=OFF \
	-DEXAMPLES=$(call ptx/onoff, PTXCONF_LIBFTDI1_EXAMPLES) \
	-DFTDIPP=$(call ptx/onoff, PTXCONF_LIBFTDI1_CPP_WRAPPER) \
	-DFTDI_EEPROM=$(call ptx/onoff, PTXCONF_LIBFTDI1_FTDI_EEPROM)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libftdi1.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libftdi1)
	@$(call install_fixup, libftdi1, PRIORITY, optional)
	@$(call install_fixup, libftdi1, SECTION, base)
	@$(call install_fixup, libftdi1, AUTHOR, "Andreas Helmcke <ahe@helmcke.name>")
	@$(call install_fixup, libftdi1, DESCRIPTION, missing)

ifdef PTXCONF_LIBFTDI1_EXAMPLES
	@cd $(LIBFTDI1_DIR)-build/examples && \
	for i in `find . -maxdepth 1 -type f -executable -printf "%f\n"`; do \
		$(call install_copy, libftdi1, 0, 0, 0755, \
			$(LIBFTDI1_DIR)-build/examples/$$i, \
			/usr/bin/libftdi1/$$i); \
	done

endif

ifdef PTXCONF_LIBFTDI1_FTDI_EEPROM
	@$(call install_copy, libftdi1, 0, 0, 0755, -, /usr/bin/ftdi_eeprom)
endif

	@$(call install_lib, libftdi1, 0, 0, 0644, libftdi1)

ifdef PTXCONF_LIBFTDI1_CPP_WRAPPER
	@$(call install_lib, libftdi1, 0, 0, 0644, libftdipp1)
endif

	@$(call install_finish, libftdi1)

	@$(call touch)

# vim: syntax=make
