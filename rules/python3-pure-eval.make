# -*-makefile-*-
#
# Copyright (C) 2026 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_PURE_EVAL) += python3-pure-eval

#
# Paths and names
#
PYTHON3_PURE_EVAL_VERSION	:= 0.2.3
PYTHON3_PURE_EVAL_MD5		:= d545186f2c899d9dd273c03d71b7ffb7
PYTHON3_PURE_EVAL		:= pure_eval-$(PYTHON3_PURE_EVAL_VERSION)
PYTHON3_PURE_EVAL_SUFFIX	:= tar.gz
PYTHON3_PURE_EVAL_URL		:= $(call ptx/mirror-pypi, pure-eval, $(PYTHON3_PURE_EVAL).$(PYTHON3_PURE_EVAL_SUFFIX))
PYTHON3_PURE_EVAL_SOURCE	:= $(SRCDIR)/$(PYTHON3_PURE_EVAL).$(PYTHON3_PURE_EVAL_SUFFIX)
PYTHON3_PURE_EVAL_DIR		:= $(BUILDDIR)/$(PYTHON3_PURE_EVAL)
PYTHON3_PURE_EVAL_LICENSE	:= MIT
PYTHON3_PURE_EVAL_LICENSE_FILES	:= file://LICENSE.txt;md5=a3d6c15f7859ae235a78f2758e5a48cf

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PURE_EVAL_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pure-eval.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pure-eval)
	@$(call install_fixup, python3-pure-eval,PRIORITY,optional)
	@$(call install_fixup, python3-pure-eval,SECTION,base)
	@$(call install_fixup, python3-pure-eval,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python3-pure-eval,DESCRIPTION,missing)

	@$(call install_glob, python3-pure-eval, 0, 0, -, \
		$(PYTHON3_SITEPACKAGES),, *.py)

	@$(call install_finish, python3-pure-eval)

	@$(call touch)

# vim: ft=make
