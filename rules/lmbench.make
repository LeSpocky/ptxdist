# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LMBENCH) += lmbench

#
# Paths and names
#
LMBENCH_VERSION	:= 3.0-a9
LMBENCH_MD5	:= b3351a3294db66a72e2864a199d37cbf
LMBENCH		:= lmbench-$(LMBENCH_VERSION)
LMBENCH_SUFFIX	:= tgz
LMBENCH_URL	:= $(call ptx/mirror, SF, lmbench/$(LMBENCH).$(LMBENCH_SUFFIX))
LMBENCH_SOURCE	:= $(SRCDIR)/$(LMBENCH).$(LMBENCH_SUFFIX)
LMBENCH_DIR	:= $(BUILDDIR)/$(LMBENCH)
LMBENCH_LICENSE	:= GPL-2.0-only with exceptions
LMBENCH_LICENSE_FILES := \
	file://COPYING;md5=8ca43cbc842c2336e835926c2166c28b \
	file://COPYING-2;md5=8e9aee2ccc75d61d107e43794a25cdf9

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LMBENCH_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

LMBENCH_TOOLS_PROGS := \
        bw_file_rd \
        bw_mem \
        bw_mmap_rd \
        bw_pipe \
        bw_tcp \
        bw_unix \
        disk \
        enough \
        flushdisk \
        hello \
        lat_connect \
        lat_ctx \
        lat_fcntl \
        lat_fifo \
        lat_fs \
        lat_http \
        lat_mem_rd \
        lat_mmap \
        lat_ops \
        lat_pagefault \
        lat_pipe \
        lat_proc \
        lat_rpc \
        lat_select \
        lat_sem \
        lat_sig \
        lat_syscall \
        lat_tcp \
        lat_udp \
        lat_unix \
        lat_unix_connect \
        line \
        lmdd \
        lmhttp \
        loop_o \
        memsize \
        mhz \
        msleep \
        par_mem \
        par_ops \
        stream \
        timing_o \
        tlb


$(STATEDIR)/lmbench.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lmbench)
	@$(call install_fixup, lmbench,PRIORITY,optional)
	@$(call install_fixup, lmbench,SECTION,base)
	@$(call install_fixup, lmbench,AUTHOR,"Robert Schwebel")
	@$(call install_fixup, lmbench,DESCRIPTION,missing)

	@$(foreach prog, $(LMBENCH_TOOLS_PROGS), \
		$(call install_copy, lmbench, 0, 0, 0755, -, \
		/usr/bin/$(prog))$(ptx/nl))

	@$(call install_lib, lmbench, 0, 0, 0644, liblmbench)

	@$(call install_finish, lmbench)

	@$(call touch)

# vim: syntax=make
