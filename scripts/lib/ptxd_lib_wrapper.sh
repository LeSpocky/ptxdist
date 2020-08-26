#!/bin/bash
#
# Copyright (C) 2020 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_lib_setup_host_wrapper() {
    local cc_ptr cc cc_abs cc_default cc_alternate

    mkdir -p -- "${wrapper_dir}/real" ||
    ptxd_bailout "cannot create dir: '${wrapper_dir}/real'"

    ptxd_replace_copy_from_path PTXDIST_PATH \
	scripts/wrapper/libwrapper.sh "${wrapper_dir}/libwrapper.sh"

    for cc_ptr in \
	PTXCONF_SETUP_HOST_CPP \
	PTXCONF_SETUP_HOST_CC \
	PTXCONF_SETUP_HOST_CXX \
	; do
	cc="${!cc_ptr}"
	if [ -z "${cc}" ]; then
	    echo
	    echo "${PTXDIST_LOG_PROMPT}error: undefined host ${cc_ptr##*_} compiler"
	    echo "${PTXDIST_LOG_PROMPT}error: run 'ptxdist setup' and enter the 'Developer Options' menu"
	    echo "${PTXDIST_LOG_PROMPT}error: and specify the compiler"
	    echo
	    exit 1
	fi

	cc_abs="$(which "${cc}" 2>/dev/null)"
	if [ \! -x "${cc_abs}" ]; then
	    echo
	    echo "${PTXDIST_LOG_PROMPT}error: your host ${cc_ptr##*_} compiler: '${cc}'"
	    echo "${PTXDIST_LOG_PROMPT}error: cannot be found or isn't executable"
	    echo "${PTXDIST_LOG_PROMPT}error: run 'ptxdist setup' and enter the 'Developer Options' menu"
	    echo "${PTXDIST_LOG_PROMPT}error: and specify the compiler"
	    echo
	    exit 1
	fi

	case "${cc_ptr}" in
	    PTXCONF_SETUP_HOST_CPP)
	    cc_default=cpp
	    unset cc_alternate
	    ;;
	    PTXCONF_SETUP_HOST_CC)
	    cc_default=gcc
	    cc_alternate=cc
	    ;;
	    PTXCONF_SETUP_HOST_CXX)
	    cc_default=g++
	    cc_alternate=c++
	    ;;
	esac

	ptxd_replace_link "${cc_abs}" "${wrapper_dir}/real/${cc_default}" &&
	ptxd_replace_copy_from_path PTXDIST_PATH "scripts/wrapper/host-${cc_default}-wrapper" \
	    "${wrapper_dir}/${cc_default}" &&

	if [ -n "${cc_alternate}" ]; then
	    ptxd_replace_link "${cc_default}" "${wrapper_dir}/${cc_alternate}" &&
	    ptxd_replace_link "${cc_default}" "${wrapper_dir}/real/${cc_alternate}"
	fi || {
	    rm -rf "${wrapper_dir}"
	    ptxd_bailout "unable to create compiler wrapper link"
	}
    done

    ptxd_replace_copy_from_path PTXDIST_PATH "scripts/wrapper/python-wrapper" \
	"${wrapper_dir}/python-wrapper" &&
    for python in python2 python2-config python3 python3-config; do
	if type -P "${python}" > /dev/null; then
	    ptxd_replace_link "python-wrapper" "${wrapper_dir}/${python}" || \
		ptxd_bailout "Unable to create ${python} wrapper link"
	    ptxd_replace_link "python-wrapper" "${wrapper_dir}/${python/[23]}" || \
		ptxd_bailout "Unable to create ${python/[23]} wrapper link"
	fi
    done &&

    for tool in ar as nm objcopy objdump ranlib readelf size strip ; do
	tool_abs="$(which "${tool}" 2>/dev/null)"
	ptxd_replace_link "${tool_abs}" "${wrapper_dir}/${tool}" || \
	    ptxd_bailout "Unable to create host ${tool} wrapper link"
    done
}
export -f ptxd_lib_setup_host_wrapper


