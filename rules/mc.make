# -*-makefile-*-
#
# Copyright (C) 2006 by Sascha Hauer
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MC) += mc

#
# Paths and names
#
MC_VERSION	:= 4.8.25
MC_MD5		:= 19f14d368001aac454c28a2ddd2e851b
MC		:= mc-$(MC_VERSION)
MC_SUFFIX	:= tar.xz
MC_URL		:= http://ftp.midnight-commander.org/$(MC).$(MC_SUFFIX)
MC_SOURCE	:= $(SRCDIR)/$(MC).$(MC_SUFFIX)
MC_DIR		:= $(BUILDDIR)/$(MC)
MC_LICENSE	:= GPL-2.0-only


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# smbfs helpers configure.ac is using AC_TRY_RUN to figure out
# gettimeofday parameters
MC_CONF_ENV	:= \
	$(CROSS_ENV) \
	samba_cv_HAVE_GETTIMEOFDAY_TZ=yes

MC_CONF_TOOL	:= autoconf
MC_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-tests \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-nls \
	--enable-vfs \
	--$(call ptx/endis,PTXCONF_MC_VFS_CPIO)-vfs-cpio \
	--$(call ptx/endis,PTXCONF_MC_VFS_EXTFS)-vfs-extfs \
	--$(call ptx/endis,PTXCONF_MC_VFS_FISH)-vfs-fish \
	--$(call ptx/endis,PTXCONF_MC_VFS_FTP)-vfs-ftp \
	--$(call ptx/endis,PTXCONF_MC_VFS_SFS)-vfs-sfs \
	--$(call ptx/endis,PTXCONF_MC_VFS_SFTP)-vfs-sftp \
	--$(call ptx/endis,PTXCONF_MC_VFS_SMB)-vfs-smb \
	--$(call ptx/endis,PTXCONF_MC_VFS_TAR)-vfs-tar \
	--$(call ptx/endis,PTXCONF_MC_VFS_UNDELFS)-vfs-undelfs \
	--disable-doxygen-doc \
	--with-screen=$(call ptx/ifdef, PTXCONF_MC_USES_SLANG, slang, ncurses) \
	--without-x \
	--with-mmap \
	--without-gpm-mouse

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mc)
	@$(call install_fixup, mc,PRIORITY,optional)
	@$(call install_fixup, mc,SECTION,base)
	@$(call install_fixup, mc,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, mc,DESCRIPTION,missing)

	@$(call install_copy, mc, 0, 0, 0755, -, /usr/bin/mc)
	@$(call install_alternative_tree, mc, 0, 0, /etc/mc)
	@$(call install_tree, mc, 0, 0, -, /usr/share/mc/skins)

	@$(call install_finish, mc)

	@$(call touch)

# vim: syntax=make
