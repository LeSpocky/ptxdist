#!/bin/bash
#
# Copyright (C) 2019 Sascha Hauer <s.hauer@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# ptxd_make_imx_habv4_gen_table - generate the srk fuse file and srk table for i.MX HABv4
#
# usage: ptxd_make_imx_habv4_gen_table <template>
#
# template: the role template to access the keys. Must contain a "%d" which is
#           used as index
#
# The output files are generated in the package build dir:
#
# imx-srk-table.bin: The output srk table binary file.
#     Needed by the CST tool to sign images.
#
# imx-srk-fuse.bin:  The output srk fuse file.
#     This will contain the srk hash which must be written to the fuses
#
ptxd_make_imx_habv4_gen_table_impl() {
    local template="${1}"
    local table_bin="${pkg_build_dir}/imx-srk-table.bin"
    local srk_fuse_bin="${pkg_build_dir}/imx-srk-fuse.bin"
    local -a certs

    echo -e "generating $(basename ${table_bin}) and $(basename ${srk_fuse_bin})\n"

    for i in 1 2 3 4; do
	certs[${#certs[*]}]="$(cs_get_ca "$(printf "${template}" ${i})")"
    done

    local orig_IFS="${IFS}"
    IFS=","
    certs="${certs[*]}"
    IFS="${orig_IFS}"

    ptxd_exec srktool --hab_ver 4 \
	--table "${table_bin}" \
	--efuses "${srk_fuse_bin}" \
	--digest sha256 \
	--certs "${certs}"
}
export -f ptxd_make_imx_habv4_gen_table_impl

ptxd_make_imx_habv4_gen_table() {
    ptxd_make_world_init &&

    ptxd_eval \
	"${pkg_make_env}" \
	ptxd_make_imx_habv4_gen_table_impl "${@}"
}
export -f ptxd_make_imx_habv4_gen_table
