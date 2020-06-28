# -*-makefile-*-
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptx/env = \
	ptx_nfsroot="$(call ptx/escape,$(ROOTDIR))"				\
										\
	ptx_extract_dir_target="$(call ptx/escape,$(BUILDDIR))"			\
	ptx_extract_dir_host="$(call ptx/escape,$(HOST_BUILDDIR))"		\
	ptx_extract_dir_cross="$(call ptx/escape,$(CROSS_BUILDDIR))"		\
										\
	ptx_state_dir="$(call ptx/escape,$(STATEDIR))"				\
	ptx_image_dir="$(call ptx/escape,$(IMAGEDIR))"				\
	ptx_report_dir="$(call ptx/escape,$(REPORTDIR))"			\
	ptx_release_dir="$(call ptx/escape,$(RELEASEDIR))"			\
	ptx_lib_dir="$(call ptx/escape,$(PTXDIST_LIB_DIR))"			\
	ptx_pkg_dir="$(call ptx/escape,$(PKGDIR))"				\
	ptx_pkg_dev_dir="$(call ptx/escape,$(PTXDIST_DEVPKG_PLATFORMDIR))"	\
	ptx_path_rules="$(call ptx/escape,$(PTXDIST_PATH_RULES))"		\
										\
	ptx_path_target="$(call ptx/escape,$(CROSS_PATH))"			\
	ptx_conf_env_target="$(call ptx/escape,$(CROSS_ENV))"			\
	ptx_conf_opt_autoconf_target="$(call ptx/escape,$(CROSS_AUTOCONF_USR))"	\
	ptx_conf_opt_cmake_target="$(call ptx/escape,$(CROSS_CMAKE_USR))"	\
	ptx_conf_opt_qmake_target="$(call ptx/escape,$(CROSS_QMAKE_OPT))"	\
										\
	ptx_path_host="$(call ptx/escape,$(HOST_PATH))"				\
	ptx_conf_env_host="$(call ptx/escape,$(HOST_ENV))"			\
	ptx_conf_opt_autoconf_host="$(call ptx/escape,$(HOST_AUTOCONF))"	\
	ptx_conf_opt_cmake_host="$(call ptx/escape,$(HOST_CMAKE_OPT))"		\
	ptx_conf_opt_autoconf_host_sysroot="$(call ptx/escape,$(HOST_AUTOCONF_SYSROOT))"\
	ptx_conf_opt_cmake_host_sysroot="$(call ptx/escape,$(HOST_CMAKE_OPT_SYSROOT))"\
										\
	ptx_path_cross="$(call ptx/escape,$(HOST_CROSS_PATH))"			\
	ptx_conf_env_cross="$(call ptx/escape,$(HOST_CROSS_ENV))"		\
	ptx_conf_opt_autoconf_cross="$(call ptx/escape,$(HOST_CROSS_AUTOCONF))"	\
	ptx_conf_opt_autoconf_cross_sysroot="$(call ptx/escape,$(HOST_CROSS_AUTOCONF_SYSROOT))"\
										\
	ptx_python_target="$(call ptx/escape,$(CROSS_PYTHON))"			\
	ptx_python3_target="$(call ptx/escape,$(CROSS_PYTHON3))"		\
	ptx_install_opt_python_target="$(call ptx/escape,$(CROSS_PYTHON_INSTALL))"\
										\
	ptx_python_host="$(call ptx/escape,$(HOSTPYTHON))"			\
	ptx_python3_host="$(call ptx/escape,$(HOSTPYTHON3))"			\
	ptx_install_opt_python_host="$(call ptx/escape,$(HOST_PYTHON_INSTALL))"	\
										\
	ptx_conf_opt_meson_target="$(call ptx/escape,$(CROSS_MESON_USR))"	\
	ptx_conf_env_meson_target="$(call ptx/escape,$(CROSS_MESON_ENV))"	\
										\
	ptx_conf_opt_meson_host="$(call ptx/escape,$(HOST_MESON_OPT))"		\
	ptx_conf_env_meson_host="$(call ptx/escape,$(HOST_ENV))"		\
										\
	ptx_xpkg_extra_args=$(PTXCONF_IMAGE_XPKG_EXTRA_ARGS)

