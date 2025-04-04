# -*-makefile-*-
#
# Copyright (C) 2018 by Juergen Borleis <jbe@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SOFTHSM) += softhsm

#
# Paths and names
#
SOFTHSM_VERSION	:= 2.6.1
SOFTHSM_MD5	:= 040b93ca327cbe0a3a8661e7c371ab16 2f6f21d859ad08fec55c61bb4e1747c4
SOFTHSM		:= softhsm-$(SOFTHSM_VERSION)
SOFTHSM_SUFFIX	:= tar.gz
SOFTHSM_URL	:= https://github.com/softhsm/SoftHSMv2/archive/refs/tags/$(SOFTHSM_VERSION).$(SOFTHSM_SUFFIX)
SOFTHSM_SOURCE	:= $(SRCDIR)/$(SOFTHSM).$(SOFTHSM_SUFFIX)
SOFTHSM_DIR	:= $(BUILDDIR)/$(SOFTHSM)
SOFTHSM_LICENSE	:= BSD-2-Clause
SOFTHSM_LICENSE_FILES	:= file://LICENSE;md5=ef3f77a3507c3d91e75b9f2bdaee4210

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
SOFTHSM_CONF_TOOL	:= autoconf
SOFTHSM_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-non-paged-memory \
	--disable-gost \
	--with-crypto-backend=openssl \
	--with-objectstore-backend-db \
	--with-migrate \
	--with-sqlite3=$(SYSROOT)/usr \
	--$(call ptx/endis, PTXCONF_SOFTHSM_P11_KIT)-p11-kit \
	--with-p11-kit=/usr/share/p11-kit/modules

SOFTHSM_CPPFLAGS := \
	-DDEBUG_LOG_STDERR=1

$(STATEDIR)/softhsm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, softhsm)
	@$(call install_fixup, softhsm,PRIORITY,optional)
	@$(call install_fixup, softhsm,SECTION,base)
	@$(call install_fixup, softhsm,AUTHOR,"Rouven Czerwinski <r.czerwinski@pengutronix.de>")
	@$(call install_fixup, softhsm,DESCRIPTION,missing)

	@$(call install_copy, softhsm, 0, 0, 0755, -, /usr/bin/softhsm2-dump-db)
	@$(call install_copy, softhsm, 0, 0, 0755, -, /usr/bin/softhsm2-dump-file)
	@$(call install_copy, softhsm, 0, 0, 0755, -, /usr/bin/softhsm2-keyconv)
	@$(call install_copy, softhsm, 0, 0, 0755, -, /usr/bin/softhsm2-util)

	@$(call install_copy, softhsm, 0, 0, 0755, -, /usr/lib/softhsm/libsofthsm2.so)

	@$(call install_copy, softhsm, 0, 0, 0644, -, /etc/softhsm2.conf)

ifdef PTXCONF_SOFTHSM_P11_KIT
	@$(call install_copy, softhsm, 0, 0, 0644, -, /usr/share/p11-kit/modules/softhsm2.module)
endif

	@$(call install_finish, softhsm)

	@$(call touch)

# vim: syntax=make
# vim: syntax=make
