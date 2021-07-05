# -*-makefile-*-
#
# Copyright (C) 2021 by Lars Pedersen <lapeddk@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_YOYO_MIGRATIONS) += python3-yoyo-migrations

#
# Paths and names
#
PYTHON3_YOYO_MIGRATIONS_VERSION	:= 7.3.2
PYTHON3_YOYO_MIGRATIONS_MD5	:= bf1f70e0198a8dae5eb78e864d545456
PYTHON3_YOYO_MIGRATIONS		:= yoyo-migrations-$(PYTHON3_YOYO_MIGRATIONS_VERSION)
PYTHON3_YOYO_MIGRATIONS_SUFFIX	:= tar.gz
PYTHON3_YOYO_MIGRATIONS_URL	:= $(call ptx/mirror-pypi, yoyo-migrations, $(PYTHON3_YOYO_MIGRATIONS).$(PYTHON3_YOYO_MIGRATIONS_SUFFIX))
PYTHON3_YOYO_MIGRATIONS_SOURCE	:= $(SRCDIR)/$(PYTHON3_YOYO_MIGRATIONS).$(PYTHON3_YOYO_MIGRATIONS_SUFFIX)
PYTHON3_YOYO_MIGRATIONS_DIR	:= $(BUILDDIR)/$(PYTHON3_YOYO_MIGRATIONS)
PYTHON3_YOYO_MIGRATIONS_LICENSE	:= Apache-2.0
PYTHON3_YOYO_MIGRATIONS_LICENSE_FILES := \
	file://LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_YOYO_MIGRATIONS_CONF_TOOL	:= python3
PYTHON3_YOYO_MIGRATIONS_MAKE_OPT	:= install_scripts

# ----------------------------------------------------------------------------
# Install post
# ----------------------------------------------------------------------------

# Fix python shebang from an absolute path in yoyo and yoyo-migrate install_scripts
$(STATEDIR)/python3-yoyo-migrations.install.post:
	@$(call targetinfo)
	@sed -i -e '1s,^.*$$,\#\!\/usr\/bin\/python3,g' "$(PTXDIST_PLATFORMDIR)/packages/$(PYTHON3_YOYO_MIGRATIONS)/usr/bin/yoyo"
	@sed -i -e '1s,^.*$$,\#\!\/usr\/bin\/python3,g' "$(PTXDIST_PLATFORMDIR)/packages/$(PYTHON3_YOYO_MIGRATIONS)/usr/bin/yoyo-migrate"

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-yoyo-migrations.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-yoyo-migrations)
	@$(call install_fixup, python3-yoyo-migrations,PRIORITY,optional)
	@$(call install_fixup, python3-yoyo-migrations,SECTION,base)
	@$(call install_fixup, python3-yoyo-migrations,Lars Pedersen,"<lapeddk@gmail.com>")
	@$(call install_fixup, python3-yoyo-migrations,DESCRIPTION,missing)

	@$(call install_glob,python3-yoyo-migrations, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages,, *.py)

	@$(call install_copy, python3-yoyo-migrations, 0, 0, 0775, -, /usr/bin/yoyo)
	@$(call install_copy, python3-yoyo-migrations, 0, 0, 0775, -, /usr/bin/yoyo-migrate)

	@$(call install_finish, python3-yoyo-migrations)

	@$(call touch)

# vim: syntax=make
