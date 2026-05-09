# -*-makefile-*-
#
# Copyright (C) 2013 by Bernhard Walle <bernhard@bwalle.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TREE) += tree

#
# Paths and names
#
TREE_VERSION	:= 2.1.0
TREE_SHA256	:= 0160c535bff2b0dc6a830b9944e981e3427380f63e748da96ced7071faebabf6
TREE		:= tree-$(TREE_VERSION)
TREE_SUFFIX	:= tgz
TREE_URL	:= http://oldmanprogrammer.net/tar/tree/$(TREE).$(TREE_SUFFIX)
TREE_SOURCE	:= $(SRCDIR)/$(TREE).$(TREE_SUFFIX)
TREE_DIR	:= $(BUILDDIR)/$(TREE)
TREE_LICENSE	:= GPL-2.0-or-later AND LGPL-2.1-or-later
TREE_LICENSE_FILES := \
	file://LICENSE;md5=393a5ca445f6965873eca0259a17f833 \
	file://strverscmp.c;startline=1;endline=19;md5=f50ab9ef044f00fb22691ec5051c922d

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

TREE_MAKE_OPT	:= \
	$(CROSS_ENV_CC) \
	$(CROSS_ENV_CPP) \
	$(CROSS_ENV_AS)

TREE_INSTALL_OPT := \
	PREFIX=/usr \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tree.targetinstall:
	@$(call targetinfo)

	@$(call install_init, tree)
	@$(call install_fixup, tree,PRIORITY,optional)
	@$(call install_fixup, tree,SECTION,base)
	@$(call install_fixup, tree,AUTHOR,"Bernhard Walle <bernhard@bwalle.de>")
	@$(call install_fixup, tree,DESCRIPTION,missing)

	@$(call install_copy, tree, 0, 0, 0755, -, /usr/bin/tree)

	@$(call install_finish, tree)

	@$(call touch)

# vim: syntax=make
