# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON) += python

#
# Paths and names
#
PYTHON_VERSION		:= 2.7.18
PYTHON_MD5		:= fd6cc8ec0a78c44036f825e739f36e5a
PYTHON_MAJORMINOR	:= $(basename $(PYTHON_VERSION))
PYTHON_SITEPACKAGES	:= /usr/lib/python$(PYTHON_MAJORMINOR)/site-packages
PYTHON			:= Python-$(PYTHON_VERSION)
PYTHON_SUFFIX		:= tar.xz
PYTHON_SOURCE		:= $(SRCDIR)/$(PYTHON).$(PYTHON_SUFFIX)
PYTHON_DIR		:= $(BUILDDIR)/$(PYTHON)
PYTHON_LICENSE		:= PYTHON
PYTHON_DEVPKG		:= NO

PYTHON_URL		:= \
	http://python.org/ftp/python/$(PYTHON_VERSION)/$(PYTHON).$(PYTHON_SUFFIX) \
	http://python.org/ftp/python/$(PYTHON_MAJORMINOR)/$(PYTHON).$(PYTHON_SUFFIX)

CROSS_PYTHON		:= $(PTXDIST_SYSROOT_CROSS)/bin/python$(PYTHON_MAJORMINOR)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON_PATH	:= PATH=$(CROSS_PATH)
PYTHON_CONF_ENV	:= \
	$(CROSS_ENV) \
	PYTHON_FOR_BUILD=$(PTXDIST_SYSROOT_CROSS)/bin/build-python \
	ac_sys_system=Linux \
	ac_sys_release=2 \
	MACHDEP=linux2 \
	ac_cv_have_chflags=no \
	ac_cv_have_lchflags=no \
	ac_cv_have_size_t_format=yes \
	ac_cv_broken_sem_getvalue=no \
	ac_cv_buggy_getaddrinfo=no \
	ac_cv_file__dev_ptmx=yes \
	ac_cv_file__dev_ptc=no \
	ac_cv_have_long_long_format=yes

PYTHON_BINCONFIG_GLOB := ""

#
# autoconf
#
PYTHON_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--disable-profiling \
	--disable-optimizations \
	--disable-toolbox-glue \
	$(GLOBAL_IPV6_OPTION) \
	--without-pydebug \
	--without-lto \
	--with-system-expat \
	--with-system-ffi \
	--with-signal-module \
	--with-threads \
	--without-doc-strings \
	--with-pymalloc \
	--without-valgrind \
	--with-wctype-functions \
	--with-fpectl \
	--with-computed-gotos \
	--without-ensurepip

PYTHON_BUILD_PYTHONPATH := \
	$(PTXDIST_SYSROOT_HOST)/lib/python$(PYTHON_MAJORMINOR)/lib-dynload \
	$(PYTHON_DIR)/build/lib.linux2-$(PTXCONF_ARCH_STRING)-$(PYTHON_MAJORMINOR) \
	$(PYTHON_DIR)/Lib \
	$(PYTHON_DIR)/Lib/plat-linux2

$(STATEDIR)/python.prepare:
	@$(call targetinfo)

	@rm -f 	$(PTXDIST_SYSROOT_CROSS)/bin/{link,build}-python
	@ln -s $(PTXDIST_SYSROOT_HOST)/bin/python$(PYTHON_MAJORMINOR) \
		$(PTXDIST_SYSROOT_CROSS)/bin/link-python
	@echo '#!/bin/sh'						>> $(PTXDIST_SYSROOT_CROSS)/bin/build-python
	@echo ''							>> $(PTXDIST_SYSROOT_CROSS)/bin/build-python
	@echo '_PYTHON_PROJECT_BASE="$(PYTHON_DIR)"'			>> $(PTXDIST_SYSROOT_CROSS)/bin/build-python
	@echo '_PYTHON_HOST_PLATFORM=linux2-$(PTXCONF_ARCH_STRING)'	>> $(PTXDIST_SYSROOT_CROSS)/bin/build-python
	@echo 'PYTHONPATH=$(subst $(space),:,$(PYTHON_BUILD_PYTHONPATH))' \
									>> $(PTXDIST_SYSROOT_CROSS)/bin/build-python
	@echo 'export _PYTHON_PROJECT_BASE _PYTHON_HOST_PLATFORM  PYTHONPATH' \
									>> $(PTXDIST_SYSROOT_CROSS)/bin/build-python
	@echo ''							>> $(PTXDIST_SYSROOT_CROSS)/bin/build-python
	@echo 'exec $(PTXDIST_SYSROOT_CROSS)/bin/link-python "$${@}"'	>> $(PTXDIST_SYSROOT_CROSS)/bin/build-python
	@chmod a+x $(PTXDIST_SYSROOT_CROSS)/bin/build-python

	@$(call world/prepare, PYTHON)
	@$(call touch)

