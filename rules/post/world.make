# -*-makefile-*-

DEP_OUTPUT	:= $(PTXDIST_PLATFORMDIR)/depend.out

### --- internal ---

WORLD_DEP_TREE_PS	:= $(PTXDIST_PLATFORMDIR)/deptree.ps
WORLD_DEP_TREE_A4_PS	:= $(PTXDIST_PLATFORMDIR)/deptree-a4.ps

WORLD_PACKAGES_TARGETINSTALL 	:= $(addprefix $(STATEDIR)/,$(addsuffix .targetinstall,$(PACKAGES)))
WORLD_HOST_PACKAGES_INSTALL	:= $(addprefix $(STATEDIR)/,$(addsuffix .install,$(HOST_PACKAGES)))
WORLD_CROSS_PACKAGES_INSTALL	:= $(addprefix $(STATEDIR)/,$(addsuffix .install,$(CROSS_PACKAGES)))


ifneq ($(shell which dot),)
world: $(WORLD_DEP_TREE_PS)
   ifneq ($(shell which poster),)
world: $(WORLD_DEP_TREE_A4_PS)
   endif #ifneq ($(shell which poster),)
endif #ifneq ($(shell which dot),)

$(WORLD_DEP_TREE_A4_PS): $(WORLD_DEP_TREE_PS)
	@echo "creating A4 version..."
	@poster -v -c 0\% -m A4 -o $@ $< > /dev/null 2>&1

$(WORLD_DEP_TREE_PS): $(DEP_OUTPUT)
	@echo "creating dependency graph..."
	@sort $< | uniq | \
		$(SCRIPTSDIR)/makedeptree | dot -Tps > $@

$(DEP_OUTPUT):
	@$(call touch, $@)

$(STATEDIR)/world.targetinstall: $(WORLD_PACKAGES_TARGETINSTALL) \
	$(WORLD_HOST_PACKAGES_INSTALL) \
	$(WORLD_CROSS_PACKAGES_INSTALL)
	@echo $@ : $^ | sed  -e 's:[^ ]*/\([^ ]\):\1:g' >> $(DEP_OUTPUT)
	@$(call touch, $@)

world: $(STATEDIR)/world.targetinstall

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
