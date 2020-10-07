# -*-makefile-*-
#
# Copyright (C) 2007 by Sascha Hauer
#               2008, 2009 by Marc Kleine-Budde
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BAREBOX) += barebox

#
# Paths and names
#
BAREBOX_VERSION		:= $(call remove_quotes,$(PTXCONF_BAREBOX_VERSION))
BAREBOX_MD5		:= $(call remove_quotes,$(PTXCONF_BAREBOX_MD5))
BAREBOX			:= barebox-$(BAREBOX_VERSION)
BAREBOX_SUFFIX		:= tar.bz2
BAREBOX_URL		:= $(call barebox-url, BAREBOX)
BAREBOX_SOURCE		:= $(SRCDIR)/$(BAREBOX).$(BAREBOX_SUFFIX)
BAREBOX_DIR		:= $(BUILDDIR)/$(BAREBOX)
BAREBOX_BUILD_DIR	:= $(BAREBOX_DIR)-build
BAREBOX_LICENSE		:= GPL-2.0-only
BAREBOX_DEVPKG		:= NO
BAREBOX_BUILD_OOT	:= KEEP

BAREBOX_CONFIG		:= $(call ptx/in-platformconfigdir, \
		$(call remove_quotes, $(PTXCONF_BAREBOX_CONFIG)))

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# use host pkg-config for host tools
BAREBOX_PATH		:= PATH=$(HOST_PATH)

BAREBOX_WRAPPER_BLACKLIST := \
	$(PTXDIST_LOWLEVEL_WRAPPER_BLACKLIST)

BAREBOX_CONF_TOOL	:= kconfig
BAREBOX_CONF_OPT	:= \
	-C $(BAREBOX_DIR) \
	O=$(BAREBOX_BUILD_DIR) \
	$(call barebox-opts, BAREBOX)

BAREBOX_MAKE_OPT	:= $(BAREBOX_CONF_OPT)

BAREBOX_TAGS_OPT	:= TAGS tags cscope

ifdef PTXCONF_BAREBOX
$(BAREBOX_CONFIG):
	@echo
	@echo "****************************************************************************"
	@echo "**** Please generate a barebox config with 'ptxdist menuconfig barebox' ****"
	@echo "****************************************************************************"
	@echo
	@echo
	@exit 1
endif

ifneq ($(call remove_quotes,$(PTXCONF_BAREBOX_EXTRA_ENV_PATH)),)
BAREBOX_EXTRA_ENV_PATH	:= $(foreach path, \
		$(call remove_quotes,$(PTXCONF_BAREBOX_EXTRA_ENV_PATH)), \
		$(call ptx/in-platformconfigdir,$(path)))
BAREBOX_EXTRA_ENV_DEPS	:= \
	$(BAREBOX_EXTRA_ENV_PATH) \
	$(call ptx/force-sh, find $(BAREBOX_EXTRA_ENV_PATH) -print 2>/dev/null)
$(STATEDIR)/barebox.prepare: $(BAREBOX_EXTRA_ENV_DEPS)
endif

$(STATEDIR)/barebox.prepare:
	@$(call targetinfo)
	@$(call world/prepare, BAREBOX)

ifdef PTXCONF_BAREBOX_EXTRA_ENV
	@rm -rf $(BAREBOX_BUILD_DIR)/.ptxdist-defaultenv
	@ptxd_source_kconfig "${PTXDIST_PTXCONFIG}" && \
	ptxd_source_kconfig "${PTXDIST_PLATFORMCONFIG}" && \
	$(foreach path, $(BAREBOX_EXTRA_ENV_PATH), \
		if [ -d "$(path)" ]; then \
			ptxd_filter_dir "$(path)" \
			$(BAREBOX_BUILD_DIR)/.ptxdist-defaultenv; \
		else \
			cp "$(path)" $(BAREBOX_BUILD_DIR)/.ptxdist-defaultenv/; \
		fi;)
	@rm -rf $(BAREBOX_BUILD_DIR)/defaultenv/barebox_default_env
endif

	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ifdef PTXCONF_CODE_SIGNING
BAREBOX_MAKE_ENV = \
	$(CODE_SIGNING_ENV) \
	IMAGE_KERNEL_FIT_KEY="$(shell cs_get_uri image-kernel-fit)"
endif

$(STATEDIR)/barebox.compile:
	@$(call targetinfo)

ifdef PTXCONF_BAREBOX_EXTRA_ENV
	@if test $$(grep -c -e "^CONFIG_DEFAULT_ENVIRONMENT_PATH=.*\$(BAREBOX_BUILD_DIR)/.ptxdist-defaultenv" $(BAREBOX_BUILD_DIR)/.config) -eq 0; then \
		sed -i -e "s,^\(CONFIG_DEFAULT_ENVIRONMENT_PATH=.*\)\"$$,\1 $(BAREBOX_BUILD_DIR)/.ptxdist-defaultenv\"," \
			$(BAREBOX_BUILD_DIR)/.config; \
	fi
