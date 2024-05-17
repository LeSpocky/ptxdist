# -*-makefile-*-
#
# Copyright (C) 2024 by Ian Abbott <abbotti@mev.co.uk>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_EXFATPROGS) += exfatprogs

#
# Paths and names
#
EXFATPROGS_VERSION		:= 1.2.2
EXFATPROGS_MD5			:= cbe2a6529b4972fc2cc260553f28f983
EXFATPROGS			:= exfatprogs-$(EXFATPROGS_VERSION)
EXFATPROGS_SUFFIX		:= tar.xz
EXFATPROGS_URL			:= https://github.com/exfatprogs/exfatprogs/releases/download/$(EXFATPROGS_VERSION)/$(EXFATPROGS).$(EXFATPROGS_SUFFIX)
EXFATPROGS_SOURCE		:= $(SRCDIR)/$(EXFATPROGS).$(EXFATPROGS_SUFFIX)
EXFATPROGS_DIR			:= $(BUILDDIR)/$(EXFATPROGS)
EXFATPROGS_LICENSE		:= GPL-2.0
EXFATPROGS_LICENSE_FILES	:= file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

EXFATPROGS_CONF_ENV	:= $(CROSS_ENV)

#
# autoconf
#
EXFATPROGS_CONF_TOOL	:= autoconf
EXFATPROGS_CONF_OPT	:=  \
	$(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/exfatprogs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, exfatprogs)
	@$(call install_fixup, exfatprogs,PRIORITY,optional)
	@$(call install_fixup, exfatprogs,SECTION,base)
	@$(call install_fixup, exfatprogs,AUTHOR,"Ian Abbott <abbotti@mev.co.uk>")
	@$(call install_fixup, exfatprogs,DESCRIPTION,missing)

ifdef PTXCONF_EXFATPROGS_DUMP_EXFAT
	@$(call install_copy, exfatprogs, 0, 0, 0755, -, /usr/sbin/dump.exfat)
endif
ifdef PTXCONF_EXFATPROGS_EXFAT2IMG
	@$(call install_copy, exfatprogs, 0, 0, 0755, -, /usr/sbin/exfat2img)
endif
ifdef PTXCONF_EXFATPROGS_EXFATLABEL
	@$(call install_copy, exfatprogs, 0, 0, 0755, -, /usr/sbin/exfatlabel)
endif
ifdef PTXCONF_EXFATPROGS_FSCK_EXFAT
	@$(call install_copy, exfatprogs, 0, 0, 0755, -, /usr/sbin/fsck.exfat)
endif
ifdef PTXCONF_EXFATPROGS_MKFS_EXFAT
	@$(call install_copy, exfatprogs, 0, 0, 0755, -, /usr/sbin/mkfs.exfat)
endif
ifdef PTXCONF_EXFATPROGS_TUNE_EXFAT
	@$(call install_copy, exfatprogs, 0, 0, 0755, -, /usr/sbin/tune.exfat)
endif

	@$(call install_finish, exfatprogs)

	@$(call touch)

# vim: syntax=make
