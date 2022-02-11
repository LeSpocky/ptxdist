#!/bin/bash
#
# Copyright (C) 2020 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_dtb() {
    local dtc dts tmp_dts dtb dtb_extra_args dtb_kernel_dir deps tmp_deps

    dts="${dtb_source}"
    dtb="${dtb_target}"

    dtb_kernel_dir="${pkg_kernel_dir:-${pkg_dir}}"
    dtb_kernel_build_dir="${pkg_kernel_build_dir:-${pkg_build_dir}}"

    dtc="${dtb_kernel_build_dir}/scripts/dtc/dtc"
    if [ ! -x "${dtc}" ]; then
	dtc=dtc
    fi

    if [ "$(ptxd_get_ptxconf PTXCONF_KERNEL_DTS_SUPPORT_OVERLAYS)" == "y" ]; then
	dtb_extra_args="-@"
    fi

    tmp_dts="${ptx_state_dir}/${pkg_label}.$(basename "${dts}").tmp"

    deps="${ptx_state_dir}/${pkg_label}.$(basename "${dts}").deps"
    tmp_deps="${PTXDIST_TEMPDIR}/${pkg_label}.$(basename "${dts}").deps"

    exec 2>&${PTXDIST_FD_LOGERR}

    echo "CPP $(ptxd_print_path "${dts}")" &&
    ptxd_eval \
	cpp \
	-Wp,-MMD,${tmp_deps} \
	-Wp,-MT,${dtb_deps_target} \
	-nostdinc \
	-I"$(dirname "${dts}")" \
	-I${dtb_kernel_dir}/arch/${pkg_arch}/boot/dts \
	-I${dtb_kernel_dir}/arch/${pkg_arch}/boot/dts/include \
	-I${dtb_kernel_dir}/scripts/dtc/include-prefixes \
	-I${dtb_kernel_dir}/drivers/of/testcase-data \
	-I${dtb_kernel_dir}/include \
	-undef -D__DTS__ -x assembler-with-cpp \
	-o ${tmp_dts} \
	${dts} &&

    sed -e "\;^ ${dtb_kernel_dir}[^ ]*;d" \
	-e 's;^ \([^ \]*\); $(wildcard \1);' "${tmp_deps}" > "${deps}" &&
    # empty line in case all dependencies were removed
    echo >> "${deps}" &&

    mkdir -p "$(dirname "${dtb}")" &&
    echo "DTC $(ptxd_print_path "${dtb}")" &&
    ptxd_eval \
	"${dtc}" \
	"${dtb_extra_args}" \
	-i "$(dirname "${dts}")" \
	-i "${dtb_kernel_dir}/arch/${pkg_arch}/boot/dts" \
	-d "${tmp_deps}" \
	-I dts -O dtb -b 0 \
	-o "${dtb}" "${tmp_dts}" &&

    awk "{ \
	    s = \"\"; \
	    for (i = 2; i <= NF; i++) { \
		if (\$i != \"${tmp_dts}\")
		    s = s \" \$(wildcard \" \$i \")\"; \
	    }; \
	    if (s != \""\"") {
		printf \"${dtb_deps_target}:\" s;  \
		print \"\"; \
	    } \
	}" "${tmp_deps}" >> "${deps}" ||

    ptxd_bailout "Unable to generate dtb file."
}
export -f ptxd_make_dtb


ptxd_make_world_dtbo() {
    local dtb_deps_target dtb_source dtb_target

    ptxd_make_world_init || break

    dtb_deps_target="${ptx_state_dir}/${pkg_stamp}"

    echo -e "\nBuilding device tree overlays..."

    for overlay in ${pkg_dtso}; do
	if [[ "${overlay}" =~ ^/.* ]]; then
	    ptxd_bailout "'${overlay}' must not be an absolute path!" \
			 "Use <PKG>_DTSO_PATH to specify the search path."
	fi

	if ! ptxd_in_path pkg_dtso_path "${overlay}"; then
	    ptxd_bailout "Overlay '${overlay}' not found in '${pkg_dtso_path}'."
	fi
	dtb_source="${ptxd_reply}"
	dtb_target="${pkg_pkg_dir}/${pkg_dtbo_dir}/$(basename ${overlay/%.dts*/.dtbo})"

	ptxd_make_dtb || break
    done
}
export -f ptxd_make_world_dtbo


ptxd_make_world_dtb() {
    local dtb_deps_target dtb_source dtb_target

    ptxd_make_world_init || break

    dtb_deps_target="${ptx_state_dir}/${pkg_stamp}"

    echo -e "\nBuilding device trees..."

    for dts_dts in ${pkg_dts}; do
	if [[ "${dts_dts}" =~ ^/.* ]]; then
	    ptxd_bailout "'${dts_dts}' must not be an absolute path!" \
			 "Use <PKG>_DTS_PATH to specify the search path."
	fi

	if ! ptxd_in_path pkg_dts_path "${dts_dts}"; then
	    ptxd_bailout "Device tree '${dts_dts}' not found in '${pkg_dts_path}'."
	fi
	dtb_source="${ptxd_reply}"
	dtb_target="${pkg_pkg_dir}/boot/$(basename ${dts_dts/%.dts/.dtb})"

	ptxd_make_dtb || break
    done
}
export -f ptxd_make_world_dtb
