# -*-makefile-*-
#
# Copyright (C) 2017 by Clemens Gruber <clemens.gruber@pqgruber.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBGPIOD) += libgpiod

#
# Paths and names
#
LIBGPIOD_VERSION	:= 2.1.3
LIBGPIOD_MD5		:= dd37487da746569b7311b2c8fd2f907d
LIBGPIOD		:= libgpiod-$(LIBGPIOD_VERSION)
LIBGPIOD_SUFFIX		:= tar.gz
LIBGPIOD_URL		:= https://www.kernel.org/pub/software/libs/libgpiod/$(LIBGPIOD).$(LIBGPIOD_SUFFIX)
LIBGPIOD_SOURCE		:= $(SRCDIR)/$(LIBGPIOD).$(LIBGPIOD_SUFFIX)
LIBGPIOD_DIR		:= $(BUILDDIR)/$(LIBGPIOD)
LIBGPIOD_LICENSE	:= LGPL-2.1-or-later AND GPL-2.0-only WITH Linux-syscall-note
LIBGPIOD_LICENSE_FILES	:= \
	file://COPYING;md5=7542998a6925b152c16facf9eaf5eb0c \
	file://LICENSES/LGPL-2.1-or-later.txt;md5=4b54a1fd55a448865a0b32d41598759d \
	file://LICENSES/GPL-2.0-only.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
	file://LICENSES/Linux-syscall-note.txt;md5=6b0dff741019b948dfe290c05d6f361c

ifdef PTXCONF_LIBGPIOD_TOOLS
LIBGPIOD_LICENSE	+= AND GPL-2.0-or-later
LIBGPIOD_LICENSE_FILES	+= file://LICENSES/GPL-2.0-or-later.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263
endif

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBGPIOD_CONF_TOOL	:= autoconf
LIBGPIOD_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_LIBGPIOD_TOOLS)-tools \
	--disable-gpioset-interactive \
	--disable-tests \
	--disable-profiling \
	--disable-examples \
	--$(call ptx/endis, PTXCONF_LIBGPIOD_CXX)-bindings-cxx \
	--$(call ptx/endis, PTXCONF_LIBGPIOD_PYTHON3)-bindings-python \
	--disable-bindings-rust

LIBGPIOD_CONF_ENV := \
	$(CROSS_ENV) \
	$(if $(PTXCONF_LIBGPIOD_PYTHON3), ac_cv_path_PYTHON=$(CROSS_PYTHON3))

LIBGPIOD_LDFLAGS:= -Wl,-rpath-link,$(LIBGPIOD_DIR)/lib/.libs

LIBGPIOD_TOOLS-$(PTXCONF_LIBGPIOD_GPIODETECT)	+= gpiodetect
LIBGPIOD_TOOLS-$(PTXCONF_LIBGPIOD_GPIOINFO)	+= gpioinfo
LIBGPIOD_TOOLS-$(PTXCONF_LIBGPIOD_GPIOGET)	+= gpioget
LIBGPIOD_TOOLS-$(PTXCONF_LIBGPIOD_GPIOSET)	+= gpioset
LIBGPIOD_TOOLS-$(PTXCONF_LIBGPIOD_GPIOMON)	+= gpiomon
LIBGPIOD_TOOLS-$(PTXCONF_LIBGPIOD_GPIONOTIFY)	+= gpionotify

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libgpiod.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libgpiod)
	@$(call install_fixup, libgpiod, PRIORITY, optional)
	@$(call install_fixup, libgpiod, SECTION, base)
	@$(call install_fixup, libgpiod, AUTHOR, "Clemens Gruber <clemens.gruber@pqgruber.com>")
	@$(call install_fixup, libgpiod, DESCRIPTION, "Linux GPIO character device library")

	@$(call install_lib, libgpiod, 0, 0, 0644, libgpiod)

	@for tool in $(LIBGPIOD_TOOLS-y); do \
		$(call install_copy, libgpiod, 0, 0, 0755, -, \
			/usr/bin/$$tool); \
	done

ifdef PTXCONF_LIBGPIOD_CXX
	@$(call install_lib, libgpiod, 0, 0, 0644, libgpiodcxx)
endif
ifdef PTXCONF_LIBGPIOD_PYTHON3
	@$(call install_glob, libgpiod, 0, 0, -, $(PYTHON3_SITEPACKAGES),, gpiod.*)
endif

	@$(call install_finish, libgpiod)

	@$(call touch)

# vim: syntax=make