endif
	@$(call world/compile, BAREBOX)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

BAREBOX_PROGS_HOST := \
	bareboxenv \
	kernel-install \
	bareboxcrc32 \
	bareboximd \
	setupmbr/setupmbr \
	imx/imx-usb-loader

BAREBOX_PROGS_TARGET_y :=
BAREBOX_PROGS_TARGET_$(PTXCONF_BAREBOX_BAREBOXENV) += bareboxenv
BAREBOX_PROGS_TARGET_$(PTXCONF_BAREBOX_KERNEL_INSTALL) += kernel-install
BAREBOX_PROGS_TARGET_$(PTXCONF_BAREBOX_BAREBOXCRC32) += bareboxcrc32
BAREBOX_PROGS_TARGET_$(PTXCONF_BAREBOX_BAREBOXIMD) += bareboximd

$(STATEDIR)/barebox.install:
	@$(call targetinfo)

	@$(foreach prog, $(BAREBOX_PROGS_HOST), \
		if [ -e $(BAREBOX_BUILD_DIR)/scripts/$(prog) ]; then \
			install -v -D -m755 $(BAREBOX_BUILD_DIR)/scripts/$(prog) \
				$(PTXDIST_SYSROOT_HOST)/bin/$(notdir $(prog)) || exit; \
		fi;)

	@$(foreach prog, $(BAREBOX_PROGS_TARGET_y), \
		install -v -D -m755 $(BAREBOX_BUILD_DIR)/scripts/$(prog)-target \
			$(BAREBOX_PKGDIR)/usr/bin/$(prog) || exit;)

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox.targetinstall:
	@$(call targetinfo)

ifneq ($(strip $(BAREBOX_PROGS_TARGET_y)),)
	@$(call install_init, barebox)
	@$(call install_fixup, barebox,PRIORITY,optional)
	@$(call install_fixup, barebox,SECTION,base)
	@$(call install_fixup, barebox,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, barebox,DESCRIPTION,missing)

	@$(foreach prog, $(BAREBOX_PROGS_TARGET_y), \
		$(call install_copy, barebox, 0, 0, 0755, -, \
			/usr/bin/$(prog));)

	@$(call install_finish, barebox)
endif

	@rm -f $(IMAGEDIR)/barebox-image
	@if [ -d $(BAREBOX_BUILD_DIR)/images ]; then \
		find $(BAREBOX_BUILD_DIR)/images/ -name "barebox-*.img" | sort | while read image; do \
			install -D -m644 $$image $(IMAGEDIR)/`basename $$image`; \
			if [ ! -e $(IMAGEDIR)/barebox-image ]; then \
				ln -sf `basename $$image` $(IMAGEDIR)/barebox-image; \
			fi; \
		done; \
	fi
	@if [ -e $(IMAGEDIR)/barebox-image ]; then \
		:; \
	elif [ -e $(BAREBOX_BUILD_DIR)/barebox-flash-image ]; then \
		install -D -m644 $(BAREBOX_BUILD_DIR)/barebox-flash-image $(IMAGEDIR)/barebox-image; \
	else \
		install -D -m644 $(BAREBOX_BUILD_DIR)/barebox.bin $(IMAGEDIR)/barebox-image; \
	fi
	@if [ -e $(BAREBOX_BUILD_DIR)/defaultenv/barebox_zero_env ]; then \
		install -D -m644 $(BAREBOX_BUILD_DIR)/defaultenv/barebox_zero_env $(IMAGEDIR)/barebox-default-environment; \
	elif [ -e $(BAREBOX_BUILD_DIR)/common/barebox_default_env ]; then \
		install -D -m644 $(BAREBOX_BUILD_DIR)/common/barebox_default_env $(IMAGEDIR)/barebox-default-environment; \
	elif [ -e $(BAREBOX_BUILD_DIR)/barebox_default_env ]; then \
		install -D -m644 $(BAREBOX_BUILD_DIR)/barebox_default_env $(IMAGEDIR)/barebox-default-environment; \
	fi
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox.clean:
	@$(call targetinfo)
	@$(call clean_pkg, BAREBOX)
	@$(foreach prog, $(BAREBOX_PROGS_HOST), \
		rm -vf $(PTXDIST_SYSROOT_HOST)/bin/$(notdir $(prog))$(ptx/nl))
	@rm -vf $(IMAGEDIR)/barebox-image $(IMAGEDIR)/barebox-default-environment

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

$(call ptx/kconfig-targets, barebox): $(STATEDIR)/barebox.extract
	@$(call world/kconfig, BAREBOX, $(subst barebox_,,$@))

# vim: syntax=make
