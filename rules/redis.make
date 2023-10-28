# -*-makefile-*-
#
# Copyright (C) 2021 by Clemens Gruber <clemens.gruber@pqgruber.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_REDIS) += redis

#
# Paths and names
#
REDIS_VERSION		:= 7.2.2
REDIS_MD5		:= 5ece867a53b30f31266a2130fd10568d
REDIS			:= redis-$(REDIS_VERSION)
REDIS_SUFFIX		:= tar.gz
REDIS_URL		:= https://download.redis.io/releases/$(REDIS).$(REDIS_SUFFIX)
REDIS_SOURCE		:= $(SRCDIR)/$(REDIS).$(REDIS_SUFFIX)
REDIS_DIR		:= $(BUILDDIR)/$(REDIS)
REDIS_LICENSE		:= BSD-3-Clause
REDIS_LICENSE_FILES	:= file://COPYING;md5=8ffdd6c926faaece928cf9d9640132d2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

REDIS_CONF_TOOL := NO

REDIS_MAKE_ENV := \
	$(CROSS_ENV)

REDIS_ARCH := $(PTXCONF_ARCH_STRING)
# the relevant check is for armv*, so there is no need for special v6/v7
# handling
ifdef PTXCONF_ARCH_ARM
REDIS_ARCH := armv5
endif

REDIS_MAKE_OPT := \
	CC=$(CROSS_CC) \
	PREFIX=/usr \
	USE_JEMALLOC=no \
	USE_SYSTEMD=$(call ptx/ifdef,PTXCONF_REDIS_SYSTEMD,yes,no) \
	uname_M=$(REDIS_ARCH) \
	uname_S=Linux \
	all

REDIS_INSTALL_OPT := \
	PREFIX=$(REDIS_PKGDIR)/usr \
	install


# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/redis.install:
	@$(call targetinfo)
	@$(call world/install, REDIS)
	@install -v -D -m644 $(REDIS_DIR)/redis.conf \
		$(REDIS_PKGDIR)/etc/redis.conf
	@$(call touch)


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/redis.targetinstall:
	@$(call targetinfo)

	@$(call install_init, redis)
	@$(call install_fixup, redis,PRIORITY,optional)
	@$(call install_fixup, redis,SECTION,base)
	@$(call install_fixup, redis,AUTHOR,"Clemens Gruber <clemens.gruber@pqgruber.com>")
	@$(call install_fixup, redis,DESCRIPTION,"An in-memory database that persists on disk")

	@$(call install_copy, redis, 0, 0, 0755, -, /usr/bin/redis-benchmark)
	@$(call install_copy, redis, 0, 0, 0755, -, /usr/bin/redis-cli)
	@$(call install_copy, redis, 0, 0, 0755, -, /usr/bin/redis-server)

	@$(call install_link, redis, /usr/bin/redis-server, /usr/bin/redis-check-aof)
	@$(call install_link, redis, /usr/bin/redis-server, /usr/bin/redis-check-rdb)

	@$(call install_alternative, redis, 0, 0, 0644, /etc/redis.conf)

	@$(call install_copy, redis, 0, 0, 0700, /var/lib/redis)

ifdef PTXCONF_REDIS_SYSTEMD_UNIT
	@$(call install_alternative, redis, 0, 0, 0644, /usr/lib/systemd/system/redis.service)
	@$(call install_link, redis, ../redis.service, \
		/usr/lib/systemd/system/multi-user.target.wants/redis.service)
endif
	@$(call install_alternative, redis, 0, 0, 0644, /usr/lib/tmpfiles.d/redis.conf)

	@$(call install_finish, redis)

	@$(call touch)

# vim: syntax=make
