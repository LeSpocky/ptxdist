# -*-makefile-*-
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# generic source rule. It uses the variables defined above
# to find the package for the source archive.
#
$(SRCDIR)/%:
	@$(call targetinfo)
	@$(call get, $($@))

ifneq ($(call remove_quotes, $(PTXCONF_PROJECT_DEVPKGDIR)),)
$(call remove_quotes, $(PTXCONF_PROJECT_DEVPKGDIR))/%-dev.tar.gz:
	@$(call targetinfo)
	@$(call getdev, $@)
endif

$(STATEDIR)/%.get:
	@$(call targetinfo)
	@$(foreach part,$($(PTX_MAP_TO_PACKAGE_$(*))_PARTS), \
		$(call world/get, $(part), $(PTX_MAP_TO_PACKAGE_$(*)))$(ptx/nl))
	@$(call touch)

world/get = \
	$(call world/env, $(1)) \
	pkg_main_PKG=$(strip $(2)) \
	pkg_makefile=$($(strip $(2))_MAKEFILE) \
	ptxd_make_get_mirror=$(PTXCONF_SETUP_PTXMIRROR) \
	ptxd_make_world_get

$(STATEDIR)/%.urlcheck:
	@$(call targetinfo)
	@$(foreach part,$($(PTX_MAP_TO_PACKAGE_$(*))_PARTS), \
		$(call world/urlcheck, $(part))$(ptx/nl))
	@$(call touch)

world/urlcheck = \
	$(call world/env, $(1)) \
	ptxd_make_get_dryrun=y \
	ptxd_make_get_mirror=$(PTXCONF_SETUP_PTXMIRROR) \
	ptxd_make_world_get

#
# get
#
# Download a package from a given URL. This macro has some magic
# to handle different URLs; as wget is not able to transfer
# file URLs this case is being handed over to cp.
#
# $1: Packet Label; this macro gets $1_URL
#
get = \
	ptxd_make_get_mirror=$(PTXCONF_SETUP_PTXMIRROR) \
	ptxd_make_get "$($(strip $(1))_SOURCE)" "$($(strip $(1))_URL)"

check_src = \
	ptxd_make_check_src "$($(strip $(1))_SOURCE)" "$($(strip $(1))_MD5)" "$($(strip $(1))_SHA256)"

getdev = \
	ptxd_make_get_nofail=y \
	ptxd_make_get_mirror=$(PTXCONF_PROJECT_DEVMIRROR) \
	ptxd_make_get "$(strip $(1))" "$(call remove_quotes, $(PTXCONF_PROJECT_DEVMIRROR))/$(notdir $(1))"

# vim: syntax=make
