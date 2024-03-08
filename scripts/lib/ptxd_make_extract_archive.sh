#!/bin/bash

ptxd_make_extract_archive() {
    local archive="$1"
    local dest="$2"
    local src_filter="$3"
    local filter
    local -a args

    case "${archive}" in
	*gz)
	    filter="--gzip"
	    ;;
	*bz2)
	    filter="--bzip2"
	    ;;
	*lzma)
	    filter="--lzma"
	    ;;
	*xz)
	    filter="--xz"
	    ;;
	*lzop)
	    filter="--lzop"
	    ;;
	*tar|*tar.*)
	    # no filter or autodetect
	    ;;
	*zip)
	    unzip -q "${archive}" -d "${dest}"
	    return
	    ;;
	*)
	    cat >&2 <<EOF

Unknown format, cannot extract!

EOF
	    return 1
	    ;;
    esac

    if [ -n "${src_filter}" ]; then
	args=( "${src_filter}" )
    fi

    tar --wildcards -C "${dest}" "${filter}" -x -f "${archive}" "${args[@]}" || {
	cat >&2 <<EOF

error: extracting '${archive}' failed

EOF
	return 1
    }
}
export -f ptxd_make_extract_archive

