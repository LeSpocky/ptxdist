#!/bin/bash

#
# $@: possible download URLs, seperated by space
#
ptxd_make_get() {
	local orig_argv=( "${@}" )
	local -a argv
	local mrd=false		# is mirror already part of urls?

	if [ -z "${1}" ]; then
		echo
		echo "${PROMPT}error: empty parameter to '${FUNCNAME}'"
		echo
		exit 1
	fi

	while [ ${#} -gt 0 ]; do
		local url="${1}"
		shift

		case "${url}" in
		${PTXCONF_SETUP_PTXMIRROR}/*/*)
			# keep original URL, for stuff like glibc
			argv[${#argv[@]}]="${url}"
			mrd=true
			;;
		${PTXCONF_SETUP_PTXMIRROR}/*)
			# if mirror is given us to download, add it, but only once
			if ! ${mrd}; then
				argv[${#argv[@]}]="${url}"
				mrd=true
			fi
			;;
		http://*|ftp://*)

			# keep original URL
			argv[${#argv[@]}]="${url}"

			# add mirror to URLs, but only once
			if ! ${mrd}; then
				argv[${#argv[@]}]="${url/#*:\/\/*\//${PTXCONF_SETUP_PTXMIRROR}/}"
				mrd=true
			fi
			;;
		file://*)
			# keep original URL
			argv[${#argv[@]}]="${url}"
		esac
	done

	set -- "${argv[@]}"

	while [ ${#} -ne 0 ]; do
		local url="${1}"
		shift

		case "${url}" in
		http://*|ftp://*)
			#
			# download to temporary file first,
			# and move it to correct file name after successfull download
			#
			local file="${url##*/}"

			# download any pending half downloaded files
			rm -f -- "${PTXDIST_SRCDIR}/${file}."*

			local temp_file="$(mktemp "${PTXDIST_SRCDIR}/${file}.XXXXXXXXXX")" || ptxd_bailout "failed to create tempfile"
			wget \
			    --passive-ftp \
			    --progress=bar:force \
			    --timeout=30 \
			    --tries=5 \
			    ${PTXDIST_QUIET:+--quiet} \
			    -O "${temp_file}" \
			    "${url}" && {
				chmod 644 -- "${temp_file}" && \
				mv -- "${temp_file}" "${PTXDIST_SRCDIR}/${file}"
				return
			}
			rm -f -- "${temp_file}"
			;;
		file*)
			local thing="${url/file:\/\///}"

			if [ -f "$thing" ]; then
				echo "local archive, copying"
				cp -av "${thing}" "${PTXDIST_SRCDIR}" && return
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

	echo
	echo "Could not download packet"
	echo "URL: ${orig_argv[@]}"
	echo
	exit 1
}

export -f ptxd_make_get
