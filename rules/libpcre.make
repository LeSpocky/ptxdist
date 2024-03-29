# -*-makefile-*-
#
# Copyright (C) 2004 by Robert Schwebel
#               2008, 2009, 2010, 2016 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBPCRE) += libpcre

#
# Paths and names
#
LIBPCRE_VERSION	:= 8.45
LIBPCRE_MD5	:= 4452288e6a0eefb2ab11d36010a1eebb
LIBPCRE		:= pcre-$(LIBPCRE_VERSION)
LIBPCRE_SUFFIX	:= tar.bz2
LIBPCRE_URL	:= \
	$(call ptx/mirror, SF, pcre/$(LIBPCRE).$(LIBPCRE_SUFFIX)) \
	https://ftp.pcre.org/pub/pcre/$(LIBPCRE).$(LIBPCRE_SUFFIX)
LIBPCRE_SOURCE	:= $(SRCDIR)/$(LIBPCRE).$(LIBPCRE_SUFFIX)
LIBPCRE_DIR	:= $(BUILDDIR)/$(LIBPCRE)
LIBPCRE_LICENSE	:= BSD-3-Clause
LIBPCRE_LICENSE_FILES := file://LICENCE;md5=b5d5d1a69a24ea2718263f1ff85a1c58

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
# Note: the --enable-newline-* options are broken. Only one should be used
LIBPCRE_CONF_TOOL	:= autoconf
LIBPCRE_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-pcre8 \
	--enable-pcre16 \
	--enable-pcre32 \
	--$(call ptx/endis, PTXCONF_LIBPCRE_LIBPCRECPP)-cpp \
	--disable-jit \
	--enable-pcregrep-jit \
	--disable-rebuild-chartables \
	--$(call ptx/endis, PTXCONF_LIBPCRE_ENABLE_UTF8)-utf \
	--$(call ptx/endis, PTXCONF_LIBPCRE_ENABLE_UTF8)-unicode-properties \
	$(call ptx/ifdef, PTXCONF_LIBPCRE_ENABLE_NEWLINE_IS_ANYCRLF,,--enable-newline-is-lf) \
	$(call ptx/ifdef, PTXCONF_LIBPCRE_ENABLE_NEWLINE_IS_ANYCRLF,--enable-newline-is-anycrlf) \
	--disable-bsr-anycrlf \
	--disable-ebcdic \
	--disable-ebcdic-nl25 \
	--enable-stack-for-recursion \
	--$(call ptx/endis, PTXCONF_LIBPCRE_ENABLE_PCREGREP_LIBZ)-pcregrep-libz \
	--$(call ptx/endis, PTXCONF_LIBPCRE_ENABLE_PCREGREP_LIBBZ2)-pcregrep-libbz2 \
	--disable-pcretest-libedit \
	--disable-pcretest-libreadline \
	--disable-valgrind \
	--disable-coverage \
	--with-pcregrep-bufsize=20480 \
	--with-posix-malloc-threshold=10 \
	--with-link-size=2 \
	--with-parens-nest-limit=250 \
	--with-match-limit=10000000 \
	--with-match-limit-recursion=10000000

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libpcre.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libpcre)
	@$(call install_fixup, libpcre,PRIORITY,optional)
	@$(call install_fixup, libpcre,SECTION,base)
	@$(call install_fixup, libpcre,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libpcre,DESCRIPTION,missing)

	@$(call install_lib, libpcre, 0, 0, 0644, libpcre)

ifdef PTXCONF_LIBPCRE_LIBPCREPOSIX
	@$(call install_lib, libpcre, 0, 0, 0644, libpcreposix)
endif
ifdef PTXCONF_LIBPCRE_LIBPCRECPP
	@$(call install_lib, libpcre, 0, 0, 0644, libpcrecpp)
endif

ifdef PTXCONF_LIBPCRE_PCREGREP
	@$(call install_copy, libpcre, 0, 0, 0755, -, /usr/bin/pcregrep)
endif

	@$(call install_finish, libpcre)

	@$(call touch)

# vim: syntax=make
