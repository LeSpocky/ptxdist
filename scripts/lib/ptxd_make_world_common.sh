#!/bin/bash
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#


#
# check for deprecated vars and print them
#
ptxd_make_world_init_deprecation_check() {
    local -a dep
    dep=(
	pkg_deprecated_install_builddir
	pkg_deprecated_install_hosttool
	pkg_deprecated_install_opt

	pkg_deprecated_builddir
	pkg_deprecated_env
	pkg_deprecated_autoconf
	pkg_deprecated_cmake
	pkg_deprecated_compile_env
	pkg_deprecated_makevars
	)
    local i

    for ((i = 0; i < ${#dep[@]}; i++)); do
	local var="${dep[i]}"
	local val="${!var}"

	[ -z "${val}" ] && continue

	echo "${var}=\"${val}\""
	echo
    done

}
export -f ptxd_make_world_init_deprecation_check



#
# initialize deprecated variables to work with the new sheme
# (wich is still WIP)
#
ptxd_make_world_init_compat() {
    if [ "${pkg_stage}" = "prepare" ]; then
	ptxd_make_world_init_deprecation_check || return
    fi

    # build_dir
    if [ -n "${pkg_deprecated_install_builddir}" -a -n "${pkg_deprecated_builddir}" -a \
	"${pkg_deprecated_install_builddir}" != "${pkg_deprecated_builddir}" -o \
	-n "${pkg_build_dir}" -a -n "${pkg_deprecated_builddir}" -a \
	"${pkg_build_dir}" != "${pkg_deprecated_builddir}" ]; then
	ptxd_bailout "${FUNCNAME}: build dir inconsistency detected!"
    fi
    pkg_build_dir="${pkg_deprecated_install_builddir}"
    pkg_build_dir="${pkg_build_dir:-${pkg_deprecated_builddir}}"


    # env
    if [ -n "${pkg_deprecated_env}" ]; then
	if [ -n "${pkg_conf_env}" -o -n "${pkg_make_env}" ]; then
	    ptxd_bailout "${FUNCNAME}: <PKG>_ENV is incompatible with <PKG>_CONF_ENV or <PKG>_MAKE_ENV"
	fi
	pkg_conf_env="${pkg_deprecated_env}"
	pkg_install_env="${pkg_deprecated_env}"
    fi


    # autoconf
    if [ -n "${pkg_deprecated_autoconf}" ]; then
	if [ -n "${pkg_conf_opt}" ]; then
	    ptxd_bailout "${FUNCNAME}: <PKG>_AUTOCONF is incompatible with <PKG>_CONF_OPT"
	fi
	pkg_conf_opt="${pkg_deprecated_autoconf}"
	pkg_conf_tool="autoconf"
    fi


    # cmake
    if [ -n "${pkg_deprecated_cmake}" ]; then
	if [ -n "${pkg_conf_opt}" ]; then
	    ptxd_bailout "${FUNCNAME}: <PKG>_CMAKE is incompatible with <PKG>_CONF_OPT"
	fi
	pkg_conf_opt="${pkg_deprecated_cmake}"
	pkg_conf_tool="cmake"
    fi


    # compile_env
    if [ -n "${pkg_deprecated_compile_env}" ]; then
	if [ -n "${pkg_make_env}" ]; then
	    ptxd_bailout "${FUNCNAME}: <PKG>_COMPILE_ENV is incompatible with <PKG>_MAKE_ENV"
	fi
	pkg_make_env="${pkg_deprecated_compile_env}"
    fi


    # makevars
    if [ -n "${pkg_deprecated_makevars}" ]; then
	if [ -n "${pkg_make_opt}" ]; then
	    ptxd_bailout "${FUNCNAME}: <PKG>_MAKEVARS is incompatible with <PKG>_MAKE_OPT"
	fi
	pkg_make_opt="${pkg_deprecated_makevars}"
    fi


    # install_opt
    if [[ -z "${pkg_install_opt}" && "${pkg_conf_tool}" =~ "python" ]]; then
	local install_opt_ptr="ptx_install_opt_python_${pkg_type}"
	pkg_install_opt="${!install_opt_ptr}"
    fi
    if [ -z "${pkg_install_opt}" ]; then
	pkg_install_opt="install"

	# deprecared_makevars
	pkg_install_opt="${pkg_install_opt}${pkg_deprecated_makevars:+ }${pkg_deprecated_makevars}"

	# deprecared_install_opt
	pkg_install_opt="${pkg_install_opt}${pkg_deprecated_install_opt:+ }${pkg_deprecated_install_opt}"
    else
	if [ -n "${pkg_deprecated_makevars}" -o -n "${pkg_deprecated_install_opt}" ]; then
	    ptxd_bailout "${FUNCNAME}: <PKG>_MAKEVARS is incompatible with <PKG>_INSTALL_OPT"
	fi
    fi

    #
    # pkg_binconfig_glob
    #
    # default: "*-config"
    #
    pkg_binconfig_glob="${pkg_binconfig_glob:-*-config}"


    #
    # pkg_tags_opt
    #
    # default: "tags ctags"
    #
    pkg_tags_opt="${pkg_tags_opt:-tags ctags cscope}"


    #
    # pkg_sysroot_dir
    #
    case "${pkg_stamp}" in
	host-*)              pkg_sysroot_dir="${PTXDIST_SYSROOT_HOST}" ;;
	cross-*)             pkg_sysroot_dir="${PTXDIST_SYSROOT_CROSS}" ;;
	*)                   pkg_sysroot_dir="${PTXDIST_SYSROOT_TARGET}" ;;
    esac
    export pkg_sysroot_dir

    # pkg_env
    pkg_env="SYSROOT='${pkg_sysroot_dir}' V=${PTXDIST_VERBOSE} VERBOSE=${PTXDIST_VERBOSE/0/}"
}
export -f ptxd_make_world_init_compat



