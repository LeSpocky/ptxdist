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
FIO_VERSION		:= 3.43
FIO_SHA256		:= efa49b3f36eda9adf29294f27a87d7e457747d676cd0f73996d6365357832cfe
FIO			:= fio-$(FIO_VERSION)
FIO_SUFFIX		:= tar.gz
FIO_URL			:= https://github.com/axboe/fio/archive/refs/tags/$(FIO).$(FIO_SUFFIX)
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
	--disable-libnfs \
	--disable-lex \
	--disable-pmem \
	--disable-native \
	--disable-xnvme \
	--disable-libzbc \
	--disable-tcmalloc \
	--disable-dfs

FIO_FLAGS_BLACKLIST := \
	-lz \
	-laio

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
