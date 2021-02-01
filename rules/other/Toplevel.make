# -*-makefile-*-
#
# Copyright (C) 2002-2009 by The PTXdist Team
#

ifneq ($(findstring n,$(filter-out --%,$(MAKEFLAGS))),)
# make sure recursive calls do nothing for --dry-run
MAKE=true
SHELL=true
define ptx/force-shell
$(eval SHELL=$(realpath $(PTXDIST_TOPDIR)/bin/bash))$(shell $(1))$(eval SHELL=true)
endef
define ptx/force-sh
$(eval SHELL=/bin/sh)$(shell $(1))$(eval SHELL=true)
endef
define ptx/sh
endef
else
# make sure bash is used to execute commands from makefiles
SHELL=$(realpath $(PTXDIST_TOPDIR)/bin/bash)
define ptx/force-shell
$(shell $(1))
endef
define ptx/force-sh
$(eval SHELL=/bin/sh)$(shell $(1))$(eval SHELL=$(realpath $(PTXDIST_TOPDIR)/bin/bash))
endef
define ptx/sh
$(call ptx/force-sh,$(1))
endef
endif
export SHELL

ifdef PTXDIST_OLD_MAKE
define ptx/file
$(call ptx/force-sh,echo '$(2)' $(1))
endef
else
define ptx/file
$(file $(1),$(2))
endef
endif

# allow skiping thing for the second make all with --progress
ifeq ($(wildcard $(PTXDIST_TEMPDIR)/setup-once),)
PTXDIST_SETUP_ONCE := 1
$(call ptx/file,>>$(PTXDIST_TEMPDIR)/setup-once)
endif

unexport MAKEFLAGS
export MAKE

PHONY := all FORCE
all:
	@echo "ptxdist: error: please use 'ptxdist' instead of calling make directly."
	@exit 1

# ----------------------------------------------------------------------------
# Some directory locations
# ----------------------------------------------------------------------------

include $(PTXDIST_TOPDIR)/scripts/ptxdist_vars.sh
include $(RULESDIR)/other/Definitions.make

include $(PTXDIST_PTXCONFIG)

# might be non existent
-include $(PTXDIST_PLATFORMCONFIG)

# might be non existent
ifneq ($(wildcard $(PTXDIST_COLLECTIONCONFIG)),)
include $(PTXDIST_COLLECTIONCONFIG)
PTX_COLLECTION := y
endif

# ----------------------------------------------------------------------------
# Include all rule files
# ----------------------------------------------------------------------------

include $(PTX_MAP_ALL_MAKE)

include $(RULESDIR)/other/Namespace.make

