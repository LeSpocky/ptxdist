#!/bin/bash
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_world_compile_commands_parse_single() {
    local IFS arg output input compile_only
    local -a inputs

    set -- ${command}
    while [ "${#}" -gt 0 ]; do
	arg="${1}"
	shift
	case "${arg}" in
	    -o)
		if [ "${1}" = "/dev/null" ]; then
		    # ignore compiler checks etc.
		    return
		fi
		if [[ "${1}" =~ ^/ ]]; then
		    output="${1}"
		else
		    output="${directory}/${1}"
		fi
		if [ ! -f "${output}" ]; then
		    # probably a temporary file for some kind of check
		    return
		fi
		shift
		;;
	    *.c|*.cc|*.cp|*.cxx|*.cpp|*.CPP|*.c++|*.C|*.s|*.S|*.sx)
		if [[ "${arg}" =~ ^/ ]]; then
		    input="${arg}"
		else
		    input="${directory}/${arg}"
		fi
		if [ ! -f "${input}" ]; then
		    # probably a temporary file for some kind of check
		    return
		fi
		inputs+=( "${input}" )
		;;
	    -c)
		compile_only=1
		;;
	    -)
		return
		;;
	esac
    done
    if [ -z "${output}" -a -n "${compile_only}" -a "${#inputs[*]}" -eq 1 ]; then
	# derive the output file-name from the input file-name if possible
	output="${inputs[0]%.*}.o"
    fi
    if [ -z "${compile_only}" -a "${#inputs[*]}" -eq 0 ]; then
	# just linking
	return
    fi
    if [ -z "${output}" -o "${#inputs[*]}" -eq 0 ]; then
	return 1
    fi
    for input in "${inputs[@]}"; do
	output_file="${ptxdist_compile_commands_dir}/${input//\//_}.json"
	printf '  {
    "directory": "%s",
    "command": "%s",
    "file": "%s",
    "output": "%s"
  }' "${directory}" "${command//\"/\\\"}" "${input}" "${output}" > "${output_file}"
    done
}
export -f ptxd_make_world_compile_commands_parse_single

ptxd_make_world_compile_commands_kconfig() {
    local generator fixup_dir

    if [ "${pkg_build_tool}" = "kconfig" ]; then
	generator="${pkg_dir}/scripts/clang-tools/gen_compile_commands.py"
    elif [[ " ${pkg_build_deps} " =~ ' kernel ' ]]; then
	set -- ${pkg_make_opt}
	while [ $# -gt 0 ]; do
	    opt="$1"
	    shift
	    case "${opt}" in
		O=*)
		    fixup_dir="${opt#O=}"
		    ;;
		-C)
		    generator="${1}/scripts/clang-tools/gen_compile_commands.py"
		    shift
		    ;;
	    esac
	done
	if [ -z "${fixup_dir}" ]; then
	    return
	fi
    fi
    if [ ! -x "${generator}" ]; then
	return
    fi

    # fake dependency for python wrapper
    pkg_build_deps=host-system-python3 \
    "${generator}" \
	-d "${pkg_build_dir}" -o "${pkg_build_dir}/compile_commands.json"
    if [ $? -ne 0 ]; then
	ptxd_warning "Ignoring failed scripts/clang-tools/gen_compile_commands.py"
    else
	if [ -d "${fixup_dir}" ]; then
	    # gen_compile_commands.py sets the wrong directory for external kernel
	    # modules. It must be the kernel build tree, so fix this here
	    sed -i "s;\(\"directory\":\).*;\1 \"${fixup_dir}\",;" "${pkg_build_dir}/compile_commands.json"
	fi &&
	ptxd_make_world_compile_commands_filter
    fi
}
export -f ptxd_make_world_compile_commands_kconfig

ptxd_make_world_compile_finish() {
    ptxd_make_world_compile_commands_kconfig &&

    if [ -n "${PTXDIST_COMPILE_COMMANDS}" -a -e "${PTXDIST_COMPILE_COMMANDS}" ]; then
	local ptxdist_compile_commands_dir="${pkg_build_dir}/.ptxdist-compile-commands-cache"
	local orig_IFS="${IFS}"
	IFS="$(echo -e "\x1F")"

	mkdir -p "${ptxdist_compile_commands_dir}" &&
	exec {data}< "${PTXDIST_COMPILE_COMMANDS}" &&
	while read directory command  <&${data}; do
	    if ! ptxd_make_world_compile_commands_parse_single; then
		echo "${command}" >> "${PTXDIST_COMPILE_COMMANDS}.failed"
	    fi
	done &&
	rm "${PTXDIST_COMPILE_COMMANDS}" &&
	IFS="${orig_IFS}" &&
	exec {data}<&- &&
	{
	    find "${ptxdist_compile_commands_dir}" -name "*.json" | awk '
		BEGIN {
		    print "["
		}
		function dump(file) {
		    old_RS = RS
		    RS = "^$"
		    getline tmp < file
		    RS = old_RS
		    close(src)
		    printf "%s", tmp
		}
		{
		    if (start > 0)
			print ","
		    start = 1
		    dump($0)
		}
		END {
		    print "\n]"
		}'
	} > "${pkg_dir}/compile_commands.json" &&
	ptxd_make_world_compile_commands_cleanup
    fi
}
export -f ptxd_make_world_compile_finish

ptxd_make_world_compile_python() {
    if [ -e "${pkg_dir}/pyproject.toml" -a ! -e "${pkg_dir}/setup.py" ] && \
	    ( [[ "${pkg_label}" =~ host-.*python3-flit-core ]] ||
	    [[ " ${pkg_build_deps} " =~ ' host-python3-flit-core ' && ! "${pkg_label}" =~ ^host-system-python3- ]] ||
	    [[ " ${pkg_build_deps} " =~ ' host-system-python3-flit-core ' && "${pkg_label}" =~ ^host-system-python3- ]] ) ; then
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
	    ( [[ " ${pkg_build_deps} " =~ ' host-python3-pybuild ' ]] ||
	    [[ " ${pkg_build_deps} " =~ ' host-system-python3-pybuild ' ]] ) ; then
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
    elif [ -e "${pkg_dir}/pyproject.toml" -a ! -e "${pkg_dir}/setup.py" ]; then
	ptxd_bailout "Missing Python build dependency!" \
		     "${pkg_label} probably needs to select HOST_PYTHON3_PYBUILD"
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
    case "${pkg_conf_tool}" in
	cmake|meson|kconfig)
	    ;;
	*)
	    export PTXDIST_COMPILE_COMMANDS="${pkg_build_dir}/.ptxdist-compile-commands"
	    ;;
    esac &&
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
