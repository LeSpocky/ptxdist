# -*-makefile-*-
#
# Copyright (C) 2018 by Juergen Borleis <jbe@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_OPENSC) += host-opensc

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_OPENSC_CONF_TOOL	:= autoconf
HOST_OPENSC_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	--sysconfdir=/etc/opensc \
	--enable-optimization \
	--disable-strict \
	--disable-pedantic \
	--enable-thread-locking \
	--disable-zlib \
	--disable-readline \
	--enable-openssl \
	--disable-openpace \
	--disable-openct \
	--$(call ptx/endis, PTXCONF_HOST_OPENSC_PCSC)-pcsc \
	--disable-cryptotokenkit \
	--$(call ptx/disen, PTXCONF_HOST_OPENSC_PCSC)-ctapi \
	--disable-minidriver \
	--enable-sm \
	--disable-man \
	--disable-doc \
	--disable-dnie-ui \
	--disable-notify \
	--disable-cmocka \
	--disable-static

HOST_OPENSC_CPPFLAGS := -Wno-implicit-fallthrough

$(STATEDIR)/host-opensc.install.post:
	@$(call targetinfo)
#	# These files are symlinks to ../<name>. PTXdist updates the rpath for
#	# the real file so it is wrong for the symlink. Fix it here afterwards.
	@$(foreach plugin,$(wildcard $(HOST_OPENSC_PKGDIR)/usr/lib/pkcs11/*.so), \
		chrpath --replace '$${ORIGIN}/../' $(plugin) > /dev/null$(ptx/nl))
	@$(call world/install.post, HOST_OPENSC)
	@$(call touch)

# vim: syntax=make
