# -*-makefile-*-

#
# ptx_oldconfig
#
# execute "make oldconfig" on a program. Mainly used for
# kconfig based packages.
#
define ptx/oldconfig
	$(call execute,$(1),$(MAKE) \
		$(filter-out --output-sync%,$($(strip $(1))_MAKEVARS) $($(strip $(1))_MAKE_OPT)) oldconfig)
endef

all_oldconfig: $(addsuffix _oldconfig,$(PTX_PACKAGES_SELECTED))

%_oldconfig:
	@:

# vim: syntax=make
