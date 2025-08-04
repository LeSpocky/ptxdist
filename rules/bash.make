# -*-makefile-*-
#
# Copyright (C) 2003-2009 by Pengutronix e.K., Hildesheim, Germany
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BASH) += bash

#
# Paths and names
#
BASH_VERSION	:= 5.3
BASH_MD5	:= 977c8c0c5ae6309191e7768e28ebc951 4c7fb7d82586f93ab1d833ef20378ee8
BASH		:= bash-$(BASH_VERSION)
BASH_SUFFIX	:= tar.gz
BASH_URL	:= $(call ptx/mirror, GNU, bash/$(BASH).$(BASH_SUFFIX))
BASH_SOURCE	:= $(SRCDIR)/$(BASH).$(BASH_SUFFIX)
BASH_DIR	:= $(BUILDDIR)/$(BASH)
BASH_LICENSE	:= GPL-3.0-or-later
BASH_LICENSE_FILES	:= \
	file://COPYING;md5=d32239bcb673463ab874e80d47fae504 \
	file://general.c;startline=1;endline=19;md5=58a7da9d30894a1d5a3c10e9eedbd393

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BASH_CONF_ENV	:= \
	$(CROSS_ENV) \
	CFLAGS_FOR_BUILD="-std=gnu11" \
	bash_cv_job_control_missing=$(call ptx/ifdef, PTXCONF_BASH_JOBS, present, missing) \
	bash_cv_termcap_lib=$(call ptx/ifdef, PTXCONF_BASH_CURSES, libncurses, libtermcap)

BASH_CONF_TOOL	:= autoconf
BASH_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_BASH_SHLIKE)-minimal-config \
	--$(call ptx/endis, PTXCONF_BASH_ALIASES)-alias \
	--disable-alt-array-implementation \
	--$(call ptx/endis, PTXCONF_BASH_ARITHMETIC_FOR)-arith-for-command \
	--$(call ptx/endis, PTXCONF_BASH_ARRAY)-array-variables \
	--$(call ptx/endis, PTXCONF_BASH_HISTORY)-bang-history \
	--disable-bash-source-fullpath-default \
	--$(call ptx/endis, PTXCONF_BASH_BRACE)-brace-expansion \
	--$(call ptx/endis, PTXCONF_BASH_CASEMODATTR)-casemod-attributes \
	--$(call ptx/endis, PTXCONF_BASH_CASEMODEXP)-casemod-expansions \
	--$(call ptx/endis, PTXCONF_BASH_CMDTIMING)-command-timing \
	--$(call ptx/endis, PTXCONF_BASH_CONDITIONAL)-cond-command \
	--$(call ptx/endis, PTXCONF_BASH_CONDITIONAL_REGEX)-cond-regexp \
	--$(call ptx/endis, PTXCONF_BASH_COPROCESSES)-coprocesses \
	--$(call ptx/endis, PTXCONF_BASH_DEBUGGER)-debugger \
	--disable-dev-fd-stat-broken \
	--$(call ptx/endis, PTXCONF_BASH_DIREXPDEFLT)-direxpand-default \
	--$(call ptx/endis, PTXCONF_BASH_DIRSTACK)-directory-stack \
	--$(call ptx/endis, PTXCONF_BASH_DISABLED_BUILDINS)-disabled-builtins \
	--$(call ptx/endis, PTXCONF_BASH_DPARAN_ARITH)-dparen-arithmetic \
	--$(call ptx/endis, PTXCONF_BASH_EXTPATTERN)-extended-glob \
	--$(call ptx/endis, PTXCONF_BASH_EXTPATTERN_DEFLT)-extended-glob-default \
	--enable-function-import \
	--$(call ptx/endis, PTXCONF_BASH_GLOB_ASCIIRANGE_DEFLT)-glob-asciiranges-default \
	--$(call ptx/endis, PTXCONF_BASH_HELP)-help-builtin \
	--$(call ptx/endis, PTXCONF_BASH_CMDHISTORY)-history \
	--$(call ptx/endis, PTXCONF_BASH_JOBS)-job-control \
	--$(call ptx/endis, PTXCONF_BASH_MULTIBYTE)-multibyte \
	--disable-net-redirections \
	--$(call ptx/endis, PTXCONF_BASH_PROCSUBST)-process-substitution \
	--$(call ptx/endis, PTXCONF_BASH_BASHCOMPLETION)-progcomp \
	--$(call ptx/endis, PTXCONF_BASH_ESC)-prompt-string-decoding \
	--$(call ptx/endis, PTXCONF_BASH_EDIT)-readline \
	--$(call ptx/endis, PTXCONF_BASH_RESTRICTED)-restricted \
	--$(call ptx/endis, PTXCONF_BASH_SELECT)-select \
	--$(call ptx/endis, PTXCONF_BASH_SEP_HELPFILES)-separate-helpfiles \
	--$(call ptx/endis, PTXCONF_BASH_SINGLE_HELPLINE)-single-help-strings \
	--disable-strict-posix-default \
	--enable-translatable-strings \
	--disable-usg-echo-default \
	--disable-xpg-echo-default \
	--$(call ptx/endis, PTXCONF_BASH_MEM_SCRAMBLE)-mem-scramble \
	--$(call ptx/endis, PTXCONF_BASH_GPROF)-profiling \
	--$(call ptx/endis, PTXCONF_BASH_STATIC)-static-link \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-threads=posix \
	--$(call ptx/endis, PTXDIST_Y2038)-year2038 \
	--without-afs \
	--without-bash-malloc \
	--$(call ptx/wwo, PTXCONF_BASH_CURSES)-curses \
	--without-gnu-malloc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bash.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bash)
	@$(call install_fixup, bash,PRIORITY,optional)
	@$(call install_fixup, bash,SECTION,base)
	@$(call install_fixup, bash,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, bash,DESCRIPTION,missing)

	@$(call install_copy, bash, 0, 0, 0755, -, /usr/bin/bash)
ifdef PTXCONF_BASH_SH
	@$(call install_link, bash, bash, /usr/bin/sh)
endif

	@$(call install_finish, bash)

	@$(call touch)

# vim: syntax=make
