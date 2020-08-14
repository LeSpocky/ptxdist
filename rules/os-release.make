# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OS_RELEASE) += os-release

OS_RELEASE_VERSION	:= 1.0
OS_RELEASE_LICENSE	:= ignore

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

OS_RELEASE_STAMP := $(call remove_quotes, \
	$(PTXCONF_PROJECT_VENDOR) \
	$(PTXCONF_PROJECT) \
	$(PTXCONF_PROJECT_VERSION) \
	$(PTXCONF_PLATFORM) \
	$(PTXCONF_PLATFORM_VERSION))

$(call ptx/cfghash, OS_RELEASE, $(OS_RELEASE_STAMP))
$(call ptx/cfghash-file, OS_RELEASE, $(PTXDIST_PTXCONFIG))
$(call ptx/cfghash-file, OS_RELEASE, $(PTXDIST_PLATFORMCONFIG))

$(STATEDIR)/os-release.targetinstall:
	@$(call targetinfo)

	@$(call install_init, os-release)
	@$(call install_fixup,os-release,PRIORITY,optional)
	@$(call install_fixup,os-release,SECTION,base)
	@$(call install_fixup,os-release,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup,os-release,DESCRIPTION,missing)

	@$(call install_alternative, os-release, 0, 0, 0644, /usr/lib/os-release)

	@$(call install_replace, os-release, /usr/lib/os-release, \
		@VENDOR@, $(PTXCONF_PROJECT_VENDOR))
	@$(call install_replace, os-release, /usr/lib/os-release, \
		@PROJECT@, $(PTXCONF_PROJECT))
	@$(call install_replace, os-release, /usr/lib/os-release, \
		@PRJVERSION@, $(PTXCONF_PROJECT_VERSION))

	@$(call install_replace, os-release, /usr/lib/os-release, \
		@PLATFORM@, $(PTXCONF_PLATFORM))
	@$(call install_replace, os-release, /usr/lib/os-release, \
		@PLATVERSION@, $(PTXCONF_PLATFORM_VERSION))

	@$(call install_replace, os-release, /usr/lib/os-release, \
		@PTXDIST_VERSION@, $(PTXDIST_VERSION_FULL))

	@$(call install_replace, os-release, /usr/lib/os-release, \
		@DATE@, $(shell date +%FT%T%z))

	@$(call install_link, os-release, ../usr/lib/os-release, \
		/etc/os-release)

	@$(call install_finish,os-release)

	@$(call touch)

# vim: syntax=make
