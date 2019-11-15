# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_E2FSPROGS) += host-e2fsprogs

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_E2FSPROGS_CONF_TOOL	:= autoconf
HOST_E2FSPROGS_CONF_OPT		:= \
	$(HOST_AUTOCONF) \
	--disable-symlink-install \
	--disable-relative-symlinks \
	--disable-symlink-build \
	--disable-verbose-makecmds \
	--disable-elf-shlibs \
	--disable-bsd-shlibs \
	--disable-profile \
	--disable-gcov \
	--disable-hardening \
	--disable-jbd-debug \
	--disable-blkid-debug \
	--disable-testio-debug \
	--disable-libuuid \
	--disable-libblkid \
	--disable-backtrace \
	--disable-debugfs \
	--disable-imager \
	--disable-resizer \
	--disable-defrag \
	--enable-fsck \
	--disable-e2initrd-helper \
	--disable-tls \
	--disable-uuidd \
	--enable-mmp \
	--enable-tdb \
	--disable-bmap-stats \
	--disable-bmap-stats-ops \
	--disable-nls \
	--enable-threads=posix \
	--disable-rpath \
	--disable-fuse2fs \
	--without-included-gettext

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

HOST_E2FSPROGS_INSTALL_OPT	:= install install-libs

$(STATEDIR)/host-e2fsprogs.install:
	@$(call targetinfo)
	@$(call world/install, HOST_E2FSPROGS)
	@mkdir -vp $(HOST_E2FSPROGS_PKGDIR)/sbin/real
	@mv -v $(HOST_E2FSPROGS_PKGDIR)/sbin/{mke2fs,mkfs.*} \
		$(HOST_E2FSPROGS_PKGDIR)/sbin/real/
	@echo '#!/bin/sh'							>  $(HOST_E2FSPROGS_PKGDIR)/sbin/mke2fs
	@echo 'export MKE2FS_CONFIG="$$(dirname "$${0}")/../etc/mke2fs.conf"'	>> $(HOST_E2FSPROGS_PKGDIR)/sbin/mke2fs
	@echo 'exec "$$(dirname "$${0}")/real/$$(basename "$${0}")" "$${@}"'	>> $(HOST_E2FSPROGS_PKGDIR)/sbin/mke2fs
	@chmod +x $(HOST_E2FSPROGS_PKGDIR)/sbin/mke2fs
	@$(foreach mkfs,mkfs.ext2 mkfs.ext3 mkfs.ext4, \
		ln -s mke2fs $(HOST_E2FSPROGS_PKGDIR)/sbin/$(mkfs)$(ptx/nl))
	@$(call touch)

$(STATEDIR)/host-e2fsprogs.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_E2FSPROGS)
	@sed -i -e 's,/share,$(PTXDIST_SYSROOT_HOST)/share,' \
		$(PTXDIST_SYSROOT_HOST)/bin/compile_et
	@sed -i -e 's,/share,$(PTXDIST_SYSROOT_HOST)/share,' \
		$(PTXDIST_SYSROOT_HOST)/bin/mk_cmds
	@$(call touch)

# vim: syntax=make
