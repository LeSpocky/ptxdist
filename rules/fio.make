# -*-makefile-*-
#
# Copyright (C) 2020 by Lucas Stach <l.stach@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FIO) += fio

#
# Paths and names
#
FIO_VERSION		:= 3.23
FIO_MD5			:= 497f8bad953723a8c4c46f2a58a13b24
FIO			:= fio-$(FIO_VERSION)
FIO_SUFFIX		:= tar.gz
FIO_URL			:= https://brick.kernel.dk/snaps/$(FIO).$(FIO_SUFFIX)
FIO_SOURCE		:= $(SRCDIR)/$(FIO).$(FIO_SUFFIX)
FIO_DIR			:= $(BUILDDIR)/$(FIO)
FIO_LICENSE		:= GPL-2.0-only
FIO_LICENSE_FILES	:= file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# Not really autoconf, but a hand-written configure script.
#
FIO_CONF_TOOL	:= autoconf
FIO_CONF_OPT	:= \
	--prefix=/usr \
	--disable-numa \
	--disable-rdma \
	--disable-rados \
	--disable-rbd \
	--disable-http \
	--disable-gfapi \
	--disable-lex \
	--disable-pmem \
	--disable-native \
	--disable-libzbc \
	--disable-tcmalloc \

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fio.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fio)
	@$(call install_fixup, fio,PRIORITY,optional)
	@$(call install_fixup, fio,SECTION,base)
	@$(call install_fixup, fio,AUTHOR,"Lucas Stach <l.stach@pengutronix.de>")
	@$(call install_fixup, fio,DESCRIPTION,missing)

	@$(call install_copy, fio, 0, 0, 0755, -, /usr/bin/fio)

	@$(call install_finish, fio)

	@$(call touch)

# vim: syntax=make
