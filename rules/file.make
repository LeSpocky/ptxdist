# -*-makefile-*-
#
# Copyright (C) 2011 by Alexander Dahl <post@lespocky.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FILE) += file

#
# Paths and names
#
FILE_VERSION	:= 5.39
FILE_MD5	:= 1c450306053622803a25647d88f80f25
FILE		:= file-$(FILE_VERSION)
FILE_SUFFIX	:= tar.gz
FILE_URL	:= http://ftp.astron.com/pub/file/$(FILE).$(FILE_SUFFIX)
FILE_SOURCE	:= $(SRCDIR)/$(FILE).$(FILE_SUFFIX)
FILE_DIR	:= $(BUILDDIR)/$(FILE)
FILE_LICENSE	:= BSD-2-Clause
FILE_LICENSE_FILES	:= \
	file://COPYING;md5=8bafafc441e2e0b9660848c98760b5f3 \
	file://src/file.c;startline=1;endline=27;md5=c23a8098a761ce3193087925877307b9

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FILE_PATH	:= PATH=$(PTXDIST_SYSROOT_HOST)/bin/file:$(CROSS_PATH)

FILE_CONF_TOOL	:= autoconf
FILE_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-elf \
	--enable-elf-core \
	--enable-zlib \
	--disable-bzlib \
	--disable-xzlib \
	--$(call ptx/endis, PTXCONF_FILE_SECCOMP)-libseccomp \
	--disable-fsect-man5 \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-warnings

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/file.targetinstall:
	@$(call targetinfo)

	@$(call install_init, file)
	@$(call install_fixup, file,PRIORITY,optional)
	@$(call install_fixup, file,SECTION,base)
	@$(call install_fixup, file,AUTHOR,"Alexander Dahl <post@lespocky.de>")
	@$(call install_fixup, file,DESCRIPTION,missing)

	@$(call install_lib, file, 0, 0, 0644, libmagic)
	@$(call install_copy, file, 0, 0, 0755, -, /usr/bin/file)
	@$(call install_copy, file, 0, 0, 0644, -, /usr/share/misc/magic.mgc)

	@$(call install_finish, file)

	@$(call touch)

# vim: syntax=make
