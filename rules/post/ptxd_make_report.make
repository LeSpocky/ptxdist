#!/bin/bash
#
# Copyright (C) 2022 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptx/report-env = \
	$(image/env) \
	ptx_report_target="$(strip $(1))" \
	ptx_packages_selected="$(filter-out $(IMAGE_PACKAGES),$(PTX_PACKAGES_SELECTED))" \
	ptx_image_packages="$(IMAGE_PACKAGES)"

PHONY += full-bsp-report
full-bsp-report: $(RELEASEDIR)/full-bsp-report.yaml

#
# The full report needs the 'report' stage for license files and the
# targetinstall stage for the list of ipkgs
#
$(RELEASEDIR)/full-bsp-report.yaml: \
		$(addprefix $(STATEDIR)/,$(addsuffix .report,$(PTX_PACKAGES_SELECTED))) \
		$(addprefix $(STATEDIR)/,$(addsuffix .targetinstall,$(PTX_PACKAGES_SELECTED)))
	@$(call targetinfo)
	@$(call ptx/report-env, $@) ptxd_make_full_bsp_report
	@$(call finish)

PHONY += fast-bsp-report
fast-bsp-report: $(RELEASEDIR)/fast-bsp-report.yaml


$(RELEASEDIR)/fast-bsp-report.yaml: $(addprefix $(STATEDIR)/,$(addsuffix .fast-report,$(PTX_PACKAGES_SELECTED)))
	@$(call targetinfo)
	@$(call ptx/report-env, $@) ptxd_make_fast_bsp_report
	@$(call finish)

# vim: syntax=make
