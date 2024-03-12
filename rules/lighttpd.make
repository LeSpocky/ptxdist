# -*-makefile-*-
#
# Copyright (C) 2007 by Daniel Schnell
#		2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIGHTTPD) += lighttpd

#
# Paths and names
#
LIGHTTPD_VERSION	:= 1.4.74
LIGHTTPD_MD5		:= f38c400232151c69cc608fca35e593a9
LIGHTTPD		:= lighttpd-$(LIGHTTPD_VERSION)
LIGHTTPD_SUFFIX		:= tar.xz
LIGHTTPD_URL		:= http://download.lighttpd.net/lighttpd/releases-1.4.x/$(LIGHTTPD).$(LIGHTTPD_SUFFIX)
LIGHTTPD_SOURCE		:= $(SRCDIR)/$(LIGHTTPD).$(LIGHTTPD_SUFFIX)
LIGHTTPD_DIR		:= $(BUILDDIR)/$(LIGHTTPD)
LIGHTTPD_LICENSE	:= BSD-3-Clause AND OML AND RSA-MD
LIGHTTPD_LICENSE_FILES	:= \
	file://COPYING;md5=e4dac5c6ab169aa212feb5028853a579 \
	file://src/compat/fastcgi.h;startline=7;endline=15;md5=fe9ffe753772839aace9c90e814bc356 \
	file://src/algo_md5.c;startline=12;endline=32;md5=b5be3b6afd4afa7bb89b16361244f9b6

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIGHTTPD_CONF_TOOL	:= autoconf
LIGHTTPD_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--libdir=/usr/lib/lighttpd \
	--$(call ptx/endis, PTXCONF_GLOBAL_LARGE_FILE)-lfs \
	$(GLOBAL_LARGE_FILE_OPTION) \
	$(GLOBAL_IPV6_OPTION) \
	--disable-mmap \
	--enable-extra-warnings \
	--without-libev \
	--without-mysql \
	--without-pgsql \
	--without-dbi \
	--without-sasl \
	--without-ldap \
	--without-pam \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_ATTR)-attr \
	--without-valgrind \
	--without-libunwind \
	--without-krb5 \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_OPENSSL)-openssl \
	--without-wolfssl \
	--without-mbedtls \
	--without-nettle \
	--without-gnutls \
	--without-nss \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_PCRE)-pcre \
	--without-pcre2 \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_ZLIB)-zlib \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_ZSTD)-zstd \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_BZ2LIB)-bzip2 \
	--without-brotli \
	--without-libdeflate \
	--without-fam \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_WEBDAV_PROPS)-webdav-props \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_WEBDAV_PROPS)-libxml \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_WEBDAV_PROPS)-sqlite \
	--without-webdav-locks \
	--without-xxhash \
	--without-maxminddb \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_LUA)-lua

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------
$(STATEDIR)/lighttpd.install:
	@$(call targetinfo)
	@$(call world/install, LIGHTTPD)
	@install -vD -m 0644 "$(LIGHTTPD_DIR)/doc/config/conf.d/mime.conf" \
		"$(LIGHTTPD_PKGDIR)/etc/lighttpd/conf.d/mime.conf"
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

LIGHTTPD_MODULES-y :=
LIGHTTPD_MODULES-$(PTXCONF_LIGHTTPD_MOD_ACCESSLOG)	+= mod_accesslog
LIGHTTPD_MODULES-$(PTXCONF_LIGHTTPD_MOD_AUTH)		+= mod_auth
LIGHTTPD_MODULES-$(PTXCONF_LIGHTTPD_MOD_AUTH)		+= mod_authn_file
LIGHTTPD_MODULES-$(PTXCONF_LIGHTTPD_MOD_DEFLATE)	+= mod_deflate
LIGHTTPD_MODULES-$(PTXCONF_LIGHTTPD_MOD_DIRLISTING)	+= mod_dirlisting
LIGHTTPD_MODULES-$(PTXCONF_LIGHTTPD_MOD_H2)			+= mod_h2
LIGHTTPD_MODULES-$(PTXCONF_LIGHTTPD_MOD_MAGNET)		+= mod_magnet
LIGHTTPD_MODULES-$(PTXCONF_LIGHTTPD_OPENSSL)		+= mod_openssl
LIGHTTPD_MODULES-$(PTXCONF_LIGHTTPD_MOD_WEBDAV)		+= mod_webdav
LIGHTTPD_MODULES-y += $(call remove_quotes,$(PTXCONF_LIGHTTPD_MOD_EXTRA))

