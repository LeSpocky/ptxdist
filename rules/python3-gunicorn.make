# -*-makefile-*-
#
# Copyright (C) 2022 by Bruno Thomsen <bruno.thomsen@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_GUNICORN) += python3-gunicorn

#
# Paths and names
#
PYTHON3_GUNICORN_VERSION	:= 20.1.0
PYTHON3_GUNICORN_MD5		:= db8a7c5c2064000af70286534803bf1d
PYTHON3_GUNICORN		:= gunicorn-$(PYTHON3_GUNICORN_VERSION)
PYTHON3_GUNICORN_SUFFIX		:= tar.gz
PYTHON3_GUNICORN_URL		:= $(call ptx/mirror-pypi, gunicorn, $(PYTHON3_GUNICORN).$(PYTHON3_GUNICORN_SUFFIX))
PYTHON3_GUNICORN_SOURCE		:= $(SRCDIR)/$(PYTHON3_GUNICORN).$(PYTHON3_GUNICORN_SUFFIX)
PYTHON3_GUNICORN_DIR		:= $(BUILDDIR)/$(PYTHON3_GUNICORN)
PYTHON3_GUNICORN_LICENSE	:= MIT
PYTHON3_GUNICORN_LICENSE_FILES	:= \
	file://LICENSE;md5=f75f3fb94cdeab1d607e2adaa6077752

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_GUNICORN_CONF_TOOL	:= python3
PYTHON3_GUNICORN_MAKE_OPT	:= install_scripts

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-gunicorn.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-gunicorn)
	@$(call install_fixup, python3-gunicorn,PRIORITY,optional)
	@$(call install_fixup, python3-gunicorn,SECTION,base)
	@$(call install_fixup, python3-gunicorn,AUTHOR,"Bruno Thomsen <bruno.thomsen@gmail.com>")
	@$(call install_fixup, python3-gunicorn,DESCRIPTION,missing)

	@$(call install_glob, python3-gunicorn, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_copy, python3-gunicorn, 0, 0, 0775, -, /usr/bin/gunicorn)

	@$(call install_finish, python3-gunicorn)

	@$(call touch)

# vim: syntax=make
