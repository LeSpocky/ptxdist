# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_AT91BOOTSTRAP2) += at91bootstrap2

#
# Paths and names
#
AT91BOOTSTRAP2_VERSION	:= $(call remove_quotes, $(PTXCONF_AT91BOOTSTRAP2_VERSION))
AT91BOOTSTRAP2_MD5	:= $(call remove_quotes, $(PTXCONF_AT91BOOTSTRAP2_MD5))
AT91BOOTSTRAP2		:= at91bootstrap-$(AT91BOOTSTRAP2_VERSION)
AT91BOOTSTRAP2_SUFFIX	:= tar.gz
AT91BOOTSTRAP2_URL	:= https://github.com/linux4sam/at91bootstrap/archive/v$(AT91BOOTSTRAP2_VERSION).$(AT91BOOTSTRAP2_SUFFIX)
AT91BOOTSTRAP2_SOURCE	:= $(SRCDIR)/$(AT91BOOTSTRAP2).$(AT91BOOTSTRAP2_SUFFIX)
AT91BOOTSTRAP2_DIR	:= $(BUILDDIR)/$(AT91BOOTSTRAP2)
AT91BOOTSTRAP2_CONFIG	:= $(call ptx/in-platformconfigdir, \
		$(call remove_quotes, $(PTXCONF_AT91BOOTSTRAP2_CONFIG)))
AT91BOOTSTRAP2_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

AT91BOOTSTRAP2_WRAPPER_BLACKLIST := \
	$(PTXDIST_LOWLEVEL_WRAPPER_BLACKLIST)

AT91BOOTSTRAP2_MAKE_ENV := \
	CROSS_COMPILE=$(BOOTLOADER_CROSS_COMPILE) \
	HOSTCC=$(HOSTCC)
AT91BOOTSTRAP2_MAKE_OPT := V=$(PTXDIST_VERBOSE)

ifdef PTXCONF_AT91BOOTSTRAP2
$(AT91BOOTSTRAP2_CONFIG):
	@echo
	@echo "***********************************************************************************"
	@echo "* Please generate a at91bootstrap config with 'ptxdist menuconfig at91bootstrap2' *"
	@echo "***********************************************************************************"
	@echo
	@echo
	@exit 1
endif

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/at91bootstrap2.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/at91bootstrap2.targetinstall:
	@$(call targetinfo)
	@if [ -e $(AT91BOOTSTRAP2_DIR)/binaries/at91bootstrap.bin ]; then \
		install -vD -m644 $(AT91BOOTSTRAP2_DIR)/binaries/at91bootstrap.bin \
			$(IMAGEDIR)/at91bootstrap.bin; \
	else \
		install -vD -m644 $(AT91BOOTSTRAP2_DIR)/binaries/*boot-$(AT91BOOTSTRAP2_VERSION).bin \
			$(IMAGEDIR)/at91bootstrap.bin; \
	fi
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/at91bootstrap2.clean:
	@$(call targetinfo)
	@$(call clean_pkg, AT91BOOTSTRAP2)
	@rm -rf $(IMAGEDIR)/at91bootstrap.bin

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

at91bootstrap2_oldconfig at91bootstrap2_menuconfig: $(STATEDIR)/at91bootstrap2.extract
	@$(call world/kconfig, AT91BOOTSTRAP2, $(subst at91bootstrap2_,,$@))

# vim: syntax=make