LIGHTTPD_MODULE_STRING := $(subst $(space),$(comma),$(addsuffix \",$(addprefix \",$(LIGHTTPD_MODULES-y))))

$(STATEDIR)/lighttpd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lighttpd)
	@$(call install_fixup, lighttpd,PRIORITY,optional)
	@$(call install_fixup, lighttpd,SECTION,base)
	@$(call install_fixup, lighttpd,AUTHOR,"Daniel Schnell <danielsch@marel.com>")
	@$(call install_fixup, lighttpd,DESCRIPTION,missing)

#	# bins
	@$(call install_copy, lighttpd, 0, 0, 0755, -, \
		/usr/sbin/lighttpd)
	@$(call install_copy, lighttpd, 0, 0, 0755, -, \
		/usr/sbin/lighttpd-angel)

ifdef PTXCONF_LIGHTTPD_INSTALL_SELECTED_MODULES
	@$(foreach mod,$(LIGHTTPD_MODULES-y), \
		$(call install_lib, lighttpd, 0, 0, 0644, lighttpd/$(mod))$(ptx/nl))
else
#	# modules
	@$(call install_tree, lighttpd, 0, 0, -, /usr/lib/lighttpd)
endif

#	#
#	# configs
#	#
	@$(call install_alternative, lighttpd, 0, 0, 0644, \
		/etc/lighttpd/lighttpd.conf)
	@$(call install_copy, lighttpd, 0, 0, 0755, /etc/lighttpd/conf.d)
	@$(call install_replace, lighttpd, /etc/lighttpd/lighttpd.conf, \
		@MODULES@, $(LIGHTTPD_MODULE_STRING))
	@$(call install_replace, lighttpd, /etc/lighttpd/lighttpd.conf, \
		@NOH2@, $(call ptx/ifdef, PTXCONF_LIGHTTPD_MOD_H2,"#",))
	@$(call install_alternative, lighttpd, 0, 0, 0644, \
		/etc/lighttpd/conf.d/mime.conf)

ifdef PTXCONF_LIGHTTPD_MOD_FASTCGI_PHP
	@$(call install_alternative, lighttpd, 0, 0, 0644, \
		/etc/lighttpd/conf.d/mod_fastcgi_php.conf)
endif

#	#
#	# busybox init: start script
#	#

ifdef PTXCONF_LIGHTTPD_STARTSCRIPT
	@$(call install_alternative, lighttpd, 0, 0, 0755, /etc/init.d/lighttpd)

ifneq ($(call remove_quotes, $(PTXCONF_LIGHTTPD_BBINIT_LINK)),)
	@$(call install_link, lighttpd, \
		../init.d/lighttpd, \
		/etc/rc.d/$(PTXCONF_LIGHTTPD_BBINIT_LINK))
endif
endif

ifdef PTXCONF_LIGHTTPD_SYSTEMD_UNIT
	@$(call install_alternative, lighttpd, 0, 0, 0644, \
		/usr/lib/systemd/system/lighttpd.service)
	@$(call install_link, lighttpd, ../lighttpd.service, \
		/usr/lib/systemd/system/multi-user.target.wants/lighttpd.service)
endif

ifdef PTXCONF_LIGHTTPD_GENERIC_SITE
ifdef PTXCONF_LIGHTTPD_MOD_FASTCGI_PHP
	@$(call install_copy, lighttpd, www, www, 0644, \
		$(PTXDIST_TOPDIR)/projectroot/var/www/lighttpd.html, \
		/var/www/index.html)

	@$(call install_copy, lighttpd, www, www, 0644, \
		$(PTXDIST_TOPDIR)/projectroot/var/www/bottles.php, \
		/var/www/bottles.php)

	@$(call install_copy, lighttpd, www, www, 0644, \
		$(PTXDIST_TOPDIR)/projectroot/var/www/more_bottles.php, \
		/var/www/more_bottles.php)
else
	@$(call install_copy, lighttpd, www, www, 0644, \
		$(PTXDIST_TOPDIR)/projectroot/var/www/httpd.html, \
		/var/www/index.html)
endif
endif

	@$(call install_finish, lighttpd)
	@$(call touch)

# vim: syntax=make
