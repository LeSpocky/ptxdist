# -*-makefile-*-
#
# Copyright (C) 2009 by Juergen Beisert
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TCL) += tcl

#
# Paths and names
#
TCL_MAJOR	:= 8
TCL_MINOR	:= 5
TCL_PL		:= 15
TCL_VERSION	:= $(TCL_MAJOR).$(TCL_MINOR).$(TCL_PL)
TCL_MD5		:= f3df162f92c69b254079c4d0af7a690f
TCL		:= tcl$(TCL_VERSION)
TCL_SUFFIX	:= -src.tar.gz
TCL_URL		:= $(call ptx/mirror, SF, tcl/$(TCL)$(TCL_SUFFIX))
TCL_SOURCE	:= $(SRCDIR)/$(TCL)$(TCL_SUFFIX)
TCL_DIR		:= $(BUILDDIR)/$(TCL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# select one of the available kernel versions

TCL_KERNEL_VERSION := $(if $(KERNEL_HEADER_VERSION),$(KERNEL_HEADER_VERSION),$(KERNEL_VERSION))

ifdef PTXCONF_TCL
ifeq ($(TCL_KERNEL_VERSION),)
 $(warning ######################### ERROR ###########################)
 $(warning # Linux kernel version required in order to make TCL work #)
 $(warning #   Define a platform kernel or the kernel headers        #)
 $(warning ###########################################################)
 $(error )
endif
endif

TCL_ENV 	:= \
	$(CROSS_ENV) \
	tcl_cv_sys_version=Linux-$(TCL_KERNEL_VERSION) \
	tcl_cv_strstr_unbroken=yes \
	tcl_cv_strtoul_unbroken=yes \
	tcl_cv_strtod_unbroken=yes \
	tcl_cv_strtod_buggy=no \
	tcl_cv_stack_grows_up=no

# unresolved issues yet:
#  checking for timezone data... /usr/share/zoneinfo <-- it uses host's one
#

#
# autoconf
#
TCL_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_TCL_THREADS)-threads \
	--enable-shared \
	--disable-64bit \
	--disable-64bit-vis \
	--disable-rpath \
	--disable-corefoundation \
	--enable-load \
	--enable-symbols \
	--enable-dll-unloading \
	--disable-dtrace \
	--disable-framework \
	--with-encoding=iso8859-15 \
	--$(call ptx/wwo, PTXCONF_TCL_TZDATA)-tzdata

# TODO: Provide the correct encoding for the target
# --with-encoding=<valid encode from 'usr/lib/tcl8.5/encoding'>
# Note: TCL uses iso8859-1 until otherwise specified

TCL_SUBDIR := unix

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tcl.install:
	@$(call targetinfo)
	@$(call install, TCL)
	@mkdir -p $(TCL_PKGDIR)/usr/share/tcl-tests
	@cd $(TCL_DIR)/tests && \
		install -m 644 * $(TCL_PKGDIR)/usr/share/tcl-tests/
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tcl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, tcl)
	@$(call install_fixup, tcl,PRIORITY,optional)
	@$(call install_fixup, tcl,SECTION,base)
	@$(call install_fixup, tcl,AUTHOR,"Juergen Beisert <juergen@kreuzholzen.de")
	@$(call install_fixup, tcl,DESCRIPTION,"TCL byte code engine")

	@$(call install_copy, tcl, 0, 0, 0755, \
		/usr/lib/tcl$(TCL_MAJOR).$(TCL_MINOR))
	@$(call install_copy, tcl, 0, 0, 0644, -, \
		/usr/lib/tcl$(TCL_MAJOR).$(TCL_MINOR)/tclIndex)
	@$(call install_copy, tcl, 0, 0, 0644, -, \
		/usr/lib/tcl$(TCL_MAJOR).$(TCL_MINOR)/package.tcl)
	@$(call install_copy, tcl, 0, 0, 0644, -, \
		/usr/lib/tcl$(TCL_MAJOR).$(TCL_MINOR)/init.tcl)

	@$(call install_copy, tcl, 0, 0, 0755, -, \
		/usr/bin/tclsh$(TCL_MAJOR).$(TCL_MINOR))

	# a simplified link is very useful
	@$(call install_link, tcl, \
		tclsh$(TCL_MAJOR).$(TCL_MINOR), /usr/bin/tclsh)

	@$(call install_copy, tcl, 0, 0, 0644, -, /usr/lib/libtcl8.5.so)

ifdef PTXCONF_TCL_TESTING
	@$(call install_copy, tcl, 0, 0, 0755, /usr/lib/tcl$(TCL_MAJOR))
	@$(call install_copy, tcl, 0, 0, 0644, -, \
		/usr/lib/tcl$(TCL_MAJOR)/$(TCL_MAJOR).$(TCL_MINOR)/tcltest-2.3.5.tm)
	@$(call install_copy, tcl, 0, 0, 0644, -, \
		/usr/lib/tcl$(TCL_MAJOR)/$(TCL_MAJOR).$(TCL_MINOR)/msgcat-1.5.2.tm)

	@$(call install_copy, tcl, 0, 0, 0644, -, \
		/usr/lib/tcl$(TCL_MAJOR).$(TCL_MINOR)/tm.tcl)
	@$(call install_copy, tcl, 0, 0, 0644, -, \
		/usr/lib/tcl$(TCL_MAJOR).$(TCL_MINOR)/parray.tcl)
	@$(call install_copy, tcl, 0, 0, 0644, -, \
		/usr/lib/tcl$(TCL_MAJOR).$(TCL_MINOR)/clock.tcl)
	@$(call install_copy, tcl, 0, 0, 0644, -, \
		/usr/lib/tcl$(TCL_MAJOR).$(TCL_MINOR)/auto.tcl)
	@$(call install_copy, tcl, 0, 0, 0644, -, \
		/usr/lib/tcl$(TCL_MAJOR).$(TCL_MINOR)/history.tcl)
	@$(call install_copy, tcl, 0, 0, 0644, -, \
		/usr/lib/tcl$(TCL_MAJOR).$(TCL_MINOR)/safe.tcl)
	@$(call install_copy, tcl, 0, 0, 0644, -, \
		/usr/lib/tcl$(TCL_MAJOR).$(TCL_MINOR)/word.tcl)

# avoid a subdirectory hell. Install them where also the other scripts are
	@$(call install_copy, tcl, 0, 0, 0644, \
		$(TCL_PKGDIR)/usr/lib/tcl$(TCL_MAJOR).$(TCL_MINOR)/opt0.4/optparse.tcl, \
		/usr/lib/tcl$(TCL_MAJOR).$(TCL_MINOR)/optparse.tcl)

	@$(call install_copy, tcl, 0, 0, 0644, \
		$(TCL_PKGDIR)/usr/lib/tcl$(TCL_MAJOR).$(TCL_MINOR)/opt0.4/pkgIndex.tcl, \
		/usr/lib/tcl$(TCL_MAJOR).$(TCL_MINOR)/pkgIndex.tcl)
endif

ifdef PTXCONF_TCL_ENCODING
	@$(call install_copy, tcl, 0, 0, 0755, \
		/usr/lib/tcl$(TCL_MAJOR).$(TCL_MINOR)/encoding)
ifndef PTXCONF_TCL_TESTING
# install some popular code pages
# FIXME: Are these the most common ones? Add more if not
	@$(call install_copy, tcl, 0, 0, 0644, -, \
		/usr/lib/tcl8.5/encoding/iso8859-1.enc)
	@$(call install_copy, tcl, 0, 0, 0644, -, \
		/usr/lib/tcl8.5/encoding/iso8859-15.enc)
	@$(call install_copy, tcl, 0, 0, 0644, -, \
		/usr/lib/tcl8.5/encoding/cp437.enc)
	@$(call install_copy, tcl, 0, 0, 0644, -, \
		/usr/lib/tcl8.5/encoding/cp850.enc)
	@$(call install_copy, tcl, 0, 0, 0644, -, \
		/usr/lib/tcl8.5/encoding/ascii.enc)
	@$(call install_copy, tcl, 0, 0, 0644, -, \
		/usr/lib/tcl8.5/encoding/big5.enc)
else
# install all code pages
	@cd $(TCL_PKGDIR)/usr/lib/tcl8.5/encoding; \
	for file in * ; do \
		$(call install_copy, tcl, 0, 0, 0644, -, \
			/usr/lib/tcl8.5/encoding/$$file); \
	done
# copy all tests to the target
	@$(call install_copy, tcl, 0, 0, 0755, /usr/share/tcl-tests)
	@cd $(TCL_PKGDIR)/usr/share/tcl-tests && \
	for file in * ; do \
		$(call install_copy, tcl, 0, 0, 644, -, \
			/usr/share/tcl-tests/$$file); \
	done

# unresolved tests:
# Test file error: EscapeToUtfProc: invalid sub table

endif
endif

	@$(call install_finish, tcl)

	@$(call touch)

# vim: syntax=make
