# -*-makefile-*-
# Copyright (C) 2006 by Robert Schwebel
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PUREFTPD) += pureftpd

#
# Paths and names
#
PUREFTPD_VERSION	:= 1.0.52
PUREFTPD_MD5		:= 6fdd75053b7aaa0f45089a7bf7fcd0b4
PUREFTPD		:= pure-ftpd-$(PUREFTPD_VERSION)
PUREFTPD_SUFFIX		:= tar.bz2
PUREFTPD_URL		:= \
	http://download.pureftpd.org/pub/pure-ftpd/releases/$(PUREFTPD).$(PUREFTPD_SUFFIX) \
	http://download.pureftpd.org/pub/pure-ftpd/releases/obsolete/$(PUREFTPD).$(PUREFTPD_SUFFIX)
PUREFTPD_SOURCE		:= $(SRCDIR)/$(PUREFTPD).$(PUREFTPD_SUFFIX)
PUREFTPD_DIR		:= $(BUILDDIR)/$(PUREFTPD)
PUREFTPD_LICENSE	:= ISC AND BSD-2-Clause AND BSD-3-Clause AND BSD-4-Clause
PUREFTPD_LICENSE_FILES	:= \
	file://COPYING;md5=5138d4a8a877b32de6a78cf7e9e99c25 \
	file://src/bsd-getopt_long.c;startline=16;endline=43;md5=295b2603ea44ba63d947caed65e10801 \
	file://src/bsd-glob.c;startline=2;endline=32;md5=8fd02637c51e4790905f94ede93f40f5 \
	file://src/bsd-getopt_long.h;startline=20;endline=54;md5=72453a000b4b09da65c73ee68c527048

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
PUREFTPD_CONF_TOOL	:= autoconf
PUREFTPD_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--without-dmalloc \
	--with-standalone \
	--$(call ptx/wwo, PTXCONF_PUREFTPD_SYSTEMD_UNIT)-inetd \
	--without-capabilities \
	--with-shadow \
	--with-usernames \
	--with-iplogging \
	--with-humor \
	--without-ascii \
	--$(call ptx/ifdef, PTXCONF_PUREFTPD_SHRINK_MORE,without,with)-globbing \
	--with-nonalnum \
	--with-unicode \
	--with-sendfile \
	--without-privsep \
	--without-boring \
	--without-brokenrealpath \
	--$(call ptx/wwo, PTXCONF_PUREFTPD_MINIMAL)-minimal \
	--without-paranoidmsg \
	--without-sysquotas \
	--without-altlog \
	--with-puredb \
	--without-extauth \
	--without-pam \
	--without-cookie \
	--without-throttling \
	--without-ratios \
	--without-quotas \
	--without-ftpwho \
	--with-welcomemsg \
	--$(call ptx/wwo, PTXCONF_PUREFTPD_UPLOADSCRIPT)-uploadscript \
	--$(call ptx/wwo, PTXCONF_PUREFTPD_VIRTUALHOSTS)-virtualhosts \
	--without-virtualchroot \
	--$(call ptx/wwo, PTXCONF_PUREFTPD_DIRALIASES)-diraliases \
	--without-nonroot \
	--without-peruserlimits \
	--without-implicittls \
	--without-debug \
	--with-language=english \
	--without-ldap \
	--without-mysql \
	--without-pgsql \
	--without-tls

#
# FIXME: configure probes host's /dev/urandom and /dev/random
# instead of target's one

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

PUREFTPD_ARGS := $(call remove_quotes,$(PTXCONF_PUREFTPD_ARGS))
ifdef PTXCONF_PUREFTPD_UPLOADSCRIPT
PUREFTPD_ARGS += -o
endif

$(STATEDIR)/pureftpd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pureftpd)
	@$(call install_fixup, pureftpd,PRIORITY,optional)
	@$(call install_fixup, pureftpd,SECTION,base)
	@$(call install_fixup, pureftpd,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, pureftpd,DESCRIPTION,missing)

	@$(call install_copy, pureftpd, 0, 0, 0755, -, \
		/usr/sbin/pure-ftpd)

	@$(call install_alternative, pureftpd, 0, 0, 0644, /etc/pure-ftpd.conf)

	@$(call install_copy, pureftpd, 0, 0, 0755, -, \
		/usr/bin/pure-pw)

ifdef PTXCONF_PUREFTPD_UPLOADSCRIPT
	@$(call install_copy, pureftpd, 0, 0, 0755, -, \
		/usr/sbin/pure-uploadscript)
endif

#	#
#	# busybox init
#	#
ifdef PTXCONF_PUREFTPD_STARTSCRIPT
	@$(call install_alternative, pureftpd, 0, 0, 0755, /etc/init.d/pureftpd)

	@$(call install_replace, pureftpd, \
		/etc/init.d/pureftpd, \
		@DAEMON_ARGS@, "$(PUREFTPD_ARGS)")
	@$(call install_replace, pureftpd, \
		/etc/init.d/pureftpd, \
		@HELPER_ARGS@, $(PTXCONF_PUREFTPD_UPLOADSCRIPT_ARGS))
	@$(call install_replace, pureftpd, \
		/etc/init.d/pureftpd, \
		@HELPER_SCRIPT@, $(PTXCONF_PUREFTPD_UPLOADSCRIPT_SCRIPT))

ifneq ($(call remove_quotes,$(PTXCONF_PUREFTPD_BBINIT_LINK)),)
	@$(call install_link, pureftpd, \
		../init.d/pureftpd, \
		/etc/rc.d/$(PTXCONF_PUREFTPD_BBINIT_LINK))
endif
endif

ifdef PTXCONF_PUREFTPD_SYSTEMD_UNIT
	@$(call install_alternative, pureftpd, 0, 0, 0644, \
		/usr/lib/systemd/system/pure-ftpd.socket)
	@$(call install_link, pureftpd, ../pure-ftpd.socket, \
		/usr/lib/systemd/system/sockets.target.wants/pure-ftpd.socket)

	@$(call install_alternative, pureftpd, 0, 0, 0644, \
		/usr/lib/systemd/system/pure-ftpd@.service)
	@$(call install_replace, pureftpd, \
		/usr/lib/systemd/system/pure-ftpd@.service, \
		@ARGS@, "$(PUREFTPD_ARGS)")
ifndef PTXCONF_PUREFTPD_UPLOADSCRIPT
	@$(call install_replace, pureftpd, \
		/usr/lib/systemd/system/pure-ftpd@.service, \
		@SCRIPT_DEPS@, "")
else
	@$(call install_replace, pureftpd, \
		/usr/lib/systemd/system/pure-ftpd@.service, \
		@SCRIPT_DEPS@, "Requires=pure-uploadscript.service\nAfter=pure-uploadscript.service\n")

	@$(call install_alternative, pureftpd, 0, 0, 0644, \
		/usr/lib/systemd/system/pure-uploadscript.service)
	@$(call install_replace, pureftpd, \
		/usr/lib/systemd/system/pure-uploadscript.service, \
		@ARGS@, $(PTXCONF_PUREFTPD_UPLOADSCRIPT_ARGS))
endif
endif

	@$(call install_finish, pureftpd)

	@$(call touch)

# vim: syntax=make
