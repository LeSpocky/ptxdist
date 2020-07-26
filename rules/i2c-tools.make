# -*-makefile-*-
#
# Copyright (C) 2008 by Carsten Schlote
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_I2C_TOOLS) += i2c-tools

#
# Paths and names
#
I2C_TOOLS_VERSION	:= 4.1
I2C_TOOLS_MD5		:= e2981debb4a822a279be7e45a0ede988
I2C_TOOLS		:= i2c-tools-$(I2C_TOOLS_VERSION)
I2C_TOOLS_SUFFIX	:= tar.xz
I2C_TOOLS_URL		:= https://www.kernel.org/pub/software/utils/i2c-tools/$(I2C_TOOLS).$(I2C_TOOLS_SUFFIX)
I2C_TOOLS_SOURCE	:= $(SRCDIR)/$(I2C_TOOLS).$(I2C_TOOLS_SUFFIX)
I2C_TOOLS_DIR		:= $(BUILDDIR)/$(I2C_TOOLS)
I2C_TOOLS_LICENSE	:= GPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

I2C_TOOLS_CONF_TOOL := NO

I2C_TOOLS_MAKE_ENV := \
	$(CROSS_ENV) \
	BUILD_STATIC_LIB=0 \
	BUILD_DYNAMIC_LIB=1 \
	USE_DYNAMIC_LIB=1

# install the header files to include/i2c-tools
# this way they don't collide with the toolchain's i2c headers
I2C_TOOLS_INSTALL_OPT := \
	PREFIX=/usr \
	incdir=/usr/include/i2c-tools \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/i2c-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, i2c-tools)
	@$(call install_fixup, i2c-tools,PRIORITY,optional)
	@$(call install_fixup, i2c-tools,SECTION,base)
	@$(call install_fixup, i2c-tools,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, i2c-tools,DESCRIPTION,missing)

	@$(call install_copy, i2c-tools, 0, 0, 0755, -, /usr/sbin/i2cdetect)
	@$(call install_copy, i2c-tools, 0, 0, 0755, -, /usr/sbin/i2cdump)
	@$(call install_copy, i2c-tools, 0, 0, 0755, -, /usr/sbin/i2cset)
	@$(call install_copy, i2c-tools, 0, 0, 0755, -, /usr/sbin/i2cget)
	@$(call install_copy, i2c-tools, 0, 0, 0755, -, /usr/sbin/i2ctransfer)
	@$(call install_lib, i2c-tools, 0, 0, 0644, libi2c)

	@$(call install_finish, i2c-tools)

	@$(call touch)

# vim: syntax=make
