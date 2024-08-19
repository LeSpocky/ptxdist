#!/bin/bash
#
# Copyright (C) 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_get_need_commit() {
    if [ -e "${path}.commit" ]; then
	return 1
    fi
    if [ "$(ptxd_get_ptxconf PTXCONF_PROJECT_STORE_SOURCE_GIT_COMMITS)" != "y" ]; then
	return 1
    fi
}
export -f ptxd_make_get_need_commit

#
# in env:
#
# ${path}	: local file name
# ${url}	: the url to download
# ${opts[]}	: an array of options
#
ptxd_make_get_http() {
    local -a curl_opts
    local temp_file temp_header repo tag tmp
    set -- "${opts[@]}"
    unset opts

    #
    # scan for valid options
    #
    while [ ${#} -ne 0 ]; do
	local opt="${1}"
	shift

	case "${opt}" in
	    no-check-certificate)
		opts[${#opts[@]}]="--${opt}"
		curl_opts[${#curl_opts[@]}]="--insecure"
		;;
	    no-proxy)
		opts[${#opts[@]}]="--${opt}"
		curl_opts[${#curl_opts[@]}]="--noproxy"
		curl_opts[${#curl_opts[@]}]="*"
		;;
	    cookie:*)
		opts[${#opts[@]}]="--no-cookies"
		opts[${#opts[@]}]="--header"
		opts[${#opts[@]}]="Cookie: ${opt#cookie:}"
		curl_opts[${#curl_opts[@]}]="--cookie"
		curl_opts[${#curl_opts[@]}]="${opt#cookie:}"
		;;
	    *)
		ptxd_bailout "invalid option '${opt}' to ${FUNCNAME}"
		;;
	esac
    done
    unset opt

    #
    # download to temporary file first, move it to correct
    # file name after successful download
    #
    local file="${url##*/}"

    # remove any pending or half downloaded files
    p="[a-zA-Z0-9]"
    rm -f -- "${path}."$p$p$p$p$p$p$p$p$p$p

    ptxd_make_serialize_take
    if [ "${ptxd_make_get_dryrun}" = "y" ]; then
	echo "Checking URL '${url}'..."
	temp_header="$(mktemp "${PTXDIST_TEMPDIR}/urlcheck.XXXXXX")" || ptxd_bailout "failed to create tempfile"
	curl \
	--connect-timeout 30 \
	--retry 5 \
	--user-agent "PTXdist ${PTXDIST_VERSION_FULL}" \
	"${curl_opts[@]}" \
	-o /dev/null \
	--dump-header "${temp_header}" \
	--fail \
	--location \
	--head \
	--request GET \
	--write-out '\n%{url_effective}\n' \
	"${url}" &&
	if sed -n -r '/200 OK/,/content-type/I s/content-type:/\0/pI' "${temp_header}" | grep -q "text/html"; then
	    ptxd_bailout "Got HTML file"
	fi
	ptxd_make_serialize_put
	return
    elif [ ! -e "${path}" ]; then
	temp_file="$(mktemp "${path}.XXXXXXXXXX")" || ptxd_bailout "failed to create tempfile"
	if [ "${PTXDIST_VERBOSE}" == "1" ]; then
		if wget --version | grep "GNU Wget2"; then
		    progress=none
		fi
	elif [ -n "${PTXDIST_QUIET}" ]; then
	    progress=dot
	else
	    progress=bar:force
	fi
	wget \
	--progress="${progress}" \
	--timeout=30 \
	--tries=5 \
	--user-agent="PTXdist ${PTXDIST_VERSION_FULL}" \
	"${opts[@]}" \
	-O "${temp_file}" \
	"${url}" || {
	    ptxd_make_serialize_put
	    rm -f -- "${temp_file}"
	    return 1
	}
	chmod 644 -- "${temp_file}" &&
	if file "${temp_file}" | grep -q " HTML "; then
	    ptxd_warning "Got HTML file"
	    echo
	    return 1
	fi &&
	if [[ "${path}" =~ '.tar.'|'.zip'$ ]] && file "${temp_file}" | grep -q " ASCII text"; then
	    ptxd_warning "Got text file"
	    echo
	    return 1
	fi &&
	touch -- "${temp_file}" &&
	mv -- "${temp_file}" "${path}"
    fi
    ptxd_make_serialize_put

    if ! ptxd_make_get_need_commit; then
	return
    fi
    case "${url}" in
	https://github.com/*/*/archive/*)
	    repo=${url%%/archive/*}
	    tag=${url##*/}
	    tag=${tag%.tar.gz}
	    tag=${tag%.zip}
	    ;;
	https://github.com/*/*/releases/download/*)
	    repo=${url%%/releases/download/*}
	    tag=${url##*/releases/download/}
	    tag=${tag%%/*}
	    ;;
	https://*gitlab*/*/*/-/archive/*)
	    repo=${url%%/-/archive/*}
	    tag=${url##*/-/archive/}
	    tag=${tag%%/*}
	    ;;
	https://*gitlab*/*/*/-/releases/*)
	    repo=${url%%/-/releases/*}
	    tag=${url##*/-/releases/}
	    tag=${tag%%/*}
	    ;;
    esac
    if [ -n "${repo}" -a -n "${tag}" ]; then
	# try to get the commit for an annotated tag first
	tmp="$(git ls-remote "${repo}" "refs/tags/${tag}^{}" 2>/dev/null | awk '{ print $1 }')"
	if [ -z "${tmp}" ]; then
	    tmp="$(git ls-remote --tags "${repo}" "refs/tags/${tag}" 2>/dev/null | awk '{ print $1 }')"
	fi
	if [ -n "${tmp}" ]; then
	    echo "${tmp%% *}" > "${path}.commit"
	fi
    fi
}
export -f ptxd_make_get_http


#
# in env:
#
# ${path}	: local file name
# ${url}	: the url to download
# ${opts[]}	: an array of options
#
ptxd_make_get_git() {
    set -- "${opts[@]}"
    unset opts
    local tag archive_args commit
    local mirror="${url#[a-z]*//}"
    mirror="$(dirname "${path}")/${mirror//\//.}"
    local prefix="$(basename "${path}")"
    prefix="${prefix%.tar.*}/"

    case "${path}" in
    *.tar.gz|*.tar.bz2|*.tar.xz|*.zip)
	;;
    *.crate)
	archive_args="--format=tar.gz"
	;;
    *)
	ptxd_bailout "Only .tar.gz, .tar.bz2, .tar.xz and .zip archives are supported for git downloads."
	;;
    esac

    #
    # scan for valid options
    #
    while [ ${#} -ne 0 ]; do
	local opt="${1}"
	shift

	case "${opt}" in
	    tag=*)
		tag="${opt#tag=}"
		;;
	    *)
		ptxd_bailout "invalid option '${opt}' to ${FUNCNAME}"
		;;
	esac
    done
    unset opt

    if [ -z "${tag}" ]; then
	ptxd_bailout "git url '${url}' has no 'tag' option"
    fi

    ptxd_make_serialize_take
    if [ "${ptxd_make_get_dryrun}" = "y" ]; then
	echo "Checking URL '${url}'..."
	git ls-remote --quiet "${url}" HEAD > /dev/null
	ptxd_make_serialize_put
	return
    elif [ ! -e "${path}" ]; then
	echo "${PROMPT}git: fetching '${url} into '${mirror}'..."
	if [ ! -d "${mirror}" ]; then
	    git init --bare --shared "${mirror}"
	else
	    git --git-dir="${mirror}" remote rm origin
	fi &&
	# overwrite everything so the git repository is in a defined state
	git --git-dir="${mirror}" config transfer.fsckObjects true &&
	git --git-dir="${mirror}" config tar.tar.gz.command "gzip -cn" &&
	git --git-dir="${mirror}" config tar.tar.bz2.command "bzip2 -c" &&
	git --git-dir="${mirror}" config tar.tar.xz.command "xz -c" &&
	git --git-dir="${mirror}" remote add origin "${url}" &&
	git --git-dir="${mirror}" fetch --progress -pf origin "+refs/*:refs/*"  &&
	# at least for some git versions this is not group writeable for shared repos
	if [ "$(stat -c '%A' "${mirror}/FETCH_HEAD" | cut -c 6)" != "w" ]; then
	    chmod g+w "${mirror}/FETCH_HEAD"
	fi &&

	if ! git --git-dir="${mirror}" rev-parse --verify -q "${tag}" > /dev/null; then
	    ptxd_make_serialize_put
	    ptxd_bailout "git: tag '${tag}' not found in '${url}'"
	fi &&

	git --git-dir="${mirror}" archive ${archive_args} --prefix="${prefix}" -o "${path}" "${tag}"
    fi
    ptxd_make_serialize_put
    if ! ptxd_make_get_need_commit; then
	set +x
	return
    fi
    if commit="$(git --git-dir="${mirror}" rev-parse "${tag}^{}" 2>/dev/null)"; then
	echo "${commit}" > "${path}.commit"
    fi
}
export -f ptxd_make_get_git


#
# in env:
#
# ${path}	: local file name
# ${url}	: the url to download
# ${opts[]}	: an array of options
#
ptxd_make_get_svn() {
    set -- "${opts[@]}"
    unset opts
    local rev
    local tarcomp
    local mirror="${url#[a-z]*//}"
    mirror="$(dirname "${path}")/${mirror//\//.}"
    local prefix="$(basename "${path}")"
    prefix="${prefix%.tar.*}"

    case "${path}" in
    *.tar.gz)
	tarcomp="--gzip"
	;;
    *.tar.bz2)
	tarcomp="--bzip2"
	;;
    *.tar.xz)
	tarcomp="--xz"
	;;
    *)
	ptxd_bailout "Only .tar.gz, .tar.bz2, .tar.xz and archives are supported for svn downloads."
	;;
    esac

    #
    # scan for valid options
    #
    while [ ${#} -ne 0 ]; do
	local opt="${1}"
	shift

	case "${opt}" in
	    rev=*)
		rev="${opt#rev=}"
		;;
	    *)
		ptxd_bailout "invalid option '${opt}' to ${FUNCNAME}"
		;;
	esac
    done
    unset opt

    if [ -z "${rev}" ]; then
	ptxd_bailout "svn url '${url}' has no 'rev' option"
    fi

    ptxd_make_serialize_take
    if [ "${ptxd_make_get_dryrun}" = "y" ]; then
	echo "Checking URL '${url}'..."
	svn ls "${url}" > /dev/null
	ptxd_make_serialize_put
	return
    fi
    if [ -e "${path}" ]; then
	return
    fi
    echo "${PROMPT}svn: fetching '${url} into '${mirror}'..."
    if [ ! -d "${mirror}" ]; then
	svn checkout -r ${rev} "${url}" "${mirror}"
    else
	svn update -r ${rev} "${mirror}"
    fi &&
    lmtime=$(svn info -r ${rev} "${mirror}" | \
	awk '/^Last Changed Date:/ {print $4 " " $5 " " $6}') &&
    echo "${PROMPT}svn: last modification time '${lmtime}'" &&
    GZIP=-n tar --exclude-vcs --show-stored-names ${tarcomp} \
	--mtime="${lmtime}" --transform "s|^\.|${prefix}|g" \
	--create --sort=name --file "${path}" -C "${mirror}" .
    ptxd_make_serialize_put
}
export -f ptxd_make_get_svn

#
# in env:
#
# ${path}	: local file name
# ${url}	: the url to download
# ${opts[]}	: an array of options
#
ptxd_make_get_s3() {
    local temp_file
    set -- "${opts[@]}"
    unset opts

    if [ "${ptxd_make_get_dryrun}" = "y" ]; then
	return
    fi
    if [ -e "${path}" ]; then
	return
    fi
    ptxd_make_serialize_take
    # remove any pending or half downloaded files
    p="[a-zA-Z0-9]"
    rm -f -- "${path}."$p$p$p$p$p$p$p$p$p$p

    temp_file="$(mktemp "${path}.XXXXXXXXXX")" || ptxd_bailout "failed to create tempfile"

    aws s3 cp "${url}" "${temp_file}" || return
    chmod 644 -- "${temp_file}" &&
    touch -- "${temp_file}" &&
    mv -- "${temp_file}" "${path}"

    ptxd_make_serialize_put
}
export -f ptxd_make_get_s3


#
# check if download is disabled
#
# in env:
#
# ${url}	: the url to download
#
ptxd_make_get_download_permitted() {
    if [ -n "${PTXCONF_SETUP_NO_DOWNLOAD}" -a -z "${PTXDIST_FORCE_DOWNLOAD}" ]; then {
	cat <<EOF

error: automatic download prohibited

Please download '${url}'
manually into '$(dirname ${path})'

EOF
	set -- ${orig_argv[@]}
	if [ $# -ne 1 ]; then
	    echo "If this URL doesn't work, you may try these ones:"
	    while [ ${#} -ne 0 ]; do
		[ "${1}" != "${url}" ] && echo "'${1}'"
		shift
	    done
	    echo
	fi
	exit 1; } >&2
    fi
}
export -f ptxd_make_get_download_permitted


#
# $1: target source path (including file name)
# $@: possible download URLs, separated by space
#
# options separated from URLs by ";"
#
# valid options:
# - no-check-certificate	don't check server certificate (https only)
# - no-proxy			don't use proxy even if configured
#
ptxd_make_get() {
    local -a argv
    local ptxmirror_url

    # needed when called from the source archive target
    pkg_stage="${pkg_stage:-get}"

    exec 2>&${PTXDIST_FD_LOGERR}
    if [ -n "${PTXDIST_QUIET}" ]; then
	exec 9>&1
    fi

    local path="${1}"
    shift

    # skip nested archives
    if [[ "${path}" =~ ^"${PTXDIST_PLATFORMDIR}" ]]; then
	return
    fi

    local -a orig_argv
    orig_argv=( "${@}" )

    if [ -z "${1}" ]; then
	if [ "${ptxd_make_get_dryrun}" != "y" ]; then
	    ptxd_bailout "URL missing for '${path}'!"
	else
	    echo "URL missing for '${path}', skipping."
	    echo
	    return
	fi
    fi

    ptxmirror_url="${path/#\/*\//${ptxd_make_get_mirror}/}"

    #
    # split by spaces, etc
    #
    set -- ${@}

    while [ ${#} -gt 0 ]; do
	local add=true
	local url="${1}"
	shift

	if [[ "${url}" =~ "file://" ]]; then
	    # keep original URL
	    argv[${#argv[@]}]="${url}"
	    # assume, that local URLs are always available
	    ptxmirror_url=
	    continue
	fi
	# restrict download only to white-listed URLs
	if [ -n "${PTXCONF_SETUP_PTXMIRROR_ONLY}" ]; then
	    local pattern
	    add=false
	    for pattern in "${ptxd_make_get_mirror}" \
		    ${PTXCONF_SETUP_URL_WHITELIST}; do
		if [[ "${url}" =~ "${pattern}" ]]; then
		    add=true
		    break
		fi
	    done
	fi
	if ${add}; then
	    argv[${#argv[@]}]="${url}"
	    if [ "${url}" = "${ptxmirror_url}" ]; then
		# avoid duplicates
		ptxmirror_url=
	    fi
	fi
    done
    if [ -n "${ptxmirror_url}" ]; then
	argv[${#argv[@]}]="${ptxmirror_url}"
    fi

    set -- "${argv[@]}"

    while [ ${#} -ne 0 ]; do
	#
	# strip options which are separated by ";" form the
	# URL, store in "opts" array
	#
	local orig_ifs="${IFS}"
	IFS=";"
	local -a opts
	opts=( ${1} )
	IFS="${orig_ifs}"
	unset orig_ifs

	local url="${opts[0]}"
	unset opts[0]

	shift

	case "${url}" in
	git+file://*)
	    echo "local git repository, removing git+file:// prefix from URL"
	    url=${url#git+file://}
	    ;&
	git://*|git+http://*|git+https://*|http://*.git|https://*.git|ssh://*.git)
	    url=${url#git+}
	    ptxd_make_get_download_permitted &&
	    ptxd_make_get_git && return
	    ;;
	svn://*|svn+*://*)
	    url=${url/svn+https/https}
	    if [[ "${url}" =~ ^https ]]; then
		echo "svn+https is fixed in URL, using https directly"
	    fi
	    if [[ "${url}" =~ ^svn\+ ]]; then
		echo "Custom SVN tunnel scheme detected"
	    fi
	    ptxd_make_get_download_permitted &&
	    ptxd_make_get_svn && return
	    ;;
	http://*|https://*|ftp://*)
	    ptxd_make_get_download_permitted &&
	    ptxd_make_get_http && return
	    ;;
	s3://*)
	    ptxd_make_get_download_permitted &&
	    ptxd_make_get_s3 && return
	    ;;
	file*)
	    local thing="${url/file:\/\///}"

	    if [ -f "$thing" ]; then
		echo "local archive, skipping get"
		return
	    elif [ -d "${thing}" ]; then
		echo "local directory instead of tar file, skipping get"
		return
	    else
		thing="${url/file:\/\//./}"
		if [ -d "${thing}" ]; then
		    echo "local project directory instead of tar file, skipping get"
		    return
		fi
	    fi
	    ;;
	*)
	    echo
	    echo "Unknown URL Type!"
	    echo "URL: $url"
	    echo
	    exit 1
	    ;;
	esac
    done

    if [ "${ptxd_make_get_nofail}" != "y" ]; then
	echo
	echo "Could not download package"
	echo "URL: ${orig_argv[@]}"
	echo
	exit 1
    fi
}
export -f ptxd_make_get
