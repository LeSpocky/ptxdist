# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptx/get-alternative = $(call ptx/force-shell,ptxd_get_alternative $(1) $(2) && echo $$ptxd_reply)
ptx/get_alternative = $(error ptx/get_alternative has been renamed to ptx/get-alternative)

#
# This must produce the same results as ptxd_in_path()
#
# resolve all possible paths
define ptx/in-path3
$(wildcard $(addsuffix /$(strip $(2)),$(strip $(1))))
endef
# expand a relative path if found
define ptx/in-path2
$(call ptx/in-path3,
$(foreach path,$(1),$(if $(filter-out /%,$(path)),
$(call ptx/in-path-all,PTXDIST_PATH_LAYERS,$(path)),$(path))),$(2))
endef
# create a path ist from the variable with ':' separated paths
define ptx/in-path-all
$(call ptx/in-path2,$(subst :,$(ptx/def/space),$($(strip $(1)))),$(2))
endef
# take the first result
define ptx/in-path
$(firstword $(call ptx/in-path-all,$(1),$(2)))
endef

#
# This must produce the same results as ptxd_in_platformconfigdir()
#
# Strip whitespaces introduced by the multiline macro
define ptx/in-platformconfigdir2
$(or $(strip $(1)),$(or $(strip $(2)),$(strip $(3))))
endef
# absolute path / first existing path / path in PTXDIST_PLATFORMCONFIGDIR
define ptx/in-platformconfigdir
$(call ptx/in-platformconfigdir2,
$(filter /%,$(strip $(1))),
$(call ptx/in-path,PTXDIST_PATH_PLATFORMCONFIGDIR,$(1)),
$(PTXDIST_PLATFORMCONFIGDIR)/$(strip $(1)))
endef

define ptx/get-kconfig2
$(call ptx/force-sh,
unset $(2) &&
. "$(1)" &&
test -n "$${$(2)}" &&
echo "$${$(2)}"
)
endef
define ptx/get-kconfig
$(call ptx/get-kconfig2,$(strip $(1)),$(strip $(2)))
endef
# vim: syntax=make
