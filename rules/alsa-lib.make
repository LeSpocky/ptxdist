# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ALSA_LIB) += alsa-lib

#
# Paths and names
#
ALSA_LIB_VERSION	:= 1.1.9
ALSA_LIB_MD5		:= e6d429dbdcfaa0f034d907fa6dc3735e
ALSA_LIB		:= alsa-lib-$(ALSA_LIB_VERSION)
ALSA_LIB_SUFFIX		:= tar.bz2
ALSA_LIB_URL		:= \
	https://www.alsa-project.org/files/pub/lib/$(ALSA_LIB).$(ALSA_LIB_SUFFIX) \
	ftp://ftp.alsa-project.org/pub/lib/$(ALSA_LIB).$(ALSA_LIB_SUFFIX)
ALSA_LIB_SOURCE		:= $(SRCDIR)/$(ALSA_LIB).$(ALSA_LIB_SUFFIX)
ALSA_LIB_DIR		:= $(BUILDDIR)/$(ALSA_LIB)
ALSA_LIB_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
ALSA_LIB_CONF_TOOL	:= autoconf
ALSA_LIB_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-shared \
	--enable-fast-install \
	--enable-libtool-lock \
	--enable-symbolic-functions \
	--with-debug=no \
	--$(call ptx/endis, PTXCONF_ALSA_LIB_RESMGR)-resmgr \
	--$(call ptx/endis, PTXCONF_ALSA_LIB_READ)-aload \
	--$(call ptx/endis, PTXCONF_ALSA_LIB_MIXER)-mixer \
	--$(call ptx/endis, PTXCONF_ALSA_LIB_PCM)-pcm \
	--$(call ptx/endis, PTXCONF_ALSA_LIB_RAWMIDI)-rawmidi \
	--$(call ptx/endis, PTXCONF_ALSA_LIB_HWDEP)-hwdep \
	--$(call ptx/endis, PTXCONF_ALSA_LIB_SEQ)-seq \
	--$(call ptx/endis, PTXCONF_ALSA_LIB_UCM)-ucm \
	--disable-topology \
	--$(call ptx/endis, PTXCONF_ALSA_LIB_ALISP)-alisp \
	--disable-old-symbols \
	--disable-python \
	--enable-thread-safety \
	--with-versioned \
	--with-tmpdir=/tmp \
	--with-softfloat=$(call ptx/ifdef, PTXCONF_HAS_HARDFLOAT, no, yes) \
	--with-libdl \
	--with-pthread \
	--with-librt \
	--with-alsa-devdir=/dev/snd \
	--with-aload-devdir=/dev \
	--with-pcm-plugins=all

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/alsa-lib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, alsa-lib)
	@$(call install_fixup, alsa-lib, PRIORITY,optional)
	@$(call install_fixup, alsa-lib, SECTION,base)
	@$(call install_fixup, alsa-lib, AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, alsa-lib, DESCRIPTION,missing)

	@$(call install_lib, alsa-lib, 0, 0, 0644, libasound)
	@$(call install_tree, alsa-lib, 0, 0, -, /usr/share/alsa)
ifdef PTXCONF_ALSA_LIB_ASOUND_CONF
	@$(call install_alternative, alsa-lib, 0, 0, 0644, /etc/asound.conf)
endif

	@$(call install_finish, alsa-lib)

	@$(call touch)

# vim: syntax=make
