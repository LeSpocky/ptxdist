# -*-makefile-*-
#
# Copyright (C) 2026 by Jan Hrubes <jan.hrubes@racom.eu>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SPI_TOOLS) += spi-tools

#
# Paths and names
#
SPI_TOOLS_VERSION	:= 1.1.0
SPI_TOOLS_SHA256	:= ef6def46ef1438640001ea3c4c80f1c7adca303f30236a380ba57becda438b0b
SPI_TOOLS		:= spi-tools-$(SPI_TOOLS_VERSION)
SPI_TOOLS_SUFFIX	:= tar.gz
SPI_TOOLS_URL	:= https://github.com/cpb-/spi-tools/archive/refs/tags/$(SPI_TOOLS_VERSION).$(SPI_TOOLS_SUFFIX)
SPI_TOOLS_SOURCE	:= $(SRCDIR)/$(SPI_TOOLS).$(SPI_TOOLS_SUFFIX)
SPI_TOOLS_DIR	:= $(BUILDDIR)/$(SPI_TOOLS)
SPI_TOOLS_LICENSE	:= GPL-2.0-only
SPI_TOOLS_LICENSE_FILES := \
	file://LICENSE;md5=8c16666ae6c159876a0ba63099614381
# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SPI_TOOLS_CONF_TOOL	:= cmake
SPI_TOOLS_CONF_OPT	:= $(CROSS_CMAKE_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/spi-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, spi-tools)
	@$(call install_fixup, spi-tools,PRIORITY,optional)
	@$(call install_fixup, spi-tools,SECTION,base)
	@$(call install_fixup, spi-tools,AUTHOR,"Jan Hrubes <jan.hrubes@racom.eu>")
	@$(call install_fixup, spi-tools,DESCRIPTION,spidev tools)

	@$(call install_copy, spi-tools, 0, 0, 0755, -, /usr/bin/spi-config)
	@$(call install_copy, spi-tools, 0, 0, 0755, -, /usr/bin/spi-pipe)

	@$(call install_finish, spi-tools)

	@$(call touch)

# vim: syntax=make
