# -*-makefile-*-
#
# Copyright (C) 2024 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_X86_64)-$(PTXCONF_MONGODB) += mongodb
PACKAGES-$(PTXCONF_ARCH_ARM64)-$(PTXCONF_MONGODB) += mongodb
PACKAGES-$(PTXCONF_ARCH_RISCV)-$(PTXCONF_MONGODB) += mongodb

#
# Paths and names
#
MONGODB_VERSION		:= 7.2.2
MONGODB_MD5		:= c46c7daf888a33e2b295c25ece6382a1
MONGODB			:= mongodb-$(MONGODB_VERSION)
MONGODB_SUFFIX		:= tar.gz
MONGODB_URL		:= https://github.com/mongodb/mongo/archive/refs/tags/r$(MONGODB_VERSION).$(MONGODB_SUFFIX)
MONGODB_SOURCE		:= $(SRCDIR)/$(MONGODB).$(MONGODB_SUFFIX)
MONGODB_DIR		:= $(BUILDDIR)/$(MONGODB)
MONGODB_BUILD_OOT	:= YES
MONGODB_LICENSE		:= SSPL-1.0
MONGODB_LICENSE_FILES	:= \
	file://LICENSE-Community.txt;md5=3a865f27f11f43ecbe542d9ea387dcf1

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MONGODB_CONF_ENV := \
	$(CROSS_ENV)

ifdef PTXCONF_TARGET_DEBUG_KEEP
# disable debugging by default to reduce the memory useage at build-time
MONGODB_CONF_ENV += \
	PTXCONF_TARGET_DEBUG_OFF=y
endif

#
# scons
#
MONGODB_CONF_TOOL	:= scons
MONGODB_CONF_OPT	:=  \
	$(CROSS_ENV_CC) \
	$(CROSS_ENV_CXX) \
	MONGO_VERSION=$(MONGODB_VERSION) \
	-C $(MONGODB_DIR) \
	--build-profile=default \
	--ninja=disabled \
	--force-jobs \
	--release \
	--ssl=on \
	--wiredtiger=on \
	--ocsp-stapling=off \
	--js-engine=mozjs \
	--server-js=on \
	--separate-debug=off \
	--build-dir=$(MONGODB_DIR)-build \
	--use-system-pcre2 \
	--use-system-zlib \
	--use-system-zstd \
	--disable-warnings-as-errors \
	--linker=gold \
	--git-decider=off \
	--use-libunwind=off \
	--build-metrics="" \
	install-mongod

$(STATEDIR)/mongodb.prepare:
	@$(call targetinfo)
	@$(call world/prepare, MONGODB)
	@$(call touch)

MONGODB_CXXFLAGS := \
	-Wno-non-virtual-dtor \
	-Wno-interference-size

MONGODB_INSTALL_OPT := \
	$(MONGODB_CONF_OPT) \
	DESTDIR=$(MONGODB_PKGDIR) \
	PREFIX=/usr

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mongodb.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mongodb)
	@$(call install_fixup, mongodb,PRIORITY,optional)
	@$(call install_fixup, mongodb,SECTION,base)
	@$(call install_fixup, mongodb,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, mongodb,DESCRIPTION,missing)

	@$(call install_copy, mongodb, 0, 0, 0755, -, /usr/bin/mongod)

	@$(call install_copy, mongodb, mongodb, mongodb, 0755, /var/lib/mongodb)

	@$(call install_alternative, mongodb, 0, 0, 0644, \
		/usr/lib/systemd/system/mongod.service)
	@$(call install_link, mongodb, ../mongod.service, \
		/usr/lib/systemd/system/multi-user.target.wants/mongod.service)

	@$(call install_finish, mongodb)

	@$(call touch)

# vim: syntax=make
