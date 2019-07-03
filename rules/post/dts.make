# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# defined in post/ to make sure PTXCONF_DTC_OFTREE_DTS is fully defined
# .dtb depends on the .dts and dtc.install for all other dependencies
#
$(foreach dts, $(call remove_quotes,$(DTC_OFTREE_DTS)), \
	$(eval $(IMAGEDIR)/$(call ptx/dtb, $(dts)): $(dts)))

$(foreach dts, $(call remove_quotes,$(PTXCONF_DTC_OFTREE_DTS)), \
	$(eval $(IMAGEDIR)/$(call ptx/dtb, $(dts)): DTB_DTS=$(dts)))

$(foreach dts, $(call remove_quotes,$(DTC_OFTREE_DTS)), \
	$(eval $(dts): $(STATEDIR)/kernel.extract.post))

# vim: syntax=make
