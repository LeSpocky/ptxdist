#!/bin/bash
#
# Copyright (C) 2022 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_bsp_report_header() {
    local layer
    do_echo() {
	if [ -n "${2}" ]; then
	    echo "  ${1} '${2}'"
	fi
    }
    echo "ptxdist:"
    do_echo "version:" "${PTXDIST_VERSION_FULL}"
    do_echo "path:" "${PTXDIST_TOPDIR}"
    echo "bsp:"
    do_echo "project-version:" "$(ptxd_get_ptxconf PTXCONF_PROJECT_VERSION)"
    do_echo "platform-version:" "$(ptxd_get_ptxconf PTXCONF_PLATFORM_VERSION)"
    do_echo "ptxconfig:" "${PTXDIST_PTXCONFIG}"
    do_echo "platformconfig:" "${PTXDIST_PLATFORMCONFIG}"
    do_echo "collectionconfig:" "${PTXDIST_COLLECTIONCONFIG}"
    do_echo "toolchain:" "$(readlink -f "${PTXDIST_PLATFORMDIR}/selected_toolchain")"
    echo "  layers:"
    for layer in "${PTXDIST_LAYERS[@]}"; do
	echo "  - '${layer}'"
    done
}
export -f ptxd_make_bsp_report_header

ptxd_make_full_bsp_report_pkg() {
    pkg_lic="${ptxd_package_license_association[${pkg}]}"
    if [ -z "${pkg_lic}" ]; then
	    return
    fi
    pkg_lic="${pkg_lic}/${pkg}"
    echo "  ${pkg}:"
    sed 's/^/    /' "${ptx_report_dir}/${pkg_lic}/license-report.yaml"
}
export -f ptxd_make_full_bsp_report_pkg

ptxd_make_full_bsp_report() {
    local -a ptxd_reply
    local pkg_lic pkg
    local -A ptxd_package_license_association

    ptxd_make_layer_init || return

    echo "Generating $(ptxd_print_path "${ptx_report_target}") ..."
    echo

    # regenerate license info and sort out unused packages
    for pkg in $(<"${ptx_report_dir}/package.list"); do
	ptxd_package_license_association[$(basename ${pkg})]=$(dirname ${pkg})
    done

    mkdir -p "$(dirname "${ptx_report_target}")" &&
    (
	ptxd_make_bsp_report_header || exit
	echo "packages:"
	for pkg in $(printf '%s\n' ${ptx_packages_selected} | sort -u); do
	    ptxd_make_full_bsp_report_pkg || exit
	done
	echo "images:"
	for pkg in $(printf '%s\n' ${ptx_image_packages} | sort -u); do
	    ptxd_make_full_bsp_report_pkg || exit
	done
    ) > "${PTXDIST_TEMPDIR}/full-report" &&
    mv "${PTXDIST_TEMPDIR}/full-report" "${ptx_report_target}" ||
    ptxd_bailout "failed to create BSP report"
}
export -f ptxd_make_full_bsp_report


ptxd_make_fast_bsp_report_pkg() {
    local pkg_report="${ptx_report_dir}/fast/${pkg}.yaml"
    if [ ! -e "${pkg_report}" ]; then
	    return
    fi
    echo "  ${pkg}:"
    sed 's/^/    /' "${pkg_report}"
}
export -f ptxd_make_fast_bsp_report_pkg

ptxd_make_fast_bsp_report() {
    local -a ptxd_reply
    local pkg_lic pkg

    ptxd_make_layer_init || return

    echo "Generating $(ptxd_print_path "${ptx_report_target}") ..."
    echo

    mkdir -p "$(dirname "${ptx_report_target}")" &&
    (
	ptxd_make_bsp_report_header || exit
	echo "packages:"
	for pkg in $(printf '%s\n' ${ptx_packages_selected} | sort -u); do
	    ptxd_make_fast_bsp_report_pkg || exit
	done
	echo "images:"
	for pkg in $(printf '%s\n' ${ptx_image_packages} | sort -u); do
	    ptxd_make_fast_bsp_report_pkg || exit
	done
    ) > "${PTXDIST_TEMPDIR}/fast-report" &&
    mv "${PTXDIST_TEMPDIR}/fast-report" "${ptx_report_target}" ||
    ptxd_bailout "failed to create BSP report"
}
export -f ptxd_make_fast_bsp_report