PYTHON_MAKE_OPT := \
	PGEN_FOR_BUILD=$(PTXDIST_SYSROOT_HOST)/bin/pgen

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python.install:
	@$(call targetinfo)
	@$(call install, PYTHON)
	@sed -i \
		-e "s:$(SYSROOT):@SYSROOT@:g" \
		-e "s:$(PTXDIST_SYSROOT_HOST):@SYSROOT_HOST@:g" \
		$(PYTHON_PKGDIR)/usr/lib/python$(PYTHON_MAJORMINOR)/config/Makefile
	@$(call touch)

PYTHON_PYTHONPATH := \
	$(SYSROOT)/usr/lib/python$(PYTHON_MAJORMINOR) \
	$(SYSROOT)/usr/lib/python$(PYTHON_MAJORMINOR)/plat-linux2 \
	$(PTXDIST_SYSROOT_HOST)/lib/python$(PYTHON_MAJORMINOR)/lib-dynload \
	$(PTXDIST_SYSROOT_HOST)/lib/python$(PYTHON_MAJORMINOR)/site-packages

$(STATEDIR)/python.install.post:
	@$(call targetinfo)
	@sed -i \
		-e "s:@SYSROOT@:$(SYSROOT):g" \
		-e "s:@SYSROOT_HOST@:$(PTXDIST_SYSROOT_HOST):g" \
		$(PYTHON_PKGDIR)/usr/lib/python$(PYTHON_MAJORMINOR)/config/Makefile

	@$(call world/install.post, PYTHON)
	@rm -f "$(CROSS_PYTHON)"
	@echo '#!/bin/sh'						>> "$(CROSS_PYTHON)"
	@echo ''							>> "$(CROSS_PYTHON)"
	@echo 'PYTHONHOME=$(SYSROOT)/usr'				>> "$(CROSS_PYTHON)"
	@echo '_PYTHON_HOST_PLATFORM=linux2-$(PTXCONF_ARCH_STRING)'	>> "$(CROSS_PYTHON)"
	@echo 'PYTHONPATH=$(subst $(space),:,$(PYTHON_PYTHONPATH))'	>> "$(CROSS_PYTHON)"
	@echo 'export _PYTHON_HOST_PLATFORM PYTHONPATH PYTHONHOME'	>> "$(CROSS_PYTHON)"
	@echo ''							>> "$(CROSS_PYTHON)"
	@echo 'exec $(PTXDIST_SYSROOT_HOST)/bin/python$(PYTHON_MAJORMINOR) "$${@}"' \
									>> "$(CROSS_PYTHON)"
	@chmod a+x "$(CROSS_PYTHON)"

	@echo "#!/bin/sh" \
		> "$(CROSS_PYTHON)-config"
	@echo "exec \
		\"$(CROSS_PYTHON)\" \
		\"$(PTXDIST_SYSROOT_HOST)/bin/python$(PYTHON_MAJORMINOR)-config\" \
		\"\$${@}\"" \
		>> "$(CROSS_PYTHON)-config"
	@chmod a+x "$(CROSS_PYTHON)-config"
	@ln -sf "python$(PYTHON_MAJORMINOR)-config" \
		"$(PTXDIST_SYSROOT_CROSS)/bin/python-config"

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

PYTHON_SKIP-y							:= lib-tk idlelib
PYTHON_SKIP-$(call ptx/opt-dis, PTXCONF_PYTHON_DISTUTILS)	+= distutils

ifneq ($(PYTHON_SKIP-y),)
PYTHON_SKIP_LIST_PRE  :=-a \! -wholename $(quote)*/
PYTHON_SKIP_LIST_POST :=/*$(quote)

PYTHON_SKIP_LIST := $(subst $(space),$(PYTHON_SKIP_LIST_POST) $(PYTHON_SKIP_LIST_PRE),$(PYTHON_SKIP-y))
PYTHON_SKIP_LIST := $(PYTHON_SKIP_LIST_PRE)$(PYTHON_SKIP_LIST)$(PYTHON_SKIP_LIST_POST)
endif

# may add extra dependencies and is not useful for embedded
PYTHON_SKIP_LIST += -a \! -name nis.*

$(STATEDIR)/python.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python)
	@$(call install_fixup, python,PRIORITY,optional)
	@$(call install_fixup, python,SECTION,base)
	@$(call install_fixup, python,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, python,DESCRIPTION,missing)

	@cd $(PYTHON_PKGDIR) && \
		find ./usr/lib/python$(PYTHON_MAJORMINOR) \
		\! -wholename "*/test/*" -a \! -wholename "*/tests/*" \
		$(PYTHON_SKIP_LIST) \
		-a \( -name "*.so" -o -name "*.pyc" \) | \
		while read file; do \
		$(call install_copy, python, 0, 0, 0644, -, $${file##.}); \
	done

	@$(call install_copy, python, 0, 0, 0755, -, /usr/bin/python$(PYTHON_MAJORMINOR))
	@$(call install_link, python, python$(PYTHON_MAJORMINOR), /usr/bin/python2)
	@$(call install_lib, python, 0, 0, 0644, libpython$(PYTHON_MAJORMINOR))

ifdef PTXCONF_PYTHON_SYMLINK
	@$(call install_link, python, python$(PYTHON_MAJORMINOR), /usr/bin/python)
endif

	@$(call install_finish, python)

	@$(call touch)

# vim: syntax=make