# might be non existent
include $(foreach dir, $(call reverse,$(subst :,$(space),$(PTXDIST_PATH_PRERULES))), $(sort $(wildcard $(dir)/*.make)))

include $(PTX_DGEN_DEPS_PRE)
include $(PTX_DGEN_RULESFILES_MAKE)

#
# the extended format is:
# PACKAGES-<ARCH>-<LABEL>
#
# to keep it simple, just add the "-y-y" to "-y"
# (for "-m" and "--" accordingly)
#
PACKAGES-y	+= $(PACKAGES-y-y)
PACKAGES-m	+= $(PACKAGES-y-m)
PACKAGES-	+= $(PACKAGES-y-) $(PACKAGES--y) $(PACKAGES--m) $(PACKAGES--)

HOST_PACKAGES-y	+= $(HOST_PACKAGES-y-y)
HOST_PACKAGES-m	+= $(HOST_PACKAGES-y-m)
HOST_PACKAGES-	+= $(HOST_PACKAGES-y-) $(HOST_PACKAGES--y) $(HOST_PACKAGES--m) $(HOST_PACKAGES--)

CROSS_PACKAGES-y+= $(CROSS_PACKAGES-y-y)
CROSS_PACKAGES-m+= $(CROSS_PACKAGES-y-m)
CROSS_PACKAGES-	+= $(CROSS_PACKAGES-y-) $(CROSS_PACKAGES--y) $(CROSS_PACKAGES--m) $(CROSS_PACKAGES--)

EXTRA_PACKAGES-y+= $(EXTRA_PACKAGES-y-y)
EXTRA_PACKAGES-m+= $(EXTRA_PACKAGES-y-m)
EXTRA_PACKAGES-	+= $(EXTRA_PACKAGES-y-) $(EXTRA_PACKAGES--y) $(EXTRA_PACKAGES--m) $(EXTRA_PACKAGES--)

LAZY_PACKAGES-y	+= $(LAZY_PACKAGES-y-y)
LAZY_PACKAGES-m	+= $(LAZY_PACKAGES-y-m)
LAZY_PACKAGES-	+= $(LAZY_PACKAGES-y-) $(LAZY_PACKAGES--y) $(LAZY_PACKAGES--m) $(LAZY_PACKAGES--)

PACKAGES	:= $(PACKAGES-y)
CROSS_PACKAGES	:= $(CROSS_PACKAGES-y)
HOST_PACKAGES	:= $(HOST_PACKAGES-y)
EXTRA_PACKAGES	:= $(EXTRA_PACKAGES-y)
LAZY_PACKAGES	:= $(LAZY_PACKAGES-y)
IMAGE_PACKAGES	:= $(IMAGE_PACKAGES-y)

#
# build everything if no collection is active
#
ifndef PTX_COLLECTION
PACKAGES	+= $(PACKAGES-m)
CROSS_PACKAGES	+= $(CROSS_PACKAGES-m)
HOST_PACKAGES	+= $(HOST_PACKAGES-m)
EXTRA_PACKAGES	+= $(EXTRA_PACKAGES-m)
LAZY_PACKAGES	+= $(LAZY_PACKAGES-m)
endif

PTX_PACKAGES_SELECTED	:= \
	$(PACKAGES) \
	$(CROSS_PACKAGES) \
	$(HOST_PACKAGES) \
	$(EXTRA_PACKAGES) \
	$(LAZY_PACKAGES) \
	$(IMAGE_PACKAGES)

PTX_PACKAGES_DISABLED	:= \
	$(filter-out $(PTX_PACKAGES_SELECTED),$(PTX_PACKAGES_ALL))

PTX_PACKAGES_INSTALL	:= \
	$(PACKAGES)

export \
	PTX_PACKAGES_ALL \
	PTX_PACKAGES_SELECTED \
	PTX_PACKAGES_DISABLED \
	PTX_PACKAGES_INSTALL

# might be non existent
include $(foreach dir, $(call reverse,$(subst :,$(space),$(PTXDIST_PATH_POSTRULES))), $(sort $(wildcard $(dir)/*.make)))
# install_alternative and install_copy has some configuration defined
# dependencies. include the files specifying these dependencies.
include $(wildcard $(STATEDIR)/*.deps)
# include late so the *PACKAGES* variables are already defined
include $(PTX_DGEN_DEPS_POST)

# ----------------------------------------------------------------------------
# just the "print" target
# ----------------------------------------------------------------------------

#
# expand variable names
# - if $(1) contains '%' then return all matching variables
#   otherwise if $(1) is a defined variable, then return it
# - if no match is found generate an error or return $(1) if make is
#   called with '-k'
#
define ptx/check-expand
$(or $(filter $(1),$(.VARIABLES)),$(if $(filter k,$(MAKEFLAGS)),$(1),$(error ##$(1)##)))
endef

#
# print the given variable
# if PTXDIST_VERBOSE=1 then prefix it with '<name>='
#
define ptx/print-var
$(info $(if $(filter 1,$(PTXDIST_VERBOSE)),$(1)=)$(call add_quote,$($(1))))
endef

#
# expand $(1) to one or more variables and print each one
#
define ptx/print-vars
$(foreach v,$(call ptx/check-expand,$(1)),$(call ptx/print-var,$(v)))
endef

#
# remember all variables for lint checks
# do this here to really catch all variable definition
#
ifdef PTXDIST_GEN_ALL
$(call ptx/file,>$(PTXDIST_TEMPDIR)/VARIABLES_ALL,$(.VARIABLES))
endif

#
# Pattern target to allow printing variable
# $(filter ..) is used to match against all existing variables so patterns
# containing '%' can be uses to print multiple variables.
# In verbose mode, '<name>=<value>' is printed.
# Trying to print undefined variables results in an error unless '-k' is
# used. In this case an empty value is printed.
#
/print-%: FORCE
	@:$(call ptx/print-vars,$(*))

#
# As above but tread the variable value as another variable and prints
# the value of this variable.
# Patterns are expanded as above on both levels.
# Printing stops at the first error.
#
/printnext-%: FORCE
	@:$(foreach v,$(call ptx/check-expand,$(*)),\
		$(foreach vv,$($(v)),\
			$(call ptx/print-vars,$(vv))))

# for backwards compatibility
print-%: /print-%
	@:

.PHONY: $(PHONY)

#
# Redefining $(SHELL) does not work properly when parallel processing happens.
# So redefine ptx/force-sh and ptx/sh to use regular shell calls.
#
define ptx/force-sh
$(call ptx/force-shell,$(1))
endef
ifneq ($(MAKE),true)
define ptx/sh
$(shell $(1))
endef
endif

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
