#!/bin/bash
#
# Copyright (C) 2024 by by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# Reexecute PTXdist with or without container
#
ptxd_run_in_container()
{
	local srcdir layer tmp last ptxdist
	local -a cmd manager_args layers env

	if [ -z "${start_container}" ]; then
		ptxdist_trap_exit_handler
		exec "${@}"
	fi

	ptxdist="${1}"
	shift

	if [ "${PTXCONF_SETUP_CONTAINER_DOCKER}" = "y" ]; then
		cmd=( docker )
		manager_args=( --user "$(id -u)" )
	elif [ "${PTXCONF_SETUP_CONTAINER_PODMAN}" = "y" ]; then
		cmd=( podman )
		manager_args=( --userns=keep-id )
	fi
	cmd+=( run -t -i "${manager_args[@]}" )

	# forward variables that are exported and whitelisted
	mapfile -d ":" -t env < <(printf "${PTXCONF_SETUP_ENV_WHITELIST}")
	mapfile -d ":" -O "${#env[*]}" -t env < <(printf "${PTXDIST_ENV_WHITELIST}")
	env+=( PTXDIST_ENV_WHITELIST PTXDIST_PTXRC TERM COLUMNS LINES KCONFIG_ALLCONFIG KCONFIG_SEED )
	for tmp in "${env[@]}"; do
		if [[ "${!tmp@a}" =~ x ]]; then
			cmd+=( --env="${tmp}" )
		fi
	done

	for layer in "${PTXDIST_LAYERS[@]}"; do
		if [ "${layer}" = "${PTXDIST_TOPDIR}" ]; then
			if [ -h "${last}/base" ]; then
				layer="${last}/base"
			else
				break
			fi
		fi
		if [ -h "${layer}" -a -n "${last}" ]; then
			last="$(cd "${last}" && cd "$(readlink "${layer}")" && pwd)"
		else
			last="${layer}"
		fi
		layers+=( "${last}" )
	done
	for layer in "${layers[@]}"; do
		found=
		for tmp in "${layers[@]}"; do
			if [ "${layer}" = "${tmp}" ]; then
				continue
			fi
			if [[ "${layer}" =~ ^"${tmp}" ]]; then
				found=1
				break
			fi
		done
		if [ -z "${found}" ]; then
			cmd+=( --volume="${layer}:${layer}" )
		fi
	done

	if [ -h "${PTXDIST_LAYERS[-2]}/base" ]; then
		# ${PTXDIST_LAYERS[-2]} is the last BSP layer. If it has a
		# 'base' symlink then that is a specific PTXdist installation
		# was mounted above and must be used explicitly.
		ptxdist="${layers[-1]}/bin/ptxdist"
	elif [ -n "${PTXDIST_VERSION_SCM}" -a -z "${PTXDIST_AUTOVERSION}" ]; then
		cmd+=( --volume="${PTXDIST_TOPDIR}:${PTXDIST_TOPDIR}" )
		# use ptxdist from PTXDIST_TOPDIR to avoid intermediate symlinks
		# that may not exist.
		ptxdist="${PTXDIST_TOPDIR}/bin/ptxdist"
	fi

	cmd+=( --workdir="${PTXDIST_WORKSPACE}" )

	if [ -n "${PTXCONF_SETUP_CONTAINER_DEVELOP}" ]; then
		srcdir="${PTXDIST_SRCDIR}"
		# overwrite $HOME to ensure that ~/.ptxdist is found
		cmd+=( --env HOME="/home/${USER}" --volume="/home/${USER}/.ptxdist:/home/${USER}/.ptxdist" )
		for tmp in "${PTXDIST_WORKSPACE}/local_src/"*"${PTXDIST_PLATFORMSUFFIX}"; do
			if [ -h "${tmp}" ]; then
				tmp="$(cd "${PTXDIST_WORKSPACE}/local_src/" && cd "$(readlink "${tmp}")" && pwd)"
				cmd+=( --volume="${tmp}:${tmp}" )
			fi
		done
	else
		srcdir="${PTXDIST_WORKSPACE}/src"
	fi

	if [ "${PTXDIST_SRCDIR}" != "${PTXDIST_WORKSPACE}/src" ]; then
		cmd+=( --volume="${PTXDIST_SRCDIR}:${srcdir}" )
	fi

	if [ -n "${PTXCONF_SETUP_ICECC}" ]; then
		for tmp in /run/icecc/iceccd.socket /run/iceccd.socket; do
			if [ -e "${tmp}" ]; then
				cmd+=( --volume="${tmp}:${tmp}" )
				break
			fi
		done
	fi
	if [ -n "${PTXCONF_SETUP_CCACHE}" ]; then
		tmp="${CCACHE_DIR:-${HOME}/.ccache}"
		if [ -d "${tmp}" ]; then
			cmd+=( --volume="${tmp}:${home}/.ccache" )
		fi
	fi

	# marker to detect the running container in the nested PTXdist
	cmd+=( --volume="${PTXDIST_TOPDIR}/bin/ptxdist:/.ptxdist:ro" )

	cmd+=( ${PTXCONF_SETUP_CONTAINER_ARGS} )

	cmd+=( "${PTXCONF_SETUP_CONTAINER_IMAGE}" )

	ptxdist_trap_exit_handler
	ptxd_exec exec "${cmd[@]}" "${ptxdist}" "${@}"
}

#
# Determine if a container should be started by checking if:
# 1. PTXdist should run in a container at all
# 2. The container is already running (indicated by the existence of /.ptxdist)
#
# out: start_container
#
ptxd_check_in_container()
{
	start_container=""

	if [ -z "${PTXCONF_SETUP_CONTAINER_ENABLE}" ]; then
		return
	fi

	if [ -e "/.ptxdist" ]; then
		# already in a container stared by PTXdist
		return
	fi

	case "${PTXDIST_ARGS_SECOND[0]}" in
		""|--help|--version|setup|localsetup|select|ptx|platform|collection|local-src)
			# skip the container for commands that don't need it
			;;
		*)
			start_container="${PTXCONF_SETUP_CONTAINER_ENABLE}"
			;;
	esac
}
