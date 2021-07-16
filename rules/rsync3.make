# -*-makefile-*-
#
# Copyright (C) 2003 by wschmitt@envicomp.de
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RSYNC3) += rsync3

#
# Paths and names
#
RSYNC3_VERSION	:= 3.2.3
RSYNC3_MD5	:= 209f8326f5137d8817a6276d9577a2f1
RSYNC3		:= rsync-$(RSYNC3_VERSION)
RSYNC3_SUFFIX	:= tar.gz
RSYNC3_URL	:= https://download.samba.org/pub/rsync/src/$(RSYNC3).$(RSYNC3_SUFFIX)
RSYNC3_SOURCE	:= $(SRCDIR)/$(RSYNC3).$(RSYNC3_SUFFIX)
RSYNC3_DIR	:= $(BUILDDIR)/$(RSYNC3)
RSYNC3_LICENSE	:= GPL-3.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
RSYNC3_AUTOCONF  := \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug \
	--disable-profile \
	--disable-md2man \
	--disable-simd \
	--disable-asm \
	$(GLOBAL_LARGE_FILE_OPTION) \
	$(GLOBAL_IPV6_OPTION) \
	--disable-locale \
	--disable-openssl \
	--disable-xxhash \
	--$(call ptx/endis, PTXCONF_RSYNC3_ZSTD)-zstd \
	--disable-lz4 \
	--$(call ptx/endis, PTXCONF_ICONV)-iconv-open \
	--$(call ptx/endis, PTXCONF_ICONV)-iconv \
	--$(call ptx/endis, PTXCONF_RSYNC3_ACL)-acl-support \
	--$(call ptx/endis, PTXCONF_RSYNC3_ATTR)-xattr-support \
	--with-included-popt \
	--without-included-zlib \
	--with-protected-args

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rsync3.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  rsync3)
	@$(call install_fixup, rsync3,PRIORITY,optional)
	@$(call install_fixup, rsync3,SECTION,base)
	@$(call install_fixup, rsync3,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, rsync3,DESCRIPTION,missing)

	@$(call install_copy, rsync3, 0, 0, 0755, -, \
		/usr/bin/rsync)

	@$(call install_alternative, rsync3, 0, 0, 0644, /etc/rsyncd.conf, n)
	@$(call install_alternative, rsync3, 0, 0, 0640, /etc/rsyncd.secrets, n)

	#
	# busybox init
	#

ifdef PTXCONF_RSYNC3_STARTSCRIPT
	@$(call install_alternative, rsync3, 0, 0, 0755, /etc/init.d/rsyncd, n)

ifneq ($(call remove_quotes,$(PTXCONF_RSYNC3_BBINIT_LINK)),)
	@$(call install_link, rsync3, \
		../init.d/rsyncd, \
		/etc/rc.d/$(PTXCONF_RSYNC3_BBINIT_LINK))
endif
endif
	@$(call install_finish, rsync3)
	@$(call touch)

# vim: syntax=make
