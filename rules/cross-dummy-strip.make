# -*-makefile-*-
#
# Copyright (C) 2009 by Wolfram Sang <w.sang@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
CROSS_PACKAGES-$(PTXCONF_CROSS_DUMMY_STRIP) += cross-dummy-strip
CROSS_DUMMY_STRIP_LICENSE := ignore

$(STATEDIR)/cross-dummy-strip.install:
	@$(call targetinfo)
	install -D -m 755 $(PTXDIST_TOPDIR)/scripts/dummy-strip.sh $(PTXDIST_SYSROOT_CROSS)/bin/strip
	@$(call touch)

# vim: syntax=make
