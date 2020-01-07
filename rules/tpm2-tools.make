# -*-makefile-*-
#
# Copyright (C) 2017 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TPM2_TOOLS) += tpm2-tools

#
# Paths and names
#
TPM2_TOOLS_VERSION		:= 4.1
TPM2_TOOLS_MD5			:= aecec22668233776922909f2ebf55e65
TPM2_TOOLS			:= tpm2-tools-$(TPM2_TOOLS_VERSION)
TPM2_TOOLS_SUFFIX		:= tar.gz
TPM2_TOOLS_URL			:= https://github.com/tpm2-software/tpm2-tools/releases/download/$(TPM2_TOOLS_VERSION)/$(TPM2_TOOLS).$(TPM2_TOOLS_SUFFIX)
TPM2_TOOLS_SOURCE		:= $(SRCDIR)/$(TPM2_TOOLS).$(TPM2_TOOLS_SUFFIX)
TPM2_TOOLS_DIR			:= $(BUILDDIR)/$(TPM2_TOOLS)
TPM2_TOOLS_LICENSE		:= BSD-3-Clause
TPM2_TOOLS_LICENSE_FILES	:= file://LICENSE;md5=0eb1216e46938bd723098d93a23c3bcc

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
TPM2_TOOLS_CONF_TOOL	:= autoconf
TPM2_TOOLS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-debug=info \
	--disable-code-coverage \
	--disable-unit \
	--enable-hardening \
	--without-gcov \
	--without-bashcompdir

TPM2_TOOLS_CFLAGS	:= \
	-fPIC

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

TPM2_TOOLS_PROGS := \
	tpm2_activatecredential \
	tpm2_certify \
	tpm2_certifycreation \
	tpm2_changeauth \
	tpm2_changeeps \
	tpm2_changepps \
	tpm2_checkquote \
	tpm2_clear \
	tpm2_clearcontrol \
	tpm2_clockrateadjust \
	tpm2_create \
	tpm2_createak \
	tpm2_createek \
	tpm2_createpolicy \
	tpm2_createprimary \
	tpm2_dictionarylockout \
	tpm2_duplicate \
	tpm2_encryptdecrypt \
	tpm2_evictcontrol \
	tpm2_flushcontext \
	tpm2_getcap \
	tpm2_getekcertificate \
	tpm2_getrandom \
	tpm2_gettestresult \
	tpm2_gettime \
	tpm2_hash \
	tpm2_hierarchycontrol \
	tpm2_hmac \
	tpm2_import \
	tpm2_incrementalselftest \
	tpm2_load \
	tpm2_loadexternal \
	tpm2_makecredential \
	tpm2_nvcertify \
	tpm2_nvdefine \
	tpm2_nvextend \
	tpm2_nvincrement \
	tpm2_nvread \
	tpm2_nvreadlock \
	tpm2_nvreadpublic \
	tpm2_nvsetbits \
	tpm2_nvundefine \
	tpm2_nvwrite \
	tpm2_nvwritelock \
	tpm2_pcrallocate \
	tpm2_pcrevent \
	tpm2_pcrextend \
	tpm2_pcrread \
	tpm2_pcrreset \
	tpm2_policyauthorize \
	tpm2_policyauthorizenv \
	tpm2_policyauthvalue \
	tpm2_policycommandcode \
	tpm2_policycountertimer \
	tpm2_policyduplicationselect \
	tpm2_policylocality \
	tpm2_policynamehash \
	tpm2_policynv \
	tpm2_policynvwritten \
	tpm2_policyor \
	tpm2_policypassword \
	tpm2_policypcr \
	tpm2_policyrestart \
	tpm2_policysecret \
	tpm2_policysigned \
	tpm2_policytemplate \
	tpm2_policyticket \
	tpm2_print \
	tpm2_quote \
	tpm2_rc_decode \
	tpm2_readclock \
	tpm2_readpublic \
	tpm2_rsadecrypt \
	tpm2_rsaencrypt \
	tpm2_selftest \
	tpm2_send \
	tpm2_setclock \
	tpm2_setprimarypolicy \
	tpm2_shutdown \
	tpm2_sign \
	tpm2_startauthsession \
	tpm2_startup \
	tpm2_stirrandom \
	tpm2_testparms \
	tpm2_unseal \
	tpm2_verifysignature

$(STATEDIR)/tpm2-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, tpm2-tools)
	@$(call install_fixup, tpm2-tools,PRIORITY,optional)
	@$(call install_fixup, tpm2-tools,SECTION,base)
	@$(call install_fixup, tpm2-tools,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, tpm2-tools,DESCRIPTION,missing)

	@$(foreach prog, $(TPM2_TOOLS_PROGS), \
                $(call install_copy, tpm2-tools, 0, 0, 0755, -, /usr/bin/$(prog))$(ptx/nl))

	@$(call install_finish, tpm2-tools)

	@$(call touch)

# vim: syntax=make
