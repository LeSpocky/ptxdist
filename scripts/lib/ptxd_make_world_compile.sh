#!/bin/bash
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_world_compile_finish() {
    if [ "${pkg_build_tool}" = "kconfig" ]; then
	if [ -x "${pkg_dir}/scripts/clang-tools/gen_compile_commands.py" ]; then
	    # fake dependency for python wrapper
	    pkg_build_deps=host-system-python3 \
	    "${pkg_dir}/scripts/clang-tools/gen_compile_commands.py" \
		-d "${pkg_build_dir}" -o "${pkg_build_dir}/compile_commands.json"
	    if [ $? -ne 0 ]; then
		ptxd_warning "Ignoring failed scripts/clang-tools/gen_compile_commands.py"
	    else
		ptxd_make_world_compile_commands_filter
	    fi
	fi
    fi
}
export -f ptxd_make_world_compile_finish

ptxd_make_world_compile_python() {
    if [ -e "${pkg_dir}/pyproject.toml" -a ! -e "${pkg_dir}/setup.py" ] && \
	    ! [[ " ${pkg_build_deps_all} " =~ ' host-python3-pybuild ' ]]; then
	ptxd_eval \
	    cd "${pkg_build_dir}" '&&' \
	    "${pkg_path}" \
	    "${pkg_env}" \
	    "${pkg_make_env}" \
	    "${ptx_build_python}" \
	    -m flit_core.wheel \
	    --outdir "${pkg_build_dir}" \
	    "${pkg_dir}"
    elif [ -e "${pkg_dir}/pyproject.toml" ] &&
	    [[ " ${pkg_build_deps} " =~ ' host-python3-pybuild ' ]]; then
	ptxd_eval \
	    cd "${pkg_build_dir}" '&&' \
	    "${pkg_path}" \
	    "${pkg_env}" \
	    "${pkg_make_env}" \
	    "${ptx_build_python}" \
	    -m build \
	    --skip-dependency-check \
	    --wheel \
	    --no-isolation \
	    --outdir "${pkg_build_dir}" \
	    "${pkg_dir}"
    else
	ptxd_eval \
	    cd "${pkg_build_dir}" '&&' \
	    "${pkg_path}" \
	    "${pkg_env}" \
	    "${pkg_make_env}" \
	    "${ptx_build_python}" \
	    setup.py \
	    "${pkg_make_opt}" \
	    "${pkg_make_par}"
    fi
}
export -f ptxd_make_world_compile_python

#
# call the compiler
#
ptxd_make_world_compile() {
    ptxd_make_world_init &&

    if [ -z "${pkg_build_dir}" ]; then
	# no build dir -> assume the package has nothing to build.
	return
    fi &&
    case "${pkg_build_tool}" in
	python*)
	(
	ptxd_make_world_compile_python
	)
	;;
	ninja)
	ptxd_eval \
	    "${pkg_path}" \
	    "${pkg_env}" \
	    "${pkg_make_env}" \
	    ninja -C "${pkg_build_dir}" \
	    "${pkg_make_opt}" \
	    "${pkg_make_par}"
	;;
	scons)
	ptxd_eval \
	    "${pkg_path}" \
	    "${pkg_env}" \
	    "${pkg_make_env}" \
	    scons -C "${pkg_build_dir}" \
	    "${pkg_make_opt}" \
	    "${pkg_make_par}"
	;;
	cargo)
	ptxd_eval \
	    cd "${pkg_build_dir}" '&&' \
	    "${pkg_path}" \
	    "${pkg_env}" \
	    "${pkg_make_env}" \
	    cargo \
	    "${pkg_make_opt}" \
	    "${pkg_make_par}"
	;;
	*)
	ptxd_eval \
	    "${pkg_path}" \
	    "${pkg_env}" \
	    "${pkg_make_env}" \
	    "${MAKE}" -C "${pkg_build_dir}" \
	    "${pkg_make_opt}" \
	    "${pkg_make_par}"
	;;
    esac &&
    ptxd_make_world_compile_finish
}
export -f ptxd_make_world_compile
