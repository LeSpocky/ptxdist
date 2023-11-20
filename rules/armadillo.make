# -*-makefile-*-
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARMADILLO) += armadillo

#
# Paths and names
#
ARMADILLO_VERSION	:= 12.6.6
ARMADILLO_MD5		:= 79925f9cf0c7276fd4f120b978a3ef3c
ARMADILLO		:= armadillo-$(ARMADILLO_VERSION)
ARMADILLO_SUFFIX	:= tar.xz
ARMADILLO_URL		:= https://sourceforge.net/projects/arma/files/$(ARMADILLO).$(ARMADILLO_SUFFIX)
ARMADILLO_SOURCE	:= $(SRCDIR)/$(ARMADILLO).$(ARMADILLO_SUFFIX)
ARMADILLO_DIR		:= $(BUILDDIR)/$(ARMADILLO)
ARMADILLO_LICENSE	:= Apache-2.0
ARMADILLO_LICENSE_FILES	:= \
	file://LICENSE.txt;md5=d273d63619c9aeaf15cdaf76422c4f87

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
ARMADILLO_CONF_TOOL	:= cmake
ARMADILLO_CONF_OPT	:=  \
	$(CROSS_CMAKE_USR) \
	-DALLOW_FLEXIBLAS_LINUX=OFF \
	-DBUILD_SHARED_LIBS=ON \
	-DBUILD_SMOKE_TEST=OFF \
	-DOPENBLAS_PROVIDES_LAPACK=ON

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/armadillo.targetinstall:
	@$(call targetinfo)

	@$(call install_init, armadillo)
	@$(call install_fixup, armadillo,PRIORITY,optional)
	@$(call install_fixup, armadillo,SECTION,base)
	@$(call install_fixup, armadillo,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, armadillo,DESCRIPTION,missing)

	@$(call install_lib, armadillo, 0, 0, 0644, libarmadillo)

	@$(call install_finish, armadillo)

	@$(call touch)

# vim: syntax=make
