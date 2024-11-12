# -*-makefile-*-
#
# Copyright (C) 2022 Ladislav Michl <ladis@linux-mips.org>
# Copyright (C) 2023 Christian Melki <christian.melki@t2data.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DTC) += dtc

#
# Paths and names
#
DTC_VERSION	:= 1.7.2
DTC_MD5		:= a35aefd37cab86013a10ebdfc599f0c4
DTC		:= dtc-$(DTC_VERSION)
DTC_SUFFIX	:= tar.gz
DTC_URL		:= https://git.kernel.org/pub/scm/utils/dtc/dtc.git/snapshot/$(DTC).$(DTC_SUFFIX)
DTC_SOURCE	:= $(SRCDIR)/$(DTC).$(DTC_SUFFIX)
DTC_DIR		:= $(BUILDDIR)/$(DTC)
DTC_LICENSE	:= GPL-2.0-or-later OR BSD-2-Clause
DTC_LICENSE_FILES := \
	file://README.license;md5=a1eb22e37f09df5b5511b8a278992d0e \
	file://GPL;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
	file://BSD-2-Clause;md5=5d6306d1b08f8df623178dfd81880927

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DTC_CONF_TOOL	:= NO

DTC_MAKE_ENV	:= $(CROSS_ENV)

DTC_MAKE_OPT	:= \
	PREFIX=/usr \
	NO_PYTHON=1 \
	NO_VALGRIND=1 \
	NO_YAML=1

DTC_INSTALL_OPT	:= \
	$(DTC_MAKE_OPT) \
	install-bin \
	install-includes \
	install-lib

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

DTC_BIN-y				:=
DTC_BIN-$(PTXCONF_DTC_DTC)		+= dtc
DTC_BIN-$(PTXCONF_DTC_DTDIFF)		+= dtdiff
DTC_BIN-$(PTXCONF_DTC_FDTDUMP)		+= fdtdump
DTC_BIN-$(PTXCONF_DTC_FDTGET)		+= fdtget
DTC_BIN-$(PTXCONF_DTC_FDTOVERLAY)	+= fdtoverlay
DTC_BIN-$(PTXCONF_DTC_FDTPUT)		+= fdtput

$(STATEDIR)/dtc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dtc)
	@$(call install_fixup, dtc,PRIORITY,optional)
	@$(call install_fixup, dtc,SECTION,base)
	@$(call install_fixup, dtc,AUTHOR,"Ladislav Michl <ladis@linux-mips.org>")
	@$(call install_fixup, dtc,DESCRIPTION,missing)

	@$(call install_lib, dtc, 0, 0, 0644, libfdt)

	@$(foreach tool, $(DTC_BIN-y), \
		$(call install_copy, dtc, 0, 0, 0755, -, \
			/usr/bin/$(tool))$(ptx/nl))

	@$(call install_finish, dtc)

	@$(call touch)

# vim: syntax=make
