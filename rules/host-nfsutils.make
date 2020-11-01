# -*-makefile-*-
#
# Copyright (C) 2020 by Bastian Krause <bst@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_NFSUTILS) += host-nfsutils

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_NFSUTILS_CONF_TOOL	:= autoconf

HOST_NFSUTILS_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--disable-nfsv4 \
	--disable-nfsv41 \
	--disable-gss \
	--disable-svcgss \
	--disable-kprefix \
	--disable-uuid \
	--disable-mount \
	--disable-libmount-mount \
	--disable-junction \
	--disable-tirpc \
	--disable-ipv6 \
	--disable-mountconfig \
	--disable-nfsdcld \
	--disable-nfsdcltrack \
	--disable-caps \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-ldap \
	--disable-gums \
	--with-rpcgen=internal \
	--without-mountfile \
	--without-tcp-wrappers \
	--without-krb5 \
	--without-gssglue \
	--without-systemd

HOST_NFSUTILS_MAKE_OPT		:= \
	-C tools/rpcgen

HOST_NFSUTILS_INSTALL_OPT	:= \
	$(HOST_NFSUTILS_MAKE_OPT) \
	install

# vim: syntax=make
