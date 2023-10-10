# -*-makefile-*-
#
# Copyright (C) 2023 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# image/reports
#
image/reports = \
	$(call world/image/env,$(1)) \
	ptxd_make_image_reports

$(STATEDIR)/image-%.reports: $(RELEASEDIR)/full-bsp-report.yaml
	@$(call targetinfo)
	@$(call image/reports, $(PTX_MAP_TO_PACKAGE_image-$(*)))
	@$(call touch)

define _generate_report_impl
$(strip $(if $($(1)_PKGS),$(if $(filter NO,$($(1)_REPORTS)),,y)))
endef

define _generate_report
$(strip $(call _generate_report_impl,$(PTX_MAP_TO_PACKAGE_$(strip $(1)))))
endef

PTX_IMAGES_REPORT += $(strip $(foreach image,$(IMAGE_PACKAGES),$(if $(call _generate_report,$(image)),$(image))))

$(if $(PTXDIST_OVERRIDE_REPORTS), \
$(foreach image,$(PTX_IMAGES_REPORT), \
$(eval $(PTX_MAP_TO_PACKAGE_$(image))_REPORTS := $(PTXDIST_OVERRIDE_REPORTS)) \
))

PTXDIST_DEFAULT_REPORTS ?= license-compliance

$(foreach image,$(PTX_IMAGES_REPORT), \
$(eval $(PTX_MAP_TO_PACKAGE_$(image))_REPORTS ?= $(PTXDIST_DEFAULT_REPORTS)) \
)

image-reports: $(addprefix $(STATEDIR)/,$(addsuffix .reports,$(PTX_IMAGES_REPORT)))

# vim: syntax=make