ptxd_lib_setup_toolchain() {
    local vendor_should compiler_ver_should
    #
    # Three things should be checked
    # 1) Correct compiler name
    # 2) Correct vendor if the vendor string is given
    # 3) Correct compiler version if a specific compiler version is given
    #

    vendor_should="$(ptxd_get_ptxconf PTXCONF_CROSSCHAIN_VENDOR)" && {
	local ptxdist_vendor_def ct_vendor_def vendor_is
	# yea! A toolchain vendor was specified in the ptxconfig file.
	#
	# We have two options now:
	#  a) the provided toolchain is an OSELAS.Toolchain which contains a
	#     'ptxconfig', so test the PTXCONF_PROJECT string therein.
	#  b) the provided toolchain is a crosstool-ng one which contains a
	#     ${compiler_prefix}-ct-ng.config, so test the
	#     CT_TOOLCHAIN_PKGVERSION therein.
	#

	if [ ! -d "${PTXDIST_TOOLCHAIN}" ]; then
	    echo
	    echo "${PTXDIST_LOG_PROMPT}error: specify '${PTXDIST_TOOLCHAIN#${PTXDIST_WORKSPACE}/}' with 'ptxdist toolchain [<path>]'"
	    echo "${PTXDIST_LOG_PROMPT}error: or leave PTXCONF_CROSSCHAIN_VENDOR empty to disable toolchain check"
	    echo
	    exit 1
	fi

	ptxdist_vendor_def="$(readlink -f "${PTXDIST_TOOLCHAIN}/ptxconfig")"
	ct_vendor_def="$(readlink -f "${PTXDIST_TOOLCHAIN}/${compiler_prefix}ct-ng.config")"

	if [ "${ptxdist_vendor_def}" -a -e "${ptxdist_vendor_def}" ]; then
	    vendor_is="$(source "${ptxdist_vendor_def}" && echo ${PTXCONF_PROJECT})"
	elif [ "${ct_vendor_def}" -a -x "${ct_vendor_def}" ]; then
	    vendor_is=$(${ct_vendor_def} | awk ' \
		    /^#\s+crosstool-NG.*Configuration$/ { \
			printf("%s %s", $2, $3) \
		    }; \
		    /^CT_TOOLCHAIN_PKGVERSION=/ { \
			gsub(/\"/, ""); \
			split($0,ary,"="); \
			if (ary[1]) { \
			    printf(" - %s", ary[2]); \
			} \
		    }')
	else
	    echo
	    echo "${PTXDIST_LOG_PROMPT}error: toolchain doesn't point to an OSELAS.Toolchain nor a crosstools-ng toolchain"
	    echo "${PTXDIST_LOG_PROMPT}error: leave PTXCONF_CROSSCHAIN_VENDOR empty to disable vendor check"
	    echo
	    exit 1
	fi

	# both vendor strings are present. Check them
	case "${vendor_is}" in
	"${vendor_should}"*)
	    ;;
	*)
	    echo
	    echo "${PTXDIST_LOG_PROMPT}error: wrong toolchain vendor: Cannot continue! Vendor is '${vendor_is}',"
	    echo "${PTXDIST_LOG_PROMPT}error: specified: ${vendor_should}"
	    echo "${PTXDIST_LOG_PROMPT}error: found:     ${vendor_is}"
	    echo
	    exit 1
	    ;;
	esac
    }

    compiler_ver_should="$(ptxd_get_ptxconf PTXCONF_CROSSCHAIN_CHECK)" && {
	local compiler compiler_ver_is

	compiler="${compiler_prefix}gcc"
	compiler_ver_is="$(${toolchain}/${compiler} -dumpversion 2> /dev/null || true)"

	if [ -z "${compiler_ver_is}" ]; then
	    echo
	    echo "${PTXDIST_LOG_PROMPT}error: Compiler '${compiler}' not found. Check PATH or"
	    echo "${PTXDIST_LOG_PROMPT}error: use 'ptxdist toolchain [</path/to/toolchain>]'."
	    echo
	    exit 1
	fi

	if [ "${compiler_ver_is}" != "${compiler_ver_should}" ]; then
	    echo
	    echo "${PTXDIST_LOG_PROMPT}error: Compiler version ${compiler_ver_should} expected,"
	    echo "${PTXDIST_LOG_PROMPT}error: but ${compiler_ver_is} found."
	    echo
	    exit 1
	fi
    }

    ptxd_replace_link "${toolchain}" "${PTXDIST_PLATFORMDIR}/selected_toolchain"
}
export -f ptxd_lib_setup_toolchain

ptxd_lib_setup_target_wrapper() {
    for cc in gcc g++ cpp ld gdb; do
	if [ ! -e "${toolchain}/${compiler_prefix}${cc}" ]; then
	    rm -f "${wrapper_dir}/real/${compiler_prefix}${cc}" \
		"${wrapper_dir}/${compiler_prefix}${cc}"
	    continue
	fi
	ptxd_replace_link "${toolchain}/${compiler_prefix}${cc}" "${wrapper_dir}/real/${compiler_prefix}${cc}" &&
	ptxd_replace_copy_from_path PTXDIST_PATH "scripts/wrapper/${cc}-wrapper" \
	    "${wrapper_dir}/${compiler_prefix}${cc}"
    done &&
    for cc in clang clang++; do
	if [ ! -e "${toolchain}/${cc}" ]; then
	    rm -f "${wrapper_dir}/real/${compiler_prefix}${cc}" \
		"${wrapper_dir}/${compiler_prefix}${cc}"
	    continue
	fi
	ptxd_replace_link "${toolchain}/${cc}" "${wrapper_dir}/real/${compiler_prefix}${cc}" &&
	ptxd_replace_copy_from_path PTXDIST_PATH "scripts/wrapper/${cc}-wrapper" \
	    "${wrapper_dir}/${compiler_prefix}${cc}"
	ptxd_replace_link "${toolchain}/${cc}" "${wrapper_dir}/real/${cc}" &&
	ptxd_replace_copy_from_path PTXDIST_PATH "scripts/wrapper/host-${cc}-wrapper" \
	    "${wrapper_dir}/${cc}"
    done
    for tool in "${toolchain}/${compiler_prefix}"* ; do
	local toolname="${tool#${toolchain}/}"
	if [ ! -e "${wrapper_dir}/${toolname}" -o -h "${wrapper_dir}/${toolname}" ]; then
	    ptxd_replace_link "${tool}"  "${wrapper_dir}/${toolname}"
	fi
    done &&
    for tool in "${wrapper_dir}/${compiler_prefix}"* ; do
	local toolname="${tool#${wrapper_dir}/}"
	if [ -e "${tool}" -a ! -e "${toolchain}/${toolname}" ]; then
	    rm -f "${tool}"
	fi
    done
}
export -f ptxd_lib_setup_target_wrapper
