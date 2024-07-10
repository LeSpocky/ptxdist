# -*-makefile-*-
#
# Copyright (C) 2012 by Jan Luebbe <jlu@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CRDA) += crda

#
# Paths and names
#
CRDA_VERSION	:= 4.15
CRDA_MD5	:= 30797103dfaae807b6ece1a695518dc1
CRDA		:= crda-$(CRDA_VERSION)
CRDA_SUFFIX	:= tar.gz
CRDA_URL	:= https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/crda.git/snapshot/$(CRDA).$(CRDA_SUFFIX)
CRDA_SOURCE	:= $(SRCDIR)/$(CRDA).$(CRDA_SUFFIX)
CRDA_DIR	:= $(BUILDDIR)/$(CRDA)
CRDA_LICENSE	:= ISC AND copyleft-next-0.3.0
CRDA_LICENSE_FILES := \
	file://LICENSE;md5=ef8b69b43141352d821fd66b64ff0ee7 \
	file://copyleft-next-0.3.0;md5=8743a2c359037d4d329a31e79eabeffe

CRDA_REGDB_VERSION	:= 2024.07.04
CRDA_REGDB_MD5		:= 3519703d79b5ffd3ce6ed1219d6ef392
CRDA_REGDB		:= wireless-regdb-$(CRDA_REGDB_VERSION)
CRDA_REGDB_SUFFIX	:= tar.gz
CRDA_REGDB_URL		:= \
	https://www.kernel.org/pub/software/network/wireless-regdb/$(CRDA_REGDB).$(CRDA_REGDB_SUFFIX)
CRDA_REGDB_SOURCE	:= $(SRCDIR)/$(CRDA_REGDB).$(CRDA_REGDB_SUFFIX)
CRDA_REGDB_DIR		:= $(CRDA_DIR)
CRDA_REGDB_STRIP_LEVEL	:= 0

CRDA_PARTS		+= CRDA_REGDB

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

CRDA_MAKE_ENV	:= \
	$(CROSS_ENV) \
	SBINDIR=/usr/sbin/ \
	UDEV_RULE_DIR=/usr/lib/udev/rules.d/ \
	USE_OPENSSL=1 \
	RUNTIME_PUBKEY_DIR=/usr/lib/crda/pubkeys \
	RUNTIME_PUBKEY_ONLY=1

CRDA_MAKE_OPT	:= all_noverify
CRDA_CFLAGS	:= -Wno-error=deprecated-declarations

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/crda.install:
	@$(call targetinfo)
	@$(call world/install, CRDA)
	@install -vD -m 644 $(CRDA_REGDB_DIR)/$(CRDA_REGDB)/regulatory.bin \
		$(CRDA_PKGDIR)/usr/lib/crda/regulatory.bin
	@install -vD -m 0644 $(CRDA_REGDB_DIR)/$(CRDA_REGDB)/regulatory.db \
		 $(CRDA_PKGDIR)/lib/firmware/regulatory.db
	@install -vD -m 0644 $(CRDA_REGDB_DIR)/$(CRDA_REGDB)/regulatory.db.p7s \
		 $(CRDA_PKGDIR)/lib/firmware/regulatory.db.p7s
	@install -vD -m 644 $(CRDA_REGDB_DIR)/pubkeys/linville.key.pub.pem \
		$(CRDA_PKGDIR)/usr/lib/crda/pubkeys/linville.key.pub.pem
	@install -vD -m 644 $(CRDA_REGDB_DIR)/pubkeys/sforshee.key.pub.pem \
		$(CRDA_PKGDIR)/usr/lib/crda/pubkeys/sforshee.key.pub.pem
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/crda.targetinstall:
	@$(call targetinfo)

	@$(call install_init, crda)
	@$(call install_fixup, crda,PRIORITY,optional)
	@$(call install_fixup, crda,SECTION,base)
	@$(call install_fixup, crda,AUTHOR,"Jan Luebbe <jlu@pengutronix.de>")
	@$(call install_fixup, crda,DESCRIPTION,missing)

ifndef PTXCONF_CRDA_ONLY_REGULATORY_DB
	@$(call install_copy, crda, 0, 0, 0755, -, /usr/sbin/crda)
	@$(call install_copy, crda, 0, 0, 0755, -, /usr/sbin/regdbdump)
	@$(call install_copy, crda, 0, 0, 0644, -, \
		/usr/lib/udev/rules.d/85-regulatory.rules)
	@$(call install_lib, crda, 0, 0, 0644, libreg)

	@$(call install_alternative_tree, crda, 0, 0, \
		/usr/lib/crda/pubkeys)
	@$(call install_alternative, crda, 0, 0, 0644, \
		/usr/lib/crda/regulatory.bin)
endif

	@$(call install_alternative, crda, 0, 0, 0644, \
		/lib/firmware/regulatory.db)
	@$(call install_alternative, crda, 0, 0, 0644, \
		/lib/firmware/regulatory.db.p7s)

	@$(call install_finish, crda)

	@$(call touch)

# vim: syntax=make
