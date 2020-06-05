#
# Copyright (C) 2005 by Oscar Peredo
# Copyright (C) 2007 by Carsten Schlote
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_JOE) += joe

#
# Paths and names
#
JOE_VERSION	:= 3.5
JOE_MD5		:= 9bdffecce7ef910feaa06452d48843de
JOE		:= joe-$(JOE_VERSION)
JOE_SUFFIX	:= tar.gz
JOE_URL		:= $(call ptx/mirror, SF, joe-editor/$(JOE).$(JOE_SUFFIX))
JOE_SOURCE	:= $(SRCDIR)/$(JOE).$(JOE_SUFFIX)
JOE_DIR		:= $(BUILDDIR)/$(JOE)
JOE_LICENSE	:= GPL-1.0-only
JOE_LICENSE_FILES	:= file://COPYING;md5=da10ed7cf8038981c580e11c1d3e8fb6

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

JOE_PATH	:= PATH=$(CROSS_PATH)
JOE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
JOE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-curses

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/joe.targetinstall:
	@$(call targetinfo)

	@$(call install_init, joe)
	@$(call install_fixup, joe,PRIORITY,optional)
	@$(call install_fixup, joe,SECTION,base)
	@$(call install_fixup, joe,AUTHOR,"Carsten Schlote <c.schlote@konzeptpark.de>")
	@$(call install_fixup, joe,DESCRIPTION,missing)

	@$(call install_copy, joe, 0, 0, 0755, -, /usr/bin/joe)
	@$(call install_copy, joe, 0, 0, 0755, -, /usr/bin/termidx)

	@$(call install_copy, joe, 0, 0, 0755, /etc/joe)
	@for file in $(JOE_PKGDIR)/etc/joe/*rc; do \
		destination=`basename $$file`; \
		$(call install_copy, joe, 0, 0, 0644, $$file, /etc/joe/$$destination, n); \
	done

  ifdef PTXCONF_JOE_SYNTAX_HIGHLIGHT
	@$(call install_copy, joe, 0, 0, 0755, /etc/joe/syntax)
	@for file in $(JOE_PKGDIR)/etc/joe/syntax/*.jsf; do \
		destination=`basename $$file`; \
		$(call install_copy, joe, 0, 0, 0644, $$file, /etc/joe/syntax/$$destination, n); \
	done
  endif

	@$(call install_finish, joe)
	@$(call touch)

# vim: syntax=make
