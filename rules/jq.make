# -*-makefile-*-
#
# Copyright (C) 2018 by Alexander Dahl <ada@thorsis.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_JQ) += jq

#
# Paths and names
#
JQ_VERSION	:= 1.7.1
JQ_MD5		:= 974a340105ecb43add8c55601525f9fc
JQ		:= jq-$(JQ_VERSION)
JQ_SUFFIX	:= tar.gz
JQ_URL		:= https://github.com/jqlang/jq/releases/download/$(JQ)/$(JQ).$(JQ_SUFFIX)
JQ_SOURCE	:= $(SRCDIR)/$(JQ).$(JQ_SUFFIX)
JQ_DIR		:= $(BUILDDIR)/$(JQ)
JQ_LICENSE	:= MIT AND CC-BY-3.0 AND ICU
JQ_LICENSE_FILES := file://COPYING;md5=488f4e0b04c0456337fb70d1ac1758ba

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
JQ_CONF_TOOL	:= autoconf
JQ_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-largefile \
	--disable-valgrind \
	--disable-asan \
	--disable-ubsan \
	--disable-gcov \
	--disable-docs \
	--disable-error-injection \
	--disable-all-static \
	--disable-decnum \
	--with-oniguruma=prefix

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/jq.targetinstall:
	@$(call targetinfo)

	@$(call install_init, jq)
	@$(call install_fixup, jq,PRIORITY,optional)
	@$(call install_fixup, jq,SECTION,base)
	@$(call install_fixup, jq,AUTHOR,"Alexander Dahl <ada@thorsis.com>")
	@$(call install_fixup, jq,DESCRIPTION,missing)

	@$(call install_lib, jq, 0, 0, 0644, libjq)
	@$(call install_lib, jq, 0, 0, 0644, libonig)
	@$(call install_copy, jq, 0, 0, 0755, -, /usr/bin/jq)

	@$(call install_finish, jq)

	@$(call touch)

# vim: ft=make noet ts=8 sw=8