world/env/impl = \
	pkg_stamp="$(notdir $(@))"						\
	pkg_pkg_dir="$(call ptx/escape,$($(1)_PKGDIR))"				\
	pkg_pkg_dev="$(call ptx/escape,$($(1)_DEVPKG))"				\
	pkg_license="$(call ptx/escape,$($(1)_LICENSE))"			\
	pkg_build_deps="$(call ptx/escape,$(PTX_MAP_B_dep_$(1)))"		\
	pkg_build_deps_all="$(call ptx/escape,$(PTX_MAP_B_dep_all_$(1)))"	\
	pkg_run_deps="$(call ptx/escape,$(PTX_MAP_R_dep_$(1)))"			\
	pkg_run_deps_all="$(call ptx/escape,$(PTX_MAP_R_dep_all_$(1)))"		\
	pkg_license_files="$(call ptx/escape,$($(1)_LICENSE_FILES))"		\
	pkg_makefile="$(call ptx/escape,$($(1)_MAKEFILE))"			\
	pkg_infile="$(call ptx/escape,$($(1)_INFILE))"				\
										\
	pkg_pkg="$(call ptx/escape,$($(1)))"					\
	pkg_version="$(call ptx/escape,$($(1)_VERSION))"			\
	pkg_config="$(call ptx/escape,$($(1)_CONFIG))"				\
	pkg_ref_config="$(call ptx/escape,$($(1)_REF_CONFIG))"			\
	pkg_path="$(call ptx/escape,$($(1)_PATH))"				\
	pkg_patch_series="$(call ptx/escape,$(call remove_quotes, $(PTXCONF_$(strip $(1))_SERIES)))"\
	pkg_patch_dir="$(call ptx/escape,$($(1)_PATCH_DIR))"			\
	pkg_src="$(call ptx/escape,$($(1)_SOURCE))"				\
	pkg_srcs="$(call ptx/escape,$($(1)_SOURCES))"				\
	pkg_md5s="$(call ptx/escape,$(foreach s,$($(1)_SOURCES),$($($(s))_MD5):))"\
	pkg_md5="$(call ptx/escape,$($(1)_MD5))"				\
	pkg_url="$(call ptx/escape,$($(1)_URL))"				\
	pkg_cfghash="$(call ptx/escape,$($(1)_CFGHASH))"			\
	pkg_srchash="$(call ptx/escape,$($(1)_EXTRACT_CFGHASH))"		\
										\
	pkg_dir="$(call ptx/escape,$($(1)_DIR))"				\
	pkg_subdir="$(call ptx/escape,$($(1)_SUBDIR))"				\
	pkg_strip_level="$(call ptx/escape,$($(1)_STRIP_LEVEL))"		\
										\
	pkg_tags_opt="$(call ptx/escape,$($(1)_TAGS_OPT))"			\
										\
	pkg_build_oot="$(call ptx/escape,$($(1)_BUILD_OOT))"			\
	pkg_build_dir="$(call ptx/escape,$($(1)_BUILD_DIR))"			\
										\
	pkg_wrapper_blacklist="$(call ptx/escape,$($(1)_WRAPPER_BLACKLIST))"	\
										\
	pkg_cppflags="$(call ptx/escape,$($(1)_CPPFLAGS))"			\
	pkg_cflags="$(call ptx/escape,$($(1)_CFLAGS))"				\
	pkg_cxxflags="$(call ptx/escape,$($(1)_CXXFLAGS))"			\
	pkg_ldflags="$(call ptx/escape,$($(1)_LDFLAGS))"			\
										\
	pkg_conf_tool="$(call ptx/escape,$($(1)_CONF_TOOL))"			\
	pkg_conf_env="$(call ptx/escape,$($(1)_CONF_ENV))"			\
	pkg_conf_opt="$(call ptx/escape,$($(1)_CONF_OPT))"			\
										\
	pkg_make_env="$(call ptx/escape,$($(1)_MAKE_ENV))" 			\
	pkg_make_opt="$(call ptx/escape,$($(1)_MAKE_OPT))"			\
	pkg_make_par="$(call ptx/escape,$($(1)_MAKE_PAR))"			\
										\
	pkg_install_opt="$(call ptx/escape,$($(1)_INSTALL_OPT))"		\
	pkg_binconfig_glob="$(call ptx/escape,$($(1)_BINCONFIG_GLOB))"		\
										\
	pkg_nfsroot_dirs="$(call ptx/escape,$($(1)_NFSROOT_DIRS))"		\
										\
	pkg_deprecated_builddir="$(call ptx/escape,$($(1)_BUILDDIR))"		\
	pkg_deprecated_env="$(call ptx/escape,$($(1)_ENV))"			\
	pkg_deprecated_autoconf="$(call ptx/escape,$($(1)_AUTOCONF))"		\
	pkg_deprecated_cmake="$(call ptx/escape,$($(1)_CMAKE))"			\
	pkg_deprecated_compile_env="$(call ptx/escape,$($(1)_COMPILE_ENV))"	\
	pkg_deprecated_makevars="$(call ptx/escape, $($(1)_MAKEVARS))"

world/env= \
	$(call world/env/impl,$(strip $(1))) \
	$(call ptx/env)

# vim: syntax=make
