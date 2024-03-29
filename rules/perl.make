# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PERL) += perl

#
# Paths and names
#
PERL_VERSION		:= 5.18.2
PERL_MD5		:= 373f57ccc441dbc1812435f45ad20660
PERL			:= perl-$(PERL_VERSION)
PERL_SUFFIX		:= tar.gz
PERL_URL		:= http://cpan.perl.org/src/5.0/$(PERL).$(PERL_SUFFIX)
PERL_SOURCE		:= $(SRCDIR)/$(PERL).$(PERL_SUFFIX)
PERL_DIR		:= $(BUILDDIR)/$(PERL)
PERL_LICENSE		:= GPL-1.0-only
PERL_LICENSE_FILES	:= file://Copying;md5=5b122a36d0f6dc55279a0ebc69f3c60b

PERLCROSS_VERSION	:= 5.18.2-cross-0.8.5
PERLCROSS_MD5		:= 4744dbfd87bc1a694bc6f17ad4c2414f
PERLCROSS_URL		:= https://raw.github.com/arsv/perl-cross/releases/perl-$(PERLCROSS_VERSION).tar.gz
PERLCROSS_SOURCE	:= $(SRCDIR)/perlcross-$(PERLCROSS_VERSION).tar.gz
PERLCROSS_DIR		:= $(PERL_DIR)

PERL_PARTS		+= PERLCROSS

# cross perl need the source dir
PERL_DEVPKG		:= NO
# use by perl modules
PERL_SITELIB		:= /usr/lib/perl5/site_perl/$(PERL_VERSION)

CROSS_PERL= $(PTXDIST_SYSROOT_CROSS)/usr/bin/cross-perl

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
PERL_CONF_TOOL	:= autoconf
PERL_CONF_OPT	:= \
	--mode=cross \
	--prefix=/usr \
	--host=$(PTXCONF_GNU_TARGET) \
	--target=$(PTXCONF_GNU_TARGET) \
	-Dld=$(CROSS_CC) \
	-Dusethreads

PERL_MAKE_PAR	:= NO

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/perl.install.post:
	@$(call targetinfo)
	@$(call world/install.post, PERL)
	@echo '#!/bin/sh'				>  $(CROSS_PERL)
	@echo 'exec $(PERL_DIR)/miniperl_top \'		>> $(CROSS_PERL)
	@echo '	-I$(SYSROOT)$(PERL_SITELIB) \'		>> $(CROSS_PERL)
	@echo '	"$$@" \'				>> $(CROSS_PERL)
	@echo '	PERL=$(PERL_DIR)/miniperl_top \'	>> $(CROSS_PERL)
	@echo '	PERL_SRC=$(PERL_DIR)'			>> $(CROSS_PERL)
	@chmod +x $(CROSS_PERL)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

PERL_PROGRAMS := \
	a2p \
	c2ph \
	config_data \
	corelist \
	enc2xs \
	find2perl \
	h2ph \
	h2xs \
	instmodsh \
	json_pp \
	libnetcfg \
	perl$(PERL_VERSION) \
	perlivp \
	perlthanks \
	piconv \
	pl2pm \
	prove \
	psed \
	pstruct \
	ptar \
	ptardiff \
	ptargrep \
	s2p \
	shasum \
	splain \
	xsubpp \
	zipdetails

$(STATEDIR)/perl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, perl)
	@$(call install_fixup, perl,PRIORITY,optional)
	@$(call install_fixup, perl,SECTION,base)
	@$(call install_fixup, perl,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, perl,DESCRIPTION,missing)

	@$(foreach prog, $(PERL_PROGRAMS), \
		$(call install_copy, perl, 0, 0, 0755, -, \
			/usr/bin/$(prog))$(ptx/nl))

	@$(call install_link, perl, perl$(PERL_VERSION), /usr/bin/perl)

	@$(call install_glob, perl, 0, 0, -, /usr/lib/perl5,, */CORE)

	@$(call install_finish, perl)

	@$(call touch)

# vim: syntax=make
