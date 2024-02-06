# -*-makefile-*-

# input: source=PACKAGE_NAME_SOURCE, output: full path to the source archive
# [HOST|CROSS]_FOO_SOURCE may be empty; try FOO_SOURCE in that case
define ptx/export/get_source
$(if $($(1)),$($(1)),$($(subst CROSS_,,$(subst HOST_,,$(1)))))
endef

# iterate over $(PACKAGES_SELECTED) "bash busybox" ->
# convert to "BASH BUSYBOX" including all sub-packages
_ptx_export_packages := $(foreach pkg,$(PTX_PACKAGES_SELECTED),$($(PTX_MAP_TO_PACKAGE_$(pkg))_PARTS))

# iterate over $(_ptx_export_packages) "BASH BUSYBOX" ->
# convert to "/path/to/bash.tar.bz2 /path/to/busybox.tar.bz2"
# remove duplicates
_ptx_export_packages_src := $(sort $(foreach source,$(_ptx_export_packages),$(call ptx/export/get_source,$(source)_SOURCE)))

# iterate over $(_ptx_export_packages_src) "/path/to/bash.tar.bz2 /path/to/busybox.tar.bz2" ->
# convert to "/export/bash.tar.bz2 /export/busybox.tar.bz2"
_ptx_export_packages_dst := $(subst $(SRCDIR),$(EXPORTDIR),$(_ptx_export_packages_src))

# force copy
.PHONY: $(_ptx_export_packages_dst)
$(_ptx_export_packages_dst): $(_ptx_export_packages_src)
	@cp -av "$(SRCDIR)/$(@F)" "$@"

export_src: $(_ptx_export_packages_dst)

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
