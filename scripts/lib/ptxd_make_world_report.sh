#!/bin/bash
#
# Copyright (C) 2022 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_world_report_init() {
    # use patchin_init for  pkg_patch_dir
    ptxd_make_world_patchin_init || return

    pkg_license="${pkg_license:-unknown}"

    ptxd_make_world_license_flags || return

    pkg_section="$(ptxd_create_section_from_license "${pkg_license}")"
}
export -f ptxd_make_world_report_init

ptxd_make_world_report_commit() {
    if [ "$(ptxd_get_ptxconf PTXCONF_PROJECT_STORE_SOURCE_GIT_COMMITS)" != "y" ]; then
	return
    fi
    if [ -e "${pkg_src}.commit" ]; then
	pkg_commit="$(<"${pkg_src}.commit")"
    fi
}
export -f ptxd_make_world_report_commit

ptxd_make_world_report_yaml_fragment() {
    local pkg tmp_report pkg_commit

    do_echo() {
	if [ -n "${2}" ]; then
	    echo "${1} '${2}'"
	fi
    }
    do_list() {
	if [ -n "${2}" ]; then
	    echo "${1}"
	    awk "BEGIN { RS=\" \" } { if (\$1) print \"  - '\" \$1 \"'\" }" <<<"${2}"
	fi
    }

    ptxd_make_world_report_init || return

    tmp_report="${PTXDIST_TEMPDIR}/${pkg_label}-source-packages.yaml"

    if [ "${pkg_PKG}" = "${pkg_main_PKG}" ]; then
	pkg="${pkg_label}"
    else
	pkg="${pkg_PKG,,}"
	pkg="${pkg//_/-}"
    fi

    {
	do_echo "- name:" "${pkg}"
	do_echo "  version:" "${pkg_version}"
	do_list "  url:" "${pkg_url}"
	do_echo "  md5:" "${pkg_md5}"
	do_echo "  source:" "${pkg_src}"
	ptxd_make_world_report_commit
	do_echo "  git-commit:" "${pkg_commit}"
    } >> "${tmp_report}"
}
export -f ptxd_make_world_report_yaml_fragment


