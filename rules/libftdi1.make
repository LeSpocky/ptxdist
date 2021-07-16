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
LIBFTDI1_VERSION	:= 1.5
LIBFTDI1_MD5		:= f515d7d69170a9afc8b273e8f1466a80
LIBFTDI1		:= libftdi1-$(LIBFTDI1_VERSION)
LIBFTDI1_SUFFIX		:= tar.bz2
LIBFTDI1_URL		:= http://www.intra2net.com/en/developer/libftdi/download/$(LIBFTDI1).$(LIBFTDI1_SUFFIX)
LIBFTDI1_SOURCE		:= $(SRCDIR)/$(LIBFTDI1).$(LIBFTDI1_SUFFIX)
LIBFTDI1_DIR		:= $(BUILDDIR)/$(LIBFTDI1)
LIBFTDI1_LICENSE	:= LGPL-2.1-only AND MIT AND GPL-2.0-only
LIBFTDI1_LICENSE_FILES	:= \
	file://src/ftdi_stream.c;startline=1;endline=42;md5=70e75477d06286017f028e090f046c58 \
	file://COPYING.LIB;md5=5f30f0716dfdd0d91eb439ebec522ec2 \
	file://ftdi_eeprom/main.c;startline=1;endline=14;md5=509ee2023e37c596c5b782fe223636c3 \
	file://COPYING.GPL;md5=751419260aa954499f7abaabaa882bbe


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
	-DBUILD_TESTS=OFF \
	-DDOCUMENTATION=OFF \
	-DEXAMPLES=$(call ptx/onoff, PTXCONF_LIBFTDI1_EXAMPLES) \
	-DFTDIPP=$(call ptx/onoff, PTXCONF_LIBFTDI1_CPP_WRAPPER) \
	-DFTDI_EEPROM=$(call ptx/onoff, PTXCONF_LIBFTDI1_FTDI_EEPROM) \
	-DLINK_PYTHON_LIBRARY=OFF \
	-DPYTHON_BINDINGS=OFF \
	-DSTATICLIBS=OFF

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
