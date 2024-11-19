#!/bin/bash
#
# Copyright (C) 2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# ptxd_make_world_extract
#
ptxd_make_world_extract_impl() {
    ptxd_make_world_init || return

    if [ -z "${pkg_url}" -a -z "${pkg_src}" -o -z "${pkg_dir}" ]; then
	# no <PKG>_URL and no <PKG>_SOURCE or no <PKG>_DIR -> assume the package has nothing to extract.
	return
    fi

    case "${pkg_url}" in
	lndir://*)
	    local url="$(ptxd_file_url_path "${pkg_url}")"
	    if [ -n "${pkg_src}" ]; then
		ptxd_bailout "<PKG>_SOURCE must not be defined when using a lndir:// URL!"
	    fi
	    if [ -d "${url}" ]; then
		echo "local directory using lndir"
		mkdir -p "${pkg_dir}"
		lndir "$(ptxd_abspath "${url}")" "${pkg_dir}"
		rm -f "${pkg_dir}/compile_commands.json"
		return
	    else
		ptxd_bailout "the URL '${pkg_url}' points to non existing directory."
	    fi
	    ;;
	file://*)
	    local url="$(ptxd_file_url_path "${pkg_url}")"
	    if [ -d "${url}" ]; then
		echo "local directory instead of tar file, linking build dir"
		ln -sf "$(ptxd_abspath "${url}")" "${pkg_dir}"
		return
	    elif [ -f "${url}" ]; then
		echo
		echo "Using local archive"
		echo
		pkg_src="${url}"
	    else
		ptxd_bailout "the URL '${pkg_url}' points to non existing directory or file."
	    fi
	    ;;
    esac

    mkdir -p "$(dirname "${pkg_dir}")" || return

    ptxd_make_serialize_take
    echo "\
extract: pkg_src=$(ptxd_print_path ${pkg_src})
extract: pkg_dir=$(ptxd_print_path ${pkg_dir})"

    local tmpdir
    tmpdir="$(mktemp -d "${pkg_dir}.XXXXXX")"
    if ! ptxd_make_extract_archive "${pkg_src}" "${tmpdir}" "${pkg_src_filter}"; then
	rm -rf "${tmpdir}"
	ptxd_make_serialize_put
	ptxd_bailout "failed to extract '${pkg_src}'."
    fi
    local depth=$[${pkg_strip_level:=1}+1]
    if [ -e "${pkg_dir}" ]; then
	tar -C "$(dirname "${tmpdir}")" --remove-files -c "$(basename "${tmpdir}")" | \
	    tar -x --strip-components=${depth} -C "${pkg_dir}"
	check_pipe_status
    else
	mkdir -p "${pkg_dir}" &&
	find "${tmpdir}" -mindepth ${depth} -maxdepth ${depth} -print0 | \
	    xargs -0 mv -t "${pkg_dir}"
	check_pipe_status
    fi
    local ret=$?
    rm -rf "${tmpdir}"
    ptxd_make_serialize_put
    return ${ret}
}
export -f ptxd_make_world_extract_impl

ptxd_make_world_extract_cargo_crate() {
    local tmp srcdir abs_srcdir dir name

    echo "extract: ${src}"
    tmp="$(basename ${src%.crate})"
    srcdir="${tmp%.git}"
    abs_srcdir="${pkg_cargo_home}/source/${srcdir}"
    mkdir "${abs_srcdir}" &&
    tar -C "${abs_srcdir}" --strip-components=1 -xf "${src}" || break
    if grep -qi '^\[package\]$' "${abs_srcdir}/Cargo.toml"; then
	if [ "${tmp}" = "${srcdir}" ]; then
	    # don't set the checksum for crates from git, they would trigger Cargo.lock changes
	    set -- $(sha256sum "${src}")
	    printf '{"files": {}, "package": "%s"}' "${1}" > "${abs_srcdir}/.cargo-checksum.json"
	else
	    printf '{"files": {}, "package": null}' > "${abs_srcdir}/.cargo-checksum.json"
	fi
	return
    fi
    mv "${abs_srcdir}" "${pkg_cargo_home}/workspaces/" &&
    awk '
/^members = \[$/ {
    members = 1
    next
}
/\]$/ {
    members = 0
}
{
    if (members != 1)
	next
	dir = gensub(/"(.*)"[,]?/, "\\1", 1, $1)
	name = gensub(/\//, "-", "g", dir)
	print dir, name
}' "${pkg_cargo_home}/workspaces/${srcdir}/Cargo.toml" | while read dir name; do
	ln -sf "../workspaces/${srcdir}/${dir}" "${pkg_cargo_home}/source/${name}"
	printf '{"files": {}, "package": null}' > "${pkg_cargo_home}/source/${name}/.cargo-checksum.json"
	mv "${pkg_cargo_home}/workspaces/${srcdir}/${dir}/Cargo.toml" \
	    "${pkg_cargo_home}/workspaces/${srcdir}/${dir}/Cargo.toml.orig"
	"${vendor_cargo_workspace_package}" \
	    --input "${pkg_cargo_home}/workspaces/${srcdir}/${dir}/Cargo.toml.orig" \
	    --output "${pkg_cargo_home}/workspaces/${srcdir}/${dir}/Cargo.toml" \
	    --workspace "${pkg_cargo_home}/workspaces/${srcdir}/Cargo.toml" || return
    done
}
export -f ptxd_make_world_extract_cargo_crate

ptxd_make_world_extract_cargo() {
    local src vendor_cargo_workspace_package
    echo "extract: cargo dependencies:"
    ptxd_in_path PTXDIST_PATH_SCRIPTS vendor-cargo-workspace-package &&
    vendor_cargo_workspace_package="${ptxd_reply}" &&
    rm -rf "${pkg_cargo_home}" &&
    mkdir -p "${pkg_cargo_home}/source" &&
    mkdir -p "${pkg_cargo_home}/workspaces" &&
    for src in ${pkg_srcs}; do
	case "${src}" in
	*.crate)
	    ptxd_make_world_extract_cargo_crate || return
	    ;;
	*)
	    ;;
	esac
    done
}
export -f ptxd_make_world_extract_cargo

ptxd_make_world_extract() {
    ptxd_make_world_extract_impl &&
    if [ "${pkg_conf_tool}" = "cargo" -o -n "${pkg_cargo_lock}" ]; then
	ptxd_make_world_extract_cargo
    fi
}
export -f ptxd_make_world_extract
