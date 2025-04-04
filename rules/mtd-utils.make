# -*-makefile-*-
#
# Copyright (C) 2003-2008 by Pengutronix e.K., Hildesheim, Germany
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MTD_UTILS) += mtd-utils

#
# Paths and names
#
MTD_UTILS_VERSION	:= 2.3.0
MTD_UTILS_MD5		:= 06be1bd123cfea8575829e9b16e84f4b
MTD_UTILS		:= mtd-utils-$(MTD_UTILS_VERSION)
MTD_UTILS_SUFFIX	:= tar.bz2
MTD_UTILS_URL		:= https://infraroot.at/pub/mtd/$(MTD_UTILS).$(MTD_UTILS_SUFFIX)
MTD_UTILS_SOURCE	:= $(SRCDIR)/$(MTD_UTILS).$(MTD_UTILS_SUFFIX)
MTD_UTILS_DIR		:= $(BUILDDIR)/$(MTD_UTILS)
MTD_UTILS_LICENSE	:= GPL-2.0-or-later
MTD_UTILS_LICENSE_FILES	:= file://COPYING;md5=0636e73ff0215e8d672dc4c32c317bb3


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MTD_UTILS_CONF_TOOL	:= autoconf
MTD_UTILS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-unit-tests \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--$(call ptx/endis,PTXCONF_MTD_UTILS_UBIHEALTHD)-ubihealthd \
	--disable-asan \
	--$(call ptx/wwo,PTXCONF_MTD_UTILS_TESTS)-tests \
	--$(call ptx/wwo, PTXCONF_MTD_UTILS_LSMTD)-lsmtd \
	--$(call ptx/wwo, PTXCONF_MTD_UTILS_JFFS)-jffs \
	--$(call ptx/wwo, PTXCONF_MTD_UTILS_UBIFS)-ubifs \
	--with-zlib \
	--without-xattr \
	--$(call ptx/wwo, PTXCONF_MTD_UTILS_USE_LIBLZO)-lzo \
	--without-zstd \
	--$(call ptx/wwo, PTXCONF_GLOBAL_SELINUX)-selinux \
	--without-crypto

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mtd-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mtd-utils)
	@$(call install_fixup, mtd-utils,PRIORITY,optional)
	@$(call install_fixup, mtd-utils,SECTION,base)
	@$(call install_fixup, mtd-utils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, mtd-utils,DESCRIPTION,missing)

ifdef PTXCONF_MTD_UTILS_DOC_LOADBIOS
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/doc_loadbios)
endif
ifdef PTXCONF_MTD_UTILS_DOCFDISK
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/docfdisk)
endif
ifdef PTXCONF_MTD_UTILS_FLASH_ERASE
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/flash_erase)
endif
ifdef PTXCONF_MTD_UTILS_FLASH_ERASEALL
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/flash_eraseall)
endif
ifdef PTXCONF_MTD_UTILS_FLASH_LOCK
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/flash_lock)
endif
ifdef PTXCONF_MTD_UTILS_FLASH_OTP_DUMP
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/flash_otp_dump)
endif
ifdef PTXCONF_MTD_UTILS_FLASH_OTP_INFO
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/flash_otp_info)
endif
ifdef PTXCONF_MTD_UTILS_FLASH_OTP_LOCK
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/flash_otp_lock)
endif
ifdef PTXCONF_MTD_UTILS_FLASH_OTP_WRITE
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/flash_otp_write)
endif
ifdef PTXCONF_MTD_UTILS_FLASH_UNLOCK
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/flash_unlock)
endif
ifdef PTXCONF_MTD_UTILS_FLASHCP
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/flashcp)
endif
ifdef PTXCONF_MTD_UTILS_FTL_CHECK
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ftl_check)
endif
ifdef PTXCONF_MTD_UTILS_FTL_FORMAT
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ftl_format)
endif
ifdef PTXCONF_MTD_UTILS_LSMTD
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/lsmtd)
endif
ifdef PTXCONF_MTD_UTILS_JFFS2_DUMP
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/jffs2dump)
endif
ifdef PTXCONF_MTD_UTILS_JFFS2READER
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/jffs2reader)
endif

ifdef PTXCONF_MTD_UTILS_MTDDEBUG
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/mtd_debug)
endif

ifdef PTXCONF_MTD_UTILS_MTDPART
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/mtdpart)
endif

