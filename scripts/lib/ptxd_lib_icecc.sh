#!/bin/bash
#
# Copyright (C) 2020 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# Check for defined icecc
# Check for a usefull icecc version and setup the host environment
#
ptxd_lib_setup_host_icecc() {
    local icecc_dir="${sysroot_host}/lib/icecc"

    if [ -z "${PTXDIST_ICECC}" ]; then
	return
    fi

    "${wrapper_dir}/real/gcc" --version > "${PTXDIST_TEMPDIR}/host-gcc-version" 2>&1
    if [ -d "${icecc_dir}/host" -a -f "${icecc_dir}/host-gcc-version" ]; then
	if ! diff -q "${PTXDIST_TEMPDIR}/host-gcc-version" "${icecc_dir}/host-gcc-version" >& /dev/null; then
	    rm -rf "${icecc_dir}/host" "${icecc_dir}/host-gcc-version" "${icecc_dir}/gcc"
	fi
    fi
    if [ ! -d "${icecc_dir}/host" ]; then
	if ! "${PTXDIST_ICECC}" --version | grep -q 'ICECC 1\.'; then
	    ptxd_bailout "PTXdist only supports icecc 1.x"
	fi
	mkdir -p "${icecc_dir}/host" &&
	(
	    echo "Creating icecc host environment..."
	    if file -L "${wrapper_dir}/real/gcc" | grep script; then
		ptxd_bailout "'$(readlink "${wrapper_dir}/real/gcc")' must not be a script if icecc is used!"
	    fi
	    cd "${icecc_dir}/host"
	    local -a args
	    if [ -e "${wrapper_dir}/real/clang" ]; then
		args[${#args[@]}]="--clang"
		args[${#args[@]}]="${wrapper_dir}/real/clang"
	    fi
	    "${PTXDIST_ICECC_CREATE_ENV}" --gcc \
		"${wrapper_dir}/real/gcc" \
		"${wrapper_dir}/real/g++" \
		"${args[@]}" > "${PTXDIST_TEMPDIR}/icecc.log" 2>&1 || \
	    {
		cat "${PTXDIST_TEMPDIR}/icecc.log"
		ptxd_bailout "Failed to create icecc host environment!"
	    }
	    ln -s "$(readlink -f "${wrapper_dir}/real/gcc")" "${icecc_dir}/gcc"
	) &&
	mv "${PTXDIST_TEMPDIR}/host-gcc-version" "${icecc_dir}/"
    fi &&

    ptxd_get_path "${icecc_dir}/host"/*.tar.gz &&
    if tar -tf "${ptxd_reply}" | grep -q clang; then
	export PTXDIST_ICECC_HOST_CLANG=1
    fi

    export PTXDIST_ICECC_DIR="${icecc_dir}" &&

    if "${PTXDIST_ICECC}" --help | grep -q ICECC_REMOTE_CPP; then
	export PTXDIST_ICECC_REMOTE_CPP=1
    fi
}
export -f ptxd_lib_setup_host_icecc

#
# Check for defined icecc
# Setup the host environment
#
ptxd_lib_setup_target_icecc() {
    local icecc_dir="${sysroot_host}/lib/icecc"

    if [ -z "${PTXDIST_ICECC}" ]; then
	return
    fi
    if [ -z "${toolchain}" -o "$(readlink -f "${icecc_dir}/toolchain")" != "${toolchain}"  ]; then
	rm -rf "${icecc_dir}/target" "${icecc_dir}/target-gcc-version" "${icecc_dir}/toolchain"
    fi
    "${wrapper_dir}/real/${compiler_prefix}gcc"  --version > "${PTXDIST_TEMPDIR}/target-gcc-version" 2>&1
    if [ -d "${icecc_dir}/target" -a -f "${icecc_dir}/host-gcc-version" ]; then
	if ! diff -q "${PTXDIST_TEMPDIR}/target-gcc-version"  "${icecc_dir}/target-gcc-version" >& /dev/null; then
	rm -rf "${icecc_dir}/target" "${icecc_dir}/target-gcc-version" "${icecc_dir}/toolchain"
	fi
    fi
    if [ ! -d "${icecc_dir}/target" ]; then
	mkdir -p "${icecc_dir}/target" &&
	(
	    echo "Creating icecc target environment..."
	    cd "${icecc_dir}/target"
	    local -a args
	    local gxx
	    if [ -e "${wrapper_dir}/real/${compiler_prefix}g++" ]; then
		gxx="${wrapper_dir}/real/${compiler_prefix}g++"
	    else
		gxx="/bin/false"
	    fi
	    if [ -e "${wrapper_dir}/real/${compiler_prefix}clang" ]; then
		args[${#args[@]}]="--clang"
		args[${#args[@]}]="${wrapper_dir}/real/${compiler_prefix}clang"
	    fi
	    "${PTXDIST_ICECC_CREATE_ENV}" --gcc \
		"${wrapper_dir}/real/${compiler_prefix}gcc" "${gxx}" \
		    "${args[@]}" > "${PTXDIST_TEMPDIR}/icecc.log" 2>&1 || \
	    {
		cat "${PTXDIST_TEMPDIR}/icecc.log"
		ptxd_bailout "Failed to create icecc target environment!"
	    }
	    if [ ${#args[*]} -gt 0 ]; then
		tar --strip-components=2 -xf *.tar.gz usr/bin/as &&
		./as --verbose --version > env.log 2>&1 &&
		${compiler_prefix}as --verbose --version > real.log 2>&1
		if ! cmp -s env.log real.log; then
		    echo "Broken icecc-create-env, disabling icecc clang support!"
		    rm *.tar.gz
		    "${PTXDIST_ICECC_CREATE_ENV}" --gcc \
			"${wrapper_dir}/real/${compiler_prefix}gcc" "${gxx}" > \
			    "${PTXDIST_TEMPDIR}/icecc.log" 2>&1 || \
		    {
			cat "${PTXDIST_TEMPDIR}/icecc.log"
			ptxd_bailout "Failed to create icecc target environment!"
		    }
		fi
		rm as env.log real.log
	    fi
	    ln -s "${toolchain}" "${icecc_dir}/toolchain"
	) &&
	mv "${PTXDIST_TEMPDIR}/target-gcc-version" "${icecc_dir}/"
    fi &&

    ptxd_get_path "${icecc_dir}/target"/*.tar.gz &&
    if tar -tf "${ptxd_reply}" | grep -q clang; then
	export PTXDIST_ICECC_CLANG=1
    fi
}
export -f ptxd_lib_setup_target_icecc
