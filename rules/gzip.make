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
PACKAGES-$(PTXCONF_GZIP) += gzip

#
# Paths and names
#
GZIP_VERSION	:= 1.14
GZIP_SHA256	:= 01a7b881bd220bfdf615f97b8718f80bdfd3f6add385b993dcf6efd14e8c0ac6
GZIP		:= gzip-$(GZIP_VERSION)
GZIP_SUFFIX	:= tar.xz
GZIP_URL	:= $(call ptx/mirror, GNU, gzip/$(GZIP).$(GZIP_SUFFIX))
GZIP_SOURCE	:= $(SRCDIR)/$(GZIP).$(GZIP_SUFFIX)
GZIP_DIR	:= $(BUILDDIR)/$(GZIP)
GZIP_LICENSE	:= GPL-3.0-only
GZIP_LICENSE_FILES	:= file://COPYING;md5=1ebbd3e34237af26da5dc08a4e440464

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
GZIP_CONF_TOOL	:= autoconf
GZIP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-cross-guesses \
	--disable-gcc-warnings \
	--disable-dfltcc \
	--$(call ptx/endis, PTXCONF_GLIBC_Y2038)-year2038

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gzip.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gzip)
	@$(call install_fixup, gzip,PRIORITY,optional)
	@$(call install_fixup, gzip,SECTION,base)
	@$(call install_fixup, gzip,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, gzip,DESCRIPTION,missing)

	@$(call install_copy, gzip, 0, 0, 0755, -, /usr/bin/gzip)

	@$(call install_copy, gzip, 0, 0, 0755, -, /usr/bin/gunzip)
	@$(call install_copy, gzip, 0, 0, 0755, -, /usr/bin/gzexe)
	@$(call install_copy, gzip, 0, 0, 0755, -, /usr/bin/uncompress)
	@$(call install_copy, gzip, 0, 0, 0755, -, /usr/bin/zcat)
	@$(call install_copy, gzip, 0, 0, 0755, -, /usr/bin/zcmp)
	@$(call install_copy, gzip, 0, 0, 0755, -, /usr/bin/zdiff)
	@$(call install_copy, gzip, 0, 0, 0755, -, /usr/bin/zegrep)
	@$(call install_copy, gzip, 0, 0, 0755, -, /usr/bin/zfgrep)
	@$(call install_copy, gzip, 0, 0, 0755, -, /usr/bin/zforce)
	@$(call install_copy, gzip, 0, 0, 0755, -, /usr/bin/zgrep)
	@$(call install_copy, gzip, 0, 0, 0755, -, /usr/bin/zless)
	@$(call install_copy, gzip, 0, 0, 0755, -, /usr/bin/zmore)
	@$(call install_copy, gzip, 0, 0, 0755, -, /usr/bin/znew)

	@$(call install_finish, gzip)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

#$(STATEDIR)/gzip.clean:
#	@$(call targetinfo)
#	@$(call clean_pkg, GZIP)

# vim: syntax=make
