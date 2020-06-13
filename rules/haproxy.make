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
PACKAGES-$(PTXCONF_HAPROXY) += haproxy

#
# Paths and names
#
HAPROXY_VERSION		:= 2.1.6
HAPROXY_MD5		:= 95ffd25fc6b57b4f1650322a7587f972
HAPROXY			:= haproxy-$(HAPROXY_VERSION)
HAPROXY_SUFFIX		:= tar.gz
HAPROXY_URL		:= https://www.haproxy.org/download/$(basename $(HAPROXY_VERSION))/src/$(HAPROXY).$(HAPROXY_SUFFIX)
HAPROXY_SOURCE		:= $(SRCDIR)/$(HAPROXY).$(HAPROXY_SUFFIX)
HAPROXY_DIR		:= $(BUILDDIR)/$(HAPROXY)
HAPROXY_LICENSE		:= GPL-2.0-or-later AND LGPL-2.1-or-later
HAPROXY_LICENSE_FILES	:= \
	file://doc/gpl.txt;md5=892f569a555ba9c07a568a7c0c4fa63a \
	file://doc/lgpl.txt;md5=fbc093901857fcd118f065f900982c24

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HAPROXY_CONF_TOOL	:= NO
HAPROXY_MAKE_OPT	:= \
	CC=$(CROSS_CC) \
	PREFIX=/usr \
	TARGET=linux-glibc \
	USE_GZIP=1 \
	USE_LUA= \
	USE_OPENSSL=$(call ptx/ifdef,PTXCONF_HAPROXY_OPENSSL,1,) \
	USE_PCRE= \
	USE_RT=1 \
	USE_SLZ= \
	USE_SYSTEMD=$(call ptx/ifdef,PTXCONF_INITMETHOD_SYSTEMD,1,) \
	USE_ZLIB=1

ifdef PTXCONF_ARCH_PPC
HAPROXY_MAKE_OPT	+= \
	TARGET_LDFLAGS=-latomic
endif

HAPROXY_INSTALL_OPT	:= \
	PREFIX=/usr \
	install

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/haproxy.compile:
	@$(call targetinfo)
	@$(call world/compile, HAPROXY)
	@$(call compile, HAPROXY, -C contrib/systemd $(HAPROXY_MAKE_OPT))
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/haproxy.install:
	@$(call targetinfo)
	@$(call world/install, HAPROXY)
	@install -v -D -m644 $(HAPROXY_DIR)/contrib/systemd/haproxy.service \
		$(HAPROXY_PKGDIR)/usr/lib/systemd/system/haproxy.service
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/haproxy.targetinstall:
	@$(call targetinfo)

	@$(call install_init, haproxy)
	@$(call install_fixup, haproxy,PRIORITY,optional)
	@$(call install_fixup, haproxy,SECTION,base)
	@$(call install_fixup, haproxy,AUTHOR,"Bastian Krause <bst@pengutronix.de>")
	@$(call install_fixup, haproxy,DESCRIPTION,missing)

	@$(call install_copy, haproxy, 0, 0, 0755, -, /usr/sbin/haproxy)

	@$(call install_alternative_tree, haproxy, 0, 0, /etc/haproxy)

ifdef PTXCONF_HAPROXY_SYSTEMD_UNIT
	@$(call install_copy, haproxy, 0, 0, 0644, -, \
		/usr/lib/systemd/system/haproxy.service)
	@$(call install_link, haproxy, ../haproxy.service, \
		/usr/lib/systemd/system/multi-user.target.wants/haproxy.service)
endif

	@$(call install_finish, haproxy)

	@$(call touch)

# vim: syntax=make
