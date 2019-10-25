# -*-makefile-*-
#
# Copyright (C) 2008 by Remy Bohmer <linux@bohmer.net>
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_AT91BOOTSTRAP) += at91bootstrap

#
# Paths and names
#
AT91BOOTSTRAP_VERSION	:= 1.16
AT91BOOTSTRAP_MD5	:= 2d222312cf0af81c56db8747d6a38c7c
AT91BOOTSTRAP_SUFFIX	:= zip
AT91BOOTSTRAP		:= Bootstrap-v$(AT91BOOTSTRAP_VERSION)
AT91BOOTSTRAP_TARBALL	:= AT91Bootstrap$(AT91BOOTSTRAP_VERSION).$(AT91BOOTSTRAP_SUFFIX)
AT91BOOTSTRAP_URL	:= \
        http://www.atmel.com/dyn/resources/prod_documents/$(AT91BOOTSTRAP_TARBALL) \
        http://sources.buildroot.net/$(AT91BOOTSTRAP_TARBALL)
AT91BOOTSTRAP_SOURCE	:= $(SRCDIR)/$(AT91BOOTSTRAP_TARBALL)
AT91BOOTSTRAP_DIR	:= $(BUILDDIR)/$(AT91BOOTSTRAP)
AT91BOOTSTRAP_LICENSE	:= BSD-Source-Code AND GPL-2.0-or-later
AT91BOOTSTRAP_LICENSE_FILES := \
	file://main.c;startline=4;endline=26;md5=3492153edbe9064d12ba58818b73983d \
	file://lib/div0.c;startline=2;endline=21;md5=e0212951661974539b2490564f7050fe

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

AT91BOOTSTRAP_WRAPPER_BLACKLIST := \
	$(PTXDIST_LOWLEVEL_WRAPPER_BLACKLIST)

AT91BOOTSTRAP_BOOTMEDIA-$(PTXCONF_AT91BOOTSTRAP_BOOT_DATAFLASH)	+= dataflash
AT91BOOTSTRAP_BOOTMEDIA-$(PTXCONF_AT91BOOTSTRAP_BOOT_NAND)	+= nandflash

AT91BOOTSTRAP_BOARDDIR  := \
	$(AT91BOOTSTRAP_DIR)/board/${PTXCONF_AT91BOOTSTRAP_CONFIG}/$(AT91BOOTSTRAP_BOOTMEDIA-y)

AT91BOOTSTRAP_MAKE_ENV	:= $(CROSS_ENV)
AT91BOOTSTRAP_MAKE_PAR	:= NO
AT91BOOTSTRAP_MAKE_OPT	:= \
	CROSS_COMPILE=$(COMPILER_PREFIX) \
	-C $(AT91BOOTSTRAP_BOARDDIR)

AT91BOOTSTRAP_CFLAGS	:= \
	-ffreestanding

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/at91bootstrap.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/at91bootstrap.targetinstall:
	@$(call targetinfo)
	@install -m644 $(AT91BOOTSTRAP_BOARDDIR)/$(AT91BOOTSTRAP_BOOTMEDIA-y)_${PTXCONF_AT91BOOTSTRAP_CONFIG}.bin \
		$(IMAGEDIR)/at91bootstrap.bin
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/at91bootstrap.clean:
	@$(call targetinfo)
	@$(call clean_pkg, AT91BOOTSTRAP)
	@rm -rf $(IMAGEDIR)/at91bootstrap*

# vim: syntax=make
