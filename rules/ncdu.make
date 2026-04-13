# -*-makefile-*-
#
# Copyright (C) 2016,2020 by Alexander Dahl <ada@thorsis.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NCDU) += ncdu

#
# Paths and names
#
NCDU_VERSION	:= 1.22
NCDU_MD5	:= 46245039bd07a40d7594a2053139e43f
NCDU		:= ncdu-$(NCDU_VERSION)
NCDU_SUFFIX	:= tar.gz
NCDU_URL	:= https://dev.yorhel.nl/download/$(NCDU).$(NCDU_SUFFIX)
NCDU_SOURCE	:= $(SRCDIR)/$(NCDU).$(NCDU_SUFFIX)
NCDU_DIR	:= $(BUILDDIR)/$(NCDU)
NCDU_LICENSE	:= MIT
NCDU_LICENSE_FILES := file://COPYING;md5=fd36a36514d73885d04105f000da9813

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NCDU_CONF_TOOL	:= autoconf
NCDU_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--$(call ptx/endis, PTXDIST_Y2038)-year2038 \
	--$(call ptx/wow, PTXCONF_NCDU_WIDE_CHAR)-ncurses \
	--$(call ptx/wwo, PTXCONF_NCDU_WIDE_CHAR)-ncursesw

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ncdu.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ncdu)
	@$(call install_fixup, ncdu,PRIORITY,optional)
	@$(call install_fixup, ncdu,SECTION,base)
	@$(call install_fixup, ncdu,AUTHOR,"Alexander Dahl <ada@thorsis.com>")
	@$(call install_fixup, ncdu,DESCRIPTION,missing)

	@$(call install_copy, ncdu, 0, 0, 0755, -, /usr/bin/ncdu)

	@$(call install_finish, ncdu)

	@$(call touch)

# vim: ft=make noet tw=72 ts=8 sw=8