#
# basic sanity checks in pkg_ deps
#
ptxd_make_world_init_sanity_check() {
    #
    # subdir must be a relative path
    #
    [ "${pkg_subdir:0:1}" = "/" ] && \
	ptxd_bailout "variable 'SUBDIR' contains an absolute path ('${pkg_subdir}')"

    true
}
export -f ptxd_make_world_init_sanity_check


ptxd_make_world_env_init() {
    ptx_packages_all="${PTX_PACKAGES_ALL}"
    ptx_packages_selected="${PTX_PACKAGES_SELECTED}"
    ptx_packages_disabled="${PTX_PACKAGES_DISABLED}"
    image_pkgs_selected_target="${PTX_PACKAGES_INSTALL}"
}
export -f ptxd_make_world_env_init

#
# ptxd_make_world_init()
#
# environment in:
#
# environment out:
# $pkg_type
# $pkg_conf_dir
# $pkg_build_dir
# $pkg_build_oot
# $pkg_make_par
#
ptxd_make_world_init() {
    ptxd_make_world_env_init &&
    ptxd_make_world_init_sanity_check || return

    # PTXDIST_LAYERS gets lost in 'make' so redefine it here
    local orig_IFS="${IFS}"
    IFS=:
    PTXDIST_LAYERS=( ${PTXDIST_PATH_LAYERS} )
    IFS="${orig_IFS}"
    export PTXDIST_LAYERS

    # make sure any make calls appear to be the toplevel make
    unset MAKELEVEL

    #
    # type
    #
    case "${pkg_stamp}" in
	host-*|cross-*) pkg_type="${pkg_stamp%%-*}" ;;
	*)              pkg_type="target" ;;
    esac

    #
    # sanitize pkg_pkg_dir
    #
    if [ "${pkg_pkg_dir}" = "${ptx_pkg_dir}/" -o \
	 "${pkg_pkg_dir}" = "${ptx_pkg_dir}/host-" -o \
	 "${pkg_pkg_dir}" = "${ptx_pkg_dir}/cross-" -o \
	 "${pkg_pkg_dev}" = "NO" -a "${pkg_type}" != "target" ]; then
	pkg_pkg_dir=""
	local conf_opt_ext="_sysroot"
    fi

    #
    # label + stage
    #
    pkg_label="${pkg_stamp%%.*}"
    pkg_stage="${pkg_stamp#*.}"
    pkg_stage="${pkg_stage%%.*}"
    ptxd_make_world_init_compat || return

    #
    # xpkg mapping
    #
    pkg_xpkg_map="${ptx_state_dir}/${pkg_label}.xpkg.map"
    pkg_fake_env="${ptx_state_dir}/${pkg_label}.fakeroot"

    #
    # path
    #
    local path_ptr="ptx_path_${pkg_type}"
    pkg_path="${pkg_path:-${!path_ptr:+PATH=${!path_ptr}}}"
    unset path_ptr

    #
    # ensure that the package is actually selected
    #
    case "${pkg_stamp}" in
    ${pkg_label}.${pkg_stage})
	# this is only relevant for package stages, not any other targets
	if ! [[ " ${ptx_packages_selected} " =~ " ${pkg_label} " ]]; then
	    ptxd_bailout "'${pkg_label}' is not selected." \
		"This can happen if the ptxconfig is outdated or" \
		"the package is disabled for the current architecture"
	fi
	;;
    esac

    #
    # check if we shall use a local work-in-progress tree instead
    # of the configured URL.
    #
    # If a link in local_src/<label>.<platform> exists and points to
    # a directory, use this instead of the real one.
    #
    local wip_sources="${PTXDIST_WORKSPACE}/local_src/${pkg_label}${PTXDIST_PLATFORMSUFFIX}"
    if [ -d "$(readlink -f "${wip_sources}")" ]; then
	pkg_url="file://${wip_sources}"
	unset pkg_src
	# always use a new timestamp for wip builds
	SOURCE_DATE_EPOCH="$(echo $(date "+%s"))"
    fi
    unset wip_sources

    #
    # extract dir
    #
    local extract_ptr="ptx_extract_dir_${pkg_type}"
    pkg_extract_dir="${!extract_ptr}"
    unset extract_ptr

    #
    # conf dir
    #
    pkg_conf_dir="${pkg_dir}${pkg_subdir:+/}${pkg_subdir}"
    pkg_conf_dir_abs="${pkg_conf_dir}"

    #
    # conf tool
    #
    if [ -z "${pkg_conf_tool}" ]; then
	# ${pkg_conf_tool} will be bogus if more than one tool finds a match
	# -> prepare will complain later
	if [ -e "${pkg_conf_dir}/configure" ]; then
	    pkg_conf_tool=${pkg_conf_tool}autoconf
	fi
	if [ -e "${pkg_conf_dir}/CMakeLists.txt" ]; then
	    pkg_conf_tool=${pkg_conf_tool}cmake
	fi
	if [ $(ls "${pkg_conf_dir}/"*.pro 2>/dev/null | wc -l) -eq 1 ]; then
	    pkg_conf_tool=${pkg_conf_tool}qmake
	fi
	if [ -n "${pkg_config}" ]; then
	    pkg_conf_tool=${pkg_conf_tool}kconfig
	fi
	if [ -e "${pkg_conf_dir}/Makefile.PL" ]; then
	    pkg_conf_tool=${pkg_conf_tool}perl
	fi
	if [ -e "${pkg_conf_dir}/meson.build" ]; then
	    pkg_conf_tool=${pkg_conf_tool}meson
	fi
    fi

    case "${pkg_conf_tool}" in
	autoconf|cmake|qmake|kconfig|perl)
	    local conf_opt_ptr="ptx_conf_opt_${pkg_conf_tool}_${pkg_type}${conf_opt_ext}"
	    local conf_env_ptr="ptx_conf_env_${pkg_type}"

	    pkg_conf_opt="${pkg_conf_opt:-${!conf_opt_ptr}}"
	    pkg_conf_env="PTXDIST_ICECC= ${pkg_conf_env:-${!conf_env_ptr}}"

	    unset conf_opt_ptr conf_env_ptr
	    ;;
	python|python3)
	    local build_python_ptr="ptx_${pkg_conf_tool}_${pkg_type}"
	    local env_ptr="ptx_conf_env_${pkg_type}"

	    if [[ " ${pkg_build_deps} " =~ " host-system-python " && "${pkg_conf_tool}" = python ]]; then
		ptx_build_python=python
	    elif [[ " ${pkg_build_deps} " =~ " host-system-python3 " && "${pkg_conf_tool}" = python3 ]]; then
		ptx_build_python=python
	    else
		ptx_build_python="${!build_python_ptr}"
	    fi
	    pkg_make_env="${pkg_conf_env:-${!env_ptr}}"
	    pkg_make_opt="${pkg_make_opt:-build}"
	    ;;
	scons)
	    local env_ptr="ptx_conf_env_${pkg_type}"
	    pkg_make_env="${pkg_conf_env:-${!env_ptr}}"
	    pkg_make_opt="${pkg_conf_opt}"
	    ;;
	meson)
	    local conf_opt_ptr="ptx_conf_opt_${pkg_conf_tool}_${pkg_type}${conf_opt_ext}"
	    local conf_env_ptr="ptx_conf_env_${pkg_conf_tool}_${pkg_type}"

	    pkg_conf_opt="${pkg_conf_opt:-${!conf_opt_ptr}}"
	    pkg_conf_env="PTXDIST_ICECC= CMAKE=false CMAKE_FOR_BUILD=false ${pkg_conf_env:-${!conf_env_ptr}}"
	    ;;
	*)
	    local conf_env_ptr="ptx_conf_env_${pkg_type}"
	    pkg_conf_env="PTXDIST_ICECC= ${pkg_conf_env:-${!conf_env_ptr}}"

	    unset conf_env_ptr
	    ;;
    esac
    case "${pkg_conf_tool}" in
	scons|meson)
	    # Try to find a suitable UTF-8 locale on all distros
	    local c_locale
	    if c_locale=$(locale -a | grep -i -m 1 "^C\.utf[-]\?8$") || \
	       c_locale=$(locale -a | grep -i -m 1 "^en_US\.utf[-]\?8$") || \
	       c_locale=$(locale -a | grep -i -m 1 "^en_.*\.utf[-]\?8$"); then
		pkg_env="${pkg_env} LC_ALL='${c_locale}'"
	    else
		ptxd_warning "Failed to find a good UTF-8 locale for meson."
		pkg_env="${pkg_env} LC_ALL='$(locale -a | grep -i -m 1 "\.utf[-]\?8")'"
	    fi
	    unset c_locale
	    unset conf_opt_ptr
	    ;;
    esac
    local -a deps_host deps_target
    local whitelist_host whitelist_target
    for dep in ${pkg_build_deps}; do
	case "${dep}" in
	    host-*|cross-*)
		deps_host[${#deps_host[@]}]="${ptx_state_dir}/${dep}.pkgconfig"
		;;
	    *)
		deps_target[${#deps_target[@]}]="${ptx_state_dir}/${dep}.pkgconfig"
		;;
	esac
    done
    whitelist_host="$(echo $(cat "${deps_host[@]}" /dev/null 2>/dev/null))"
    whitelist_target="$(echo $(cat "${deps_target[@]}" /dev/null 2>/dev/null))"
    pkg_env="PKGCONFIG_WHITELIST_HOST='${whitelist_host}' PKGCONFIG_WHITELIST_TARGET='${whitelist_target}' PKGCONFIG_WHITELIST_SRC='${pkg_label}' ${pkg_env}"

    #
    # try to prevent downloads outside the get stage
    #
    if [ "${pkg_stage}" != "get" ]; then
	pkg_env="HTTPS_PROXY=- HTTP_PROXY=- https_proxy=- http_proxy=- ${pkg_env}"
    fi

    #
    # build dir
    #
    if [ -z "${pkg_build_dir}" ]; then
	if [ -z "${pkg_build_oot}" ]; then
	    case "${pkg_conf_tool}" in
		cmake) pkg_build_oot=YES ;;
		meson) pkg_build_oot=YES ;;
		*)     pkg_build_oot=NO ;;
	    esac
	fi
	case "${pkg_build_oot}" in
	    "YES"|"KEEP") pkg_build_dir="${pkg_dir}-build" ;;
	    "NO")  pkg_build_dir="${pkg_conf_dir}" ;;
	    *)     ptxd_bailout "<PKG>_BUILD_OOT: please set to KEEP, YES or NO" ;;
	esac
    fi

    #
    # out-of-tree
    #
    if [ "${pkg_build_dir}" = "${pkg_conf_dir}" ]; then
	unset pkg_build_oot
	#
	# some pkgs don't like a full path to their configure
	# if building in tree
	#
	pkg_conf_dir="."
    else
	if [ -z "${pkg_build_oot}" ]; then
	    pkg_build_oot=YES
	fi
	pkg_conf_dir="$(ptxd_abs2rel "${pkg_build_dir}" "${pkg_conf_dir}")"
    fi

    #
    # make or ninja
    #
    pkg_build_tool="${pkg_conf_tool}"
    case "${pkg_conf_tool}" in
	meson)
	    pkg_build_tool=ninja
	    ;;
	cmake)
	    if [ -e "${pkg_build_dir}/build.ninja" ]; then
		pkg_build_tool=ninja
	    fi
    esac
    if [ "${pkg_build_tool}" = "ninja" ]; then
	if [ "${PTXDIST_VERBOSE}" = "1" ]; then
	    pkg_make_opt="-v ${pkg_make_opt}"
	    pkg_install_opt="-v ${pkg_install_opt}"
	fi
    fi

    # DESTDIR
    case "${pkg_build_tool}" in
	python*)
	    pkg_install_opt="${pkg_install_opt} --root=${pkg_pkg_dir}"
	    ;;
	ninja|scons)
	    pkg_env="DESTDIR=\"${pkg_pkg_dir}\" ${pkg_env}"
	    ;;
	*)
	    pkg_install_opt="DESTDIR=\"${pkg_pkg_dir}\" INSTALL_ROOT=\"${pkg_pkg_dir}\" ${pkg_install_opt}"
	    ;;
    esac

    #
    # parallelmake
    #
    case "${pkg_make_par}" in
	YES) python_pkg_make_par="${PTXDIST_PARALLEL_FLAGS}" ;;
	"") python_pkg_make_par= ;;
	NO)
	    unset PTXDIST_PARALLELMFLAGS_INTERN
	    unset PTXDIST_PARALLEL_FLAGS
	    unset PTXDIST_JOBSERVER_FLAGS
	    ;;
	*)	  ptxd_bailout "<PKG>_MAKE_PAR: please set to YES or NO" ;;
    esac
    case "${pkg_build_tool}" in
	ninja)
	    # ninja needs explicit -j1 to avoid parallel building
	    if [ -z "${PTXDIST_PARALLEL_FLAGS}" ]; then
		PTXDIST_PARALLEL_FLAGS=-j1
	    fi
	    # pass jobserver via MAKEFLAGS to ninja
	    if [ -n "${PTXDIST_JOBSERVER_FLAGS}" ]; then
		pkg_env="${pkg_env} MAKEFLAGS='${PTXDIST_JOBSERVER_FLAGS}'"
		# no -jX argument if the jobserver is used
		unset PTXDIST_PARALLEL_FLAGS
	    fi
	    pkg_make_par="${PTXDIST_PARALLEL_FLAGS} ${PTXDIST_LOADMFLAGS}"
	    ;;
	python*)
	    # no consistant support for parallel building
	    pkg_make_par="${python_pkg_make_par}"
	    ;;
	scons)
	    # only -jX is supported not other options
	    pkg_make_par="${PTXDIST_PARALLEL_FLAGS}"
	    ;;
	*)
	    pkg_make_par="${PTXDIST_PARALLELMFLAGS_INTERN} ${PTXDIST_LOADMFLAGS}"
	    ;;
    esac

    #
    # reproducible builds for kbuild
    #
    # use a date/time format without spaces to avoid problems
    local kbuild_date="$(date --utc --date=@${SOURCE_DATE_EPOCH} -Iseconds)"
    pkg_env="${pkg_env} KBUILD_BUILD_TIMESTAMP=${kbuild_date} KBUILD_BUILD_USER=ptxdist KBUILD_BUILD_HOST=ptxdist"

    exec 2>&${PTXDIST_FD_LOGERR}
    if [ -n "${PTXDIST_QUIET}" ]; then
	exec 9>&1
    fi
}
export -f ptxd_make_world_init
