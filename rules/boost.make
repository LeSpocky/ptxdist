# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BOOST) += boost

#
# Paths and names
#
BOOST_VERSION	:= 1_86_0
BOOST_MD5	:= 2d098ba2e1457708a02de996857c2b10
BOOST		:= boost_$(BOOST_VERSION)
BOOST_SUFFIX	:= tar.bz2
BOOST_URL	:= $(call ptx/mirror, SF, boost/$(BOOST).$(BOOST_SUFFIX))
BOOST_SOURCE	:= $(SRCDIR)/$(BOOST).$(BOOST_SUFFIX)
BOOST_DIR	:= $(BUILDDIR)/$(BOOST)
BOOST_LICENSE	:= BSL-1.0
BOOST_LICENSE_FILES := file://LICENSE_1_0.txt;md5=e4224ccaecb14d942c71d31bef20d78c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# "headers" is the fake library to install headers. If the library list is empty,
# it goes for all libraries. We start at least with headers lib here to avoid
# this
BOOST_LIBRARIES-y				:= headers

BOOST_LIBRARIES-$(PTXCONF_BOOST_ATOMIC)		+= atomic
BOOST_LIBRARIES-$(PTXCONF_BOOST_CHARCONV)	+= charconv
BOOST_LIBRARIES-$(PTXCONF_BOOST_CHRONO)		+= chrono
BOOST_LIBRARIES-$(PTXCONF_BOOST_COBALT)		+= cobalt
BOOST_LIBRARIES-$(PTXCONF_BOOST_CONTAINER)	+= container
BOOST_LIBRARIES-$(PTXCONF_BOOST_CONTEXT)	+= context
BOOST_LIBRARIES-$(PTXCONF_BOOST_CONTRACT)	+= contract
BOOST_LIBRARIES-$(PTXCONF_BOOST_COROUTINE)	+= coroutine
BOOST_LIBRARIES-$(PTXCONF_BOOST_DATE_TIME)	+= date_time
BOOST_LIBRARIES-$(PTXCONF_BOOST_EXCEPTION)	+= exception
BOOST_LIBRARIES-$(PTXCONF_BOOST_FIBER)		+= fiber
BOOST_LIBRARIES-$(PTXCONF_BOOST_FILESYSTEM)	+= filesystem
BOOST_LIBRARIES-$(PTXCONF_BOOST_GRAPH)		+= graph
BOOST_LIBRARIES-$(PTXCONF_BOOST_GRAPH_PARALLEL)	+= graph_parallel
BOOST_LIBRARIES-$(PTXCONF_BOOST_IOSTREAMS)	+= iostreams
BOOST_LIBRARIES-$(PTXCONF_BOOST_JSON)		+= json
BOOST_LIBRARIES-$(PTXCONF_BOOST_LOCALE)		+= locale
BOOST_LIBRARIES-$(PTXCONF_BOOST_LOG)		+= log
BOOST_LIBRARIES-$(PTXCONF_BOOST_MATH)		+= math
BOOST_LIBRARIES-$(PTXCONF_BOOST_MPI)		+= mpi
BOOST_LIBRARIES-$(PTXCONF_BOOST_NOWIDE)		+= nowide
BOOST_LIBRARIES-$(PTXCONF_BOOST_PREDEF)		+= predef
BOOST_LIBRARIES-$(PTXCONF_BOOST_PROCESS)	+= process
BOOST_LIBRARIES-$(PTXCONF_BOOST_PROGRAM_OPTIONS)+= program_options
BOOST_LIBRARIES-$(PTXCONF_BOOST_PYTHON)		+= python
BOOST_LIBRARIES-$(PTXCONF_BOOST_RANDOM)		+= random
BOOST_LIBRARIES-$(PTXCONF_BOOST_REGEX)		+= regex
BOOST_LIBRARIES-$(PTXCONF_BOOST_SERIALIZATION)	+= serialization
BOOST_LIBRARIES-$(PTXCONF_BOOST_STACKTRACE)	+= stacktrace
BOOST_LIBRARIES-$(PTXCONF_BOOST_SYSTEM)		+= system
BOOST_LIBRARIES-$(PTXCONF_BOOST_TEST)		+= test
BOOST_LIBRARIES-$(PTXCONF_BOOST_THREAD)		+= thread
BOOST_LIBRARIES-$(PTXCONF_BOOST_TIMER)		+= timer
BOOST_LIBRARIES-$(PTXCONF_BOOST_TYPE_ERASURE)	+= type_erasure
BOOST_LIBRARIES-$(PTXCONF_BOOST_URL)		+= url
BOOST_LIBRARIES-$(PTXCONF_BOOST_WAVE)		+= wave

