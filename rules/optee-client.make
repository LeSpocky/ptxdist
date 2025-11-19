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
PACKAGES-$(PTXCONF_OPTEE_CLIENT) += optee-client

#
# Paths and names
#
OPTEE_CLIENT_VERSION	:= 4.7.0
OPTEE_CLIENT_MD5	:= bede2f80cf601ab46211da3396968862
OPTEE_CLIENT		:= optee-client-$(OPTEE_CLIENT_VERSION)
OPTEE_CLIENT_SUFFIX	:= tar.gz
OPTEE_CLIENT_URL	:= https://github.com/OP-TEE/optee_client/archive/$(OPTEE_CLIENT_VERSION).$(OPTEE_CLIENT_SUFFIX)
OPTEE_CLIENT_SOURCE	:= $(SRCDIR)/$(OPTEE_CLIENT).$(OPTEE_CLIENT_SUFFIX)
OPTEE_CLIENT_DIR	:= $(BUILDDIR)/$(OPTEE_CLIENT)
OPTEE_CLIENT_LICENSE	:= BSD-2-Clause
OPTEE_CLIENT_LICENSE_FILES := \
	file://LICENSE;md5=69663ab153298557a59c67a60a743e5b

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OPTEE_CLIENT_CONF_TOOL	:= cmake
OPTEE_CLIENT_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DBUILD_SHARED_LIBS=ON \
	-DCFG_FTRACE_SUPPORT=ON \
	-DCFG_GP_SOCKETS=1 \
	-DCFG_TA_GPROF_SUPPORT=ON \
	-DCFG_TEEPRIV_GROUP=teepriv \
	-DCFG_TEE_CLIENT_LOAD_PATH=/usr/lib/ \
	-DCFG_TEE_CLIENT_LOG_FILE=var/lib/tee/teec.log \
	-DCFG_TEE_CLIENT_LOG_LEVEL=1 \
	-DCFG_TEE_FS_PARENT_PATH=var/lib/tee \
	-DCFG_TEE_GROUP=tee \
	-DCFG_TEE_PLUGIN_LOAD_PATH=/usr/lib/tee-supplicant/plugins/ \
	-DCFG_TEE_SUPPL_GROUP=teesuppl \
	-DCFG_TEE_SUPPL_USER=teesuppl \
	-DCFG_TEE_SUPP_LOG_LEVEL=1 \
	-DCFG_TEE_SUPP_PLUGINS=$(call ptx/onoff, PTXCONF_OPTEE_CLIENT_SUPPLICANT_PLUGINS) \
	-DCFG_WERROR=ON \
	-DRPMB_EMU=$(call ptx/onoff, PTXCONF_OPTEE_CLIENT_SUPPLICANT_RPMB_EMULATION) \
	-DWITH_TEEACL=ON

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/optee-client.targetinstall:
	@$(call targetinfo)

	@$(call install_init, optee-client)
	@$(call install_fixup, optee-client,PRIORITY,optional)
	@$(call install_fixup, optee-client,SECTION,base)
	@$(call install_fixup, optee-client,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, optee-client,DESCRIPTION,missing)

	@$(call install_lib, optee-client, 0, 0, 0644, libteec)
	@$(call install_lib, optee-client, 0, 0, 0644, libckteec)
	@$(call install_copy, optee-client, 0, 0, 0755, -, /usr/sbin/tee-supplicant)
ifdef PTXCONF_OPTEE_CLIENT_SYSTEMD_UNIT
	@$(call install_alternative, optee-client, 0, 0, 0644, \
		/usr/lib/systemd/system/tee-supplicant.service)
	@$(call install_link, optee-client, ../tee-supplicant.service,\
		/usr/lib/systemd/system/multi-user.target.wants/tee-supplicant.service)
endif

	@$(call install_finish, optee-client)

	@$(call touch)

# vim: syntax=make
