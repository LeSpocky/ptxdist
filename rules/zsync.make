# -*-makefile-*-
#
# Copyright (C) 2010 by Carsten Schlote <c.schlote@konzeptpark.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ZSYNC) += zsync

#
# Paths and names
#
ZSYNC_VERSION	:= 0.6.2
ZSYNC_MD5	:= 862f90bafda118c4d3c5ee6477e50841
ZSYNC		:= zsync-$(ZSYNC_VERSION)
ZSYNC_SUFFIX	:= tar.bz2
ZSYNC_URL	:= http://zsync.moria.org.uk/download/$(ZSYNC).$(ZSYNC_SUFFIX)
ZSYNC_SOURCE	:= $(SRCDIR)/$(ZSYNC).$(ZSYNC_SUFFIX)
ZSYNC_DIR	:= $(BUILDDIR)/$(ZSYNC)
ZSYNC_LICENSE	:= GPL

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
ZSYNC_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/zsync.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  zsync)
	@$(call install_fixup, zsync,PRIORITY,optional)
	@$(call install_fixup, zsync,SECTION,base)
	@$(call install_fixup, zsync,AUTHOR,"Carsten Schlote <c.schlote@konzeptpark.de>")
	@$(call install_fixup, zsync,DESCRIPTION,missing)

	@$(call install_copy, zsync, 0, 0, 0755, -, /usr/bin/zsync)
	@$(call install_copy, zsync, 0, 0, 0755, -, /usr/bin/zsyncmake)

	@$(call install_finish, zsync)

	@$(call touch)

# vim: syntax=make