BOOST_CONF_TOOL	:= NO
BOOST_CONF_OPT	:= \
	--with-toolset=gcc \
	--without-icu \
	--prefix="$(PKGDIR)/$(BOOST)/usr"

BOOST_ABI	:= sysv
ifneq ($(PTXCONF_ARCH_ARM)$(PTXCONF_ARCH_ARM64),)
BOOST_ARCH	:= arm
BOOST_ABI	:= aapcs
endif
ifdef PTXCONF_ARCH_X86
BOOST_ARCH	:= x86
endif
ifdef PTXCONF_ARCH_PPC
BOOST_ARCH	:= power
endif

# they reinvent their own wheel^Hmake: jam
# -q: quit on error
# -d: debug level, default=1
BOOST_JAM	:= \
	$(BOOST_DIR)/b2 \
	--ignore-site-config \
	--user-config=user-config.jam \
	--disable-icu \
	-q \
	$(if $(filter 0,$(PTXDIST_VERBOSE)),-d0) \
	--layout=system \
	-sNO_BZIP2=0 \
	-sZLIB_INCLUDE=$(SYSROOT)/usr/include \
	-sZLIB_LIBPATH=$(SYSROOT)/usr/lib \
	variant=release \
	debug-symbols=on \
	threading=multi \
	link=shared \
	toolset=gcc-$(PTXCONF_ARCH_STRING) \
	target-os=linux \
	abi=$(BOOST_ABI) \
	binary-format=elf \
	architecture=$(BOOST_ARCH) \
	address-model=$(call ptx/ifdef, PTXCONF_ARCH_LP64,64,32) \
	boost.locale.icu=off \
	$(addprefix --with-,$(BOOST_LIBRARIES-y)) \
	$(if $(filter y,$(PTXCONF_ARCH_X86)$(PTXCONF_ARCH_X86_64)),boost.stacktrace.from_exception=off)

JAM_PAR		:= \
	$(filter -j%,$(if $(PTXDIST_PARALLELMFLAGS),$(PTXDIST_PARALLELMFLAGS),$(PARALLELMFLAGS)))

# Use '=' to delay $(shell ...) calls until this is needed
JAM_MAKE_OPT	= \
	$(if $(shell test $(subst -j,,$(JAM_PAR)) -le 64 && echo 1),$(JAM_PAR),-j64) \
	stage

JAM_INSTALL_OPT	:= \
	install

$(STATEDIR)/boost.prepare:
	@$(call targetinfo)
	cd $(BOOST_DIR) && ./bootstrap.sh $(BOOST_CONF_OPT)
	@echo "using gcc : $(PTXCONF_ARCH_STRING) : $(CROSS_CXX) ;" > $(BOOST_DIR)/user-config.jam
ifdef PTXCONF_BOOST_MPI
	@echo "using mpi ;" >> $(BOOST_DIR)/user-config.jam
endif

ifdef PTXCONF_BOOST_PYTHON3
	@echo "using python : $(PYTHON3_MAJORMINOR) : $(PTXDIST_SYSROOT_CROSS)/usr/bin/python : $(SYSROOT)/usr/include/python$(PYTHON3_MAJORMINOR) : $(SYSROOT)/usr/lib/python$(PYTHON3_MAJORMINOR) ;" >> $(BOOST_DIR)/user-config.jam
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/boost.compile:
	@$(call targetinfo)
	@$(call world/execute, BOOST, $(BOOST_JAM) $(JAM_MAKE_OPT))
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/boost.install:
	@$(call targetinfo)
	@$(call world/execute, BOOST, $(BOOST_JAM) $(JAM_INSTALL_OPT))
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

BOOST_INST_LIBRARIES := $(addsuffix *.so.*,$(addprefix */libboost_,$(BOOST_LIBRARIES-y)))

$(STATEDIR)/boost.targetinstall:
	@$(call targetinfo)

ifdef PTXCONF_BOOST_LIBS
	@$(call install_init, boost)
	@$(call install_fixup, boost,PRIORITY,optional)
	@$(call install_fixup, boost,SECTION,base)
	@$(call install_fixup, boost,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, boost,DESCRIPTION,missing)

	@$(call install_glob, boost, 0, 0, -, /usr/lib, $(BOOST_INST_LIBRARIES))

	@$(call install_finish, boost)
endif

	@$(call touch)

# vim: syntax=make