ptxd_make_world_report_yaml() {
    local tmp_report="${PTXDIST_TEMPDIR}/${pkg_label}-source-packages.yaml"
    do_echo() {
	if [ -n "${2}" ]; then
	    echo "${1} '${2}'"
	fi
    }
    do_list() {
	if [ -n "${2}" ]; then
	    echo "${1}"
	    awk "BEGIN { RS=\" \" } { if (\$1) print \"- '\" \$1 \"'\" }" <<<"${2}"
	fi
    }
    do_echo "name:" "${pkg_label}"
    do_echo "rulefile:" "${pkg_makefile}"
    do_list "extra-rulefiles:" "${pkg_extra_makefiles}"
    do_echo "menufile:" "${pkg_infile}"
    do_list "builddeps:" "${pkg_build_deps}"
    do_list "rundeps:" "${pkg_run_deps}"
    do_echo "config:" "${pkg_config}"
    do_echo "version:" "${pkg_version}"
    do_list "url:" "${pkg_url}"
    do_echo "md5:" "${pkg_md5}"
    do_echo "source:" "${pkg_src}"
    if [ -n "${pkg_md5s}" -a "${pkg_md5s}" != ":" ]; then
	echo "md5s:"
	awk "BEGIN { RS=\" *:\\\\s*\"; FS=\":\" } { if (\$1) print \"- '\" \$1 \"'\" }" <<<"${pkg_md5s}"
    fi
    do_list "sources:" "${pkg_srcs}"
    if [ -e "${tmp_report}" ]; then
	echo "source-packages:"
	cat "${tmp_report}"
    fi
    do_echo "patches:" "${pkg_patch_dir}"
    if [ "${pkg_patch_series}" != "series" -a -n "${pkg_patch_dir}" ]; then
	do_echo "series:" "${pkg_patch_series}"
    fi
    do_echo "srcdir:" "${pkg_dir}"
    do_echo "builddir:" "${pkg_build_dir}"
    do_echo "pkgdir:" "${pkg_pkg_dir}"
    do_echo "cfghash:" "${pkg_cfghash}"
    do_echo "srchash:" "${pkg_srchash}"
    if [ "$(ptxd_get_ptxconf PTXCONF_PROJECT_CREATE_DEVPKGS)" == "y" -o \
	 "$(ptxd_get_ptxconf PTXCONF_PROJECT_USE_DEVPKGS)" == "y" ]; then
	do_echo "devpkg:" "${ptx_pkg_dir}/${pkg_pkg_dev}"
    fi
    do_echo "license-section:" "${pkg_section}"
    do_echo "licenses:" "${pkg_license}"
    do_list "license-flags:" "${!pkg_license_flags[*]}"
    if [ "${1}" != "fast" ]; then
	if [ ${#pkg_license_texts[@]} -gt 0 -o ${#pkg_license_texts_guessed[@]} -gt 0 ]; then
	    # license files have been extracted, so add the expanded data
	    echo "license-files:"
	fi
	local guess="false"
	for license in "${pkg_license_texts[@]}" - "${pkg_license_texts_guessed[@]}"; do
	    if [ "${license}" = "-" ]; then
		guess="true"
		continue
	    fi
	    cat << EOF
  $(basename "${license}"):
    guessed: ${guess}
    file: '${license}'
    md5: '$(sed -n "s/\(.*\)  $(basename "${license}")\$/\1/p" "${pkg_license_dir}/license/MD5SUM")'
EOF
	done
	if [[ " ${pkg_build_deps} " =~ " host-nodejs " ]] && [ -e "${pkg_dir}/package-lock.json" ]; then
	    (
	    cd "${pkg_dir}" &&
	    npm sbom --sbom-format spdx > "${pkg_license_dir}/spdx-sbom.json" &&
	    npm sbom --sbom-format cyclonedx > "${pkg_license_dir}/cyclonedx-sbom.json"
	    ) || return
	    do_echo "spdx-sbom:" "${pkg_license_dir}/spdx-sbom.json"
	    do_echo "cyclonedx-sbom:" "${pkg_license_dir}/cyclonedx-sbom.json"
	fi
    else
	# license files have not been extracted, so just add the string from the rule
	do_list "license-files:" "${pkg_license_files}"
    fi
    if [ "${1}" != "fast" -a -e "${pkg_xpkg_map}" ]; then
	echo "ipkgs:"
	for xpkg in $(< "${pkg_xpkg_map}"); do
	    echo "- '${ptx_pkg_dir}/${xpkg}_${pkg_version}_${PTXDIST_IPKG_ARCH_STRING}.ipk'"
	done
    fi
    do_echo "image:" "${image_image}"
    do_list "pkgs:" "${image_pkgs}"
    do_list "files:" "${image_files}"
}
export -f ptxd_make_world_report_yaml

ptxd_make_world_fast_report() {
    declare -A pkg_license_flags
    ptxd_make_world_license_init || return

    local -a pkg_license_texts
    local -a pkg_license_texts_guessed

    mkdir -p "${ptx_report_dir}/fast" &&
    ptxd_make_world_report_yaml fast > "${ptx_report_dir}/fast/${pkg_label}.yaml"
}
export -f ptxd_make_world_fast_report

ptxd_make_image_reports() {
    local generate_report report
    local -a verbose

    ptxd_make_image_init || return

    ptxd_in_path PTXDIST_PATH_SCRIPTS generate-report.py &&
    generate_report="${ptxd_reply}" &&

    if [ "${PTXDIST_VERBOSE}" = "1" ]; then
	verbose=( --verbose )
    fi

    for report in ${image_reports}; do
	ptxd_eval \
	    pkg_stamp= \
	    PYTHONUNBUFFERED=1 \
	    "${generate_report}" \
	    "${verbose[@]}" \
	    --path "${PTXDIST_PATH//://config/report:}" \
	    --template "${report}" \
	    --input "${ptx_release_dir}/full-bsp-report.yaml"  \
	    --output "${ptx_release_dir}/${pkg_pkg}-${report}" \
	    --env target="${pkg_pkg}" || return
    done
    echo
}
export -f ptxd_make_image_reports
