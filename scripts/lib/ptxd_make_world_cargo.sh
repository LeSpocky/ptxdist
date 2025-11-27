#!/bin/bash
#
# Copyright (C) 2021 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_world_cargo_sync_parse() {
    awk '
BEGIN {
    FS=" = "
    name=""
    version=""
    url=""
    source=""
}
function dump() {
    if (name && version && source)
	print name, version, url
    name=""
    version=""
    url=""
    source=""
}
/[[package]]/ {
    dump()
}
$1 == "name" {
    name=substr($2, 2, length($2)-2)
}
$1 == "version" {
    version=substr($2, 2, length($2)-2)
}

$1 == "source" {
    source=$2
}

/^source = "git\+http/ {
    url=gensub(/source = "(git\+http[s]?:\/\/[^\?]*)(\?.*)?#(.*)"/, "\\1 \\3", 1, $0)
}

END {
    dump()
}
' "${1}"
}
export -f ptxd_make_world_cargo_sync_parse

ptxd_make_world_cargo_sync_package() {
    local path PACKAGE ORIG_PACKAGE extra

    if [ -z "${url}" ]; then
	url="https://crates.io/api/v1/crates/${package}/${version}/download"
    else
	package="${url##*/}"
	package="${package%%.git}"
	if [ "${workspaces[${hash}]}" = "${package}" ]; then
	    echo "Skipping duplicate entry for ${package}."
	    return
	fi
	workspaces[${hash}]="${package}"
	url="${url};tag=${hash}"
    fi
    PACKAGE="$(tr '[a-z]' '[A-Z]' <<< "${package}-${version}" | tr -sc '[:alnum:]' '_')"
    PACKAGE="${PACKAGE%_}"
    # the same package/version can exist multiple times with different commits
    ORIG_PACKAGE="${PACKAGE}"
    while [[ " ${packages} " =~ " ${PACKAGE} " ]]; do
	extra="$((extra+1))"
	PACKAGE="${ORIG_PACKAGE}_"${extra}
    done
    packages+=" ${PACKAGE}"
    if [[ "${url}" =~ ^git ]]; then
	path="${PTXDIST_SRCDIR}/${package}-${version}+${hash:0:12}.git.crate"
    else
	path="${PTXDIST_SRCDIR}/${package}-${version}.crate"
    fi

    echo "Processing ${package} ${version} ..."
    if [ ! -e "${path}" ]; then
	echo "Downloading ${url} ..."
	echo
	ptxd_make_get "${path}" "${url}"
    fi
    set -- $(md5sum "${path}")
    md5="${1}"
    cat << EOF >&${makefilefd}
${PKG}_${PACKAGE}_MD5		:= ${md5}
${PKG}_${PACKAGE}_URL		:= ${url}
${PKG}_${PACKAGE}_SOURCE	:= \$(SRCDIR)${path#${PTXDIST_SRCDIR}}
${PKG}_PARTS			+= ${PKG}_${PACKAGE}

EOF
}
export -f ptxd_make_world_cargo_sync_package

ptxd_make_world_cargo_sync() {
    local pkg_makefile_cargo package version cargofd packages cargo_lock cargo_lock_md5
    local PKG
    local -a tmp
    local -A workspaces

    ptxd_make_world_init || return

    if [ ! -e "${pkg_makefile}" ]; then
	ptxd_bailout "Missing rule file for '${pkg_label}'"
    fi
    pkg_makefile_cargo="${pkg_makefile%.make}.cargo.make"
    PKG="$(tr "[a-z-]" "[A-Z_]" <<< "${pkg_label}")"

    cd -- "${pkg_dir}" &&
    exec {makefilefd}> "${pkg_makefile_cargo}"
    # copy the copyright header from the package rule file
    sed '/^\([^#]\|$\)/Q' ${pkg_makefile} >&${makefilefd}

    for cargo_lock in "${pkg_cargo_lock[@]}"; do
	read -r -a tmp < <(md5sum "${cargo_lock}")
	cargo_lock_md5+="${cargo_lock_md5:+ }${tmp[0]}"
    done
    cat << EOF >&${makefilefd}

#
# WARNING: This file is generated with 'ptxdist cargosync ${pkg_label}' and
# should not be modified manually!
#

${PKG}_CARGO_LOCK_MD5 := ${cargo_lock_md5}

EOF

    for cargo_lock in "${pkg_cargo_lock[@]}"; do
	echo -e "\nReading ${cargo_lock}...\n"
	exec {cargofd}< <(ptxd_make_world_cargo_sync_parse "${cargo_lock}") &&
	while read package version url hash <&${cargofd}; do
	    if [ "${package}" = "${pkg_label}" ]; then
		continue
	    fi
	    if [ -z "${version}" ]; then
		ptxd_bailout "${tmp[*]}"
	    fi
	    ptxd_make_world_cargo_sync_package
	done
	exec {cargofd}<&-
    done

    cat << EOF >&${makefilefd}

# vim: syntax=make
EOF
    exec {makefilefd}<&-
}
export -f ptxd_make_world_cargo_sync

# vim: syntax=bash
