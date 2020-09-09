# -*-makefile-*-
#
# Copyright (C) 2020 by Bjoern Esser <bes@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NODEJS_PACKAGES) += nodejs_packages

#
# Paths and names
#
NODEJS_PACKAGES_VERSION	:= 0.0.1
NODEJS_PACKAGES		:= nodejs_packages-$(NODEJS_PACKAGES_VERSION)
NODEJS_PACKAGES_LOCAL	:= local_src/nodejs_packages
NODEJS_PACKAGES_URL	:= lndir://$(NODEJS_PACKAGES_LOCAL)
NODEJS_PACKAGES_DIR	:= $(BUILDDIR)/$(NODEJS_PACKAGES)
NODEJS_PACKAGES_CACHE	:= $(call ptx/in-path, PTXDIST_PATH_LAYERS, $(NODEJS_PACKAGES_LOCAL))/yarn_cache
NODEJS_PACKAGES_LICENSE	:= $(call remove_quotes, $(PTXCONF_NODEJS_PACKAGES_LICENSE))

NODEJS_PACKAGES_LIST	:= $(call remove_quotes, $(PTXCONF_NODEJS_PACKAGES_LIST))

YARN_LOCK	:= $(call ptx/in-path, PTXDIST_PATH_LAYERS, $(NODEJS_PACKAGES_LOCAL))/yarn.lock
YARN_OPTS	:= \
	--cwd "$(NODEJS_PACKAGES_DIR)" \
	--cache-folder "$(NODEJS_PACKAGES_CACHE)" \
	--link-duplicates \
	--production=true \
	--verbose

ifdef PTXCONF_NODEJS_PACKAGES_OFFLINE
YARN_OPTS	+= \
	--frozen-lockfile \
	--offline
endif

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/nodejs_packages.compile:
	@$(call targetinfo)
	@mkdir -vp $(NODEJS_PACKAGES_CACHE)
	@printf "{ \
		\"name\": \"nodejs_packages\", \
		\"version\": \"$(NODEJS_PACKAGES_VERSION)\", \
		\"license\": \"UNLICENSED\", \
		\"private\": true \
	}" > $(NODEJS_PACKAGES_DIR)/package.json
	@if [ ! -f $(YARN_LOCK) ]; then \
		if [  $(PTXCONF_NODEJS_PACKAGES_OFFLINE) = y ]; then \
			ptxd_bailout "Offline cache locked without existing 'yarn.lock'! \
				Please unlock and compile before locking again."; \
		fi; \
		touch $(YARN_LOCK); \
		ln -fs $(YARN_LOCK) $(NODEJS_PACKAGES_DIR)/yarn.lock; \
	fi
	yarn $(YARN_OPTS) add $(NODEJS_PACKAGES_LIST)
	@find $(NODEJS_PACKAGES_CACHE) -type f -name '.yarn-tarball.tgz' -delete
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nodejs_packages.install:
	@$(call targetinfo)
	@$(call world/execute, NODEJS_PACKAGES, \
		install -vdm 0755 $(NODEJS_PACKAGES_PKGDIR)/usr/lib)
	@$(call execute, NODEJS_PACKAGES, \
		cp -vpr $(NODEJS_PACKAGES_DIR)/node_modules \
			$(NODEJS_PACKAGES_PKGDIR)/usr/lib)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nodejs_packages.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nodejs_packages)
	@$(call install_fixup, nodejs_packages,PRIORITY,optional)
	@$(call install_fixup, nodejs_packages,SECTION,base)
	@$(call install_fixup, nodejs_packages,AUTHOR,"Bjoern Esser <bes@pengutronix.de>")
	@$(call install_fixup, nodejs_packages,DESCRIPTION,missing)

	$(call install_tree, nodejs_packages, 0, 0, -, /usr/lib/node_modules/)

	@$(call install_finish, nodejs_packages)

	@$(call touch)

# vim: syntax=make