ifdef PTXCONF_MTD_UTILS_NANDDUMP
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/nanddump)
endif
ifdef PTXCONF_MTD_UTILS_NANDMARKBAD
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/nandmarkbad)
endif
ifdef PTXCONF_MTD_UTILS_NANDTEST
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/nandtest)
endif
ifdef PTXCONF_MTD_UTILS_NANDWRITE
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/nandwrite)
endif
ifdef PTXCONF_MTD_UTILS_NFTL_FORMAT
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/nftl_format)
endif
ifdef PTXCONF_MTD_UTILS_NFTLDUMP
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/nftldump)
endif
ifdef PTXCONF_MTD_UTILS_MKJFFS2
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/mkfs.jffs2)
endif
ifdef PTXCONF_MTD_UTILS_RECV_IMAGE
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/recv_image)
endif
ifdef PTXCONF_MTD_UTILS_RFDDUMP
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/rfddump)
endif
ifdef PTXCONF_MTD_UTILS_RFDFORMAT
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/rfdformat)
endif
ifdef PTXCONF_MTD_UTILS_SERVE_IMAGE
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/serve_image)
endif
ifdef PTXCONF_MTD_UTILS_SUMTOOL
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/sumtool)
endif
ifdef PTXCONF_MTD_UTILS_UBIATTACH
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubiattach)
endif
ifdef PTXCONF_MTD_UTILS_UBIBLOCK
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubiblock)
endif
ifdef PTXCONF_MTD_UTILS_UBIDETACH
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubidetach)
endif
ifdef PTXCONF_MTD_UTILS_UBICRC32
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubicrc32)
endif
ifdef PTXCONF_MTD_UTILS_UBIFS_MOUNTHELPER
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/mount.ubifs)
endif
ifdef PTXCONF_MTD_UTILS_UBIHEALTHD
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubihealthd)
ifdef PTXCONF_MTD_UTILS_UBIHEALTHD_STARTSCRIPT
	@$(call install_alternative, mtd-utils, 0, 0, 0755, \
		/etc/init.d/ubihealthd)
ifneq ($(call remove_quotes,$(PTXCONF_MTD_UTILS_UBIHEALTHD_BBINIT_LINK)),)
	@$(call install_link, mtd-utils, ../init.d/ubihealthd, \
		/etc/rc.d/$(PTXCONF_MTD_UTILS_UBIHEALTHD_BBINIT_LINK))
endif
endif
ifdef PTXCONF_MTD_UTILS_UBIHEALTHD_SYSTEMD_UNIT
	@$(call install_alternative, mtd-utils, 0, 0, 0644, \
		/usr/lib/systemd/system/ubihealthd@.service)
	@$(call install_link, mtd-utils, ../ubihealthd@.service, \
		/usr/lib/systemd/system/multi-user.target.wants/ubihealthd@ubi0.service)
endif
endif
ifdef PTXCONF_MTD_UTILS_UBIMKVOL
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubimkvol)
endif
ifdef PTXCONF_MTD_UTILS_UBIRENAME
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubirename)
endif
ifdef PTXCONF_MTD_UTILS_UBIRSVOL
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubirsvol)
endif
ifdef PTXCONF_MTD_UTILS_UBIRMVOL
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubirmvol)
endif
ifdef PTXCONF_MTD_UTILS_UBISCAN
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubiscan)
endif
ifdef PTXCONF_MTD_UTILS_UBIUPDATEVOL
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubiupdatevol)
endif
ifdef PTXCONF_MTD_UTILS_UBINFO
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubinfo)
endif
ifdef PTXCONF_MTD_UTILS_UBIFORMAT
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubiformat)
endif
ifdef PTXCONF_MTD_UTILS_UBINIZE
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/ubinize)
endif
ifdef PTXCONF_MTD_UTILS_MKFS_UBIFS
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/mkfs.ubifs);
endif
ifdef PTXCONF_MTD_UTILS_FSCK_UBIFS
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/fsck.ubifs);
endif
ifdef PTXCONF_MTD_UTILS_MTDINFO
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/sbin/mtdinfo)
endif
ifdef PTXCONF_MTD_UTILS_TESTS
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/libexec/mtd-utils/nandbiterrs)
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/libexec/mtd-utils/flash_speed)
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/libexec/mtd-utils/flash_stress)
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/libexec/mtd-utils/flash_readtest)
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/libexec/mtd-utils/nandpagetest)
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/libexec/mtd-utils/nandsubpagetest)
	@$(call install_copy, mtd-utils, 0, 0, 0755, -, \
		/usr/libexec/mtd-utils/flash_torture)
endif

	@$(call install_finish, mtd-utils)

	@$(call touch)

# vim: syntax=make
