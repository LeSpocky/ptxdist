# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# defined in post/ to make sure PTXCONF_DTC_OFTREE_DTS is fully defined
#
$(foreach dts, $(call remove_quotes,$(PTXCONF_DTC_OFTREE_DTS)), \
	$(eval $(IMAGEDIR)/$(call ptx/dtb, $(dts)): DTB_DTS=$(dts)))

# vim: syntax=make
