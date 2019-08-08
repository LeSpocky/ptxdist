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
BASH_VERSION	:= 4.3.30
BASH_MD5	:= a27b3ee9be83bd3ba448c0ff52b28447
BASH		:= bash-$(BASH_VERSION)
BASH_SUFFIX	:= tar.gz
BASH_URL	:= $(call ptx/mirror, GNU, bash/$(BASH).$(BASH_SUFFIX))
BASH_SOURCE	:= $(SRCDIR)/$(BASH).$(BASH_SUFFIX)
BASH_DIR	:= $(BUILDDIR)/$(BASH)
BASH_MAKE_PAR	:= NO
BASH_LICENSE	:= GPL-3.0-or-later
BASH_LICENSE_FILES	:= \
	file://COPYING;md5=d32239bcb673463ab874e80d47fae504 \
	file://general.c;startline=1;endline=19;md5=c018785d21f8c206ca7a13fa7d027568

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BASH_PATH	:= PATH=$(CROSS_PATH)
BASH_ENV	:= \
	$(CROSS_ENV) \
	bash_cv_job_control_missing=$(call ptx/ifdef, PTXCONF_BASH_JOBS, present, missing) \
	bash_cv_termcap_lib=$(call ptx/ifdef, PTXCONF_BASH_CURSES, libncurses, libtermcap)

BASH_AUTOCONF	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--without-bash-malloc \
	--$(call ptx/endis, PTXCONF_BASH_SHLIKE)-minimal-config \
	--$(call ptx/endis, PTXCONF_BASH_ALIASES)-alias \
	--$(call ptx/endis, PTXCONF_BASH_ARITHMETIC_FOR)-arith-for-command \
	--$(call ptx/endis, PTXCONF_BASH_ARRAY)-array-variables \
	--$(call ptx/endis, PTXCONF_BASH_HISTORY)-bang-history \
	--$(call ptx/endis, PTXCONF_BASH_BRACE)-brace-expansion \
	--$(call ptx/endis, PTXCONF_BASH_CASEMODATTR)-casemod-attributes \
	--$(call ptx/endis, PTXCONF_BASH_CASEMODEXP)-casemod-expansions \
	--$(call ptx/endis, PTXCONF_BASH_CMDTIMING)-command-timing \
	--$(call ptx/endis, PTXCONF_BASH_CONDITIONAL)-cond-command \
	--$(call ptx/endis, PTXCONF_BASH_CONDITIONAL_REGEX)-cond-regexp \
	--$(call ptx/endis, PTXCONF_BASH_COPROCESSES)-coprocesses \
	--$(call ptx/endis, PTXCONF_BASH_DEBUGGER)-debugger \
	--$(call ptx/endis, PTXCONF_BASH_DIREXPDEFLT)-direxpand-default \
	--$(call ptx/endis, PTXCONF_BASH_DIRSTACK)-directory-stack \
	--$(call ptx/endis, PTXCONF_BASH_DISABLED_BUILDINS)-disabled-builtins \
	--$(call ptx/endis, PTXCONF_BASH_DPARAN_ARITH)-dparen-arithmetic \
	--$(call ptx/endis, PTXCONF_BASH_EXTPATTERN)-extended-glob \
	--$(call ptx/endis, PTXCONF_BASH_EXTPATTERN_DEFLT)-extended-glob-default \
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
	--$(call ptx/endis, PTXCONF_BASH_GPROF)-profiling \
	--$(call ptx/endis, PTXCONF_BASH_STATIC)-static-link \
	--$(call ptx/wwo, PTXCONF_BASH_CURSES)-curses

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
