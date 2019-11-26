#!/bin/bash
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_world_kconfig_mode() {
    if [ -z "${ptx_config_mode}" ]; then
	case "${pkg_stage}" in
	    *config) ptx_config_mode=update ;;
	    *) ptx_config_mode=run ;;
	esac
    fi
}
export -f ptxd_make_world_kconfig_mode

ptxd_make_kconfig_setup() {
    if [ -n "${ref_file_dotconfig}" ]; then
	file_dotconfig="${ref_file_dotconfig}" ptxd_normalize_config &&
	relative_ref_file_dotconfig="${relative_file_dotconfig}"
    fi &&
    ptxd_normalize_config &&
    ptxd_kconfig_setup_config "${ptx_config_mode}" "${pkg_build_dir}/.config" \
	"${relative_file_dotconfig}" "${file_dotconfig}" "${relative_ref_file_dotconfig}"
    if [ ${?} -ne 0 ]; then
	if [ ! -e "${file_dotconfig}" ]; then
	    ptxd_bailout "Config file '$(ptxd_print_path "${file_dotconfig}")' is missing!"
	else
	    ptxd_bailout "Failed to initialize '$(ptxd_print_path ${file_dotconfig})'"
	fi
    fi
}
export -f ptxd_make_kconfig_setup

ptxd_make_world_kconfig_setup() {
    ptxd_make_world_init || return

    local file_dotconfig="${pkg_config}"
    local ref_file_dotconfig="${pkg_ref_config}"
    ptxd_make_world_kconfig_mode &&
    ptxd_make_kconfig_setup
}
export -f ptxd_make_world_kconfig_setup

ptxd_make_kconfig_sync() {
    local mode
    if [ "${ptx_config_mode}" = run ]; then
	if tty -s; then
	    ptx_config_mode=update
	else
	    ptx_config_mode=check
	fi
    fi
    if [ -n "${ref_file_dotconfig}" ]; then
	file_dotconfig="${ref_file_dotconfig}" ptxd_normalize_config &&
	relative_ref_file_dotconfig="${relative_file_dotconfig}"
    fi &&
    ptxd_normalize_config &&
    ptxd_kconfig_sync_config "${ptx_config_mode}" "${pkg_build_dir}/.config" \
	"${relative_file_dotconfig}" "${file_dotconfig}" "${relative_ref_file_dotconfig}"
}
export -f ptxd_make_kconfig_sync

ptxd_make_world_kconfig_sync() {
    ptxd_make_world_init || return

    local file_dotconfig="${pkg_config}"
    local ref_file_dotconfig="${pkg_ref_config}"
    ptxd_make_world_kconfig_mode &&
    ptxd_make_kconfig_sync
}
export -f ptxd_make_world_kconfig_sync

#
# run kconfig and update the config file
# @$1:	the kconfig target (e.g. menuconfig, oldconfig, ...)
#
ptxd_make_kconfig() {
    local file_dotconfig="${pkg_config}"
    local ref_file_dotconfig="${pkg_ref_config}"

    export KCONFIG_NOTIMESTAMP="1"

    ptxd_make_world_kconfig_mode &&
    ptxd_make_kconfig_setup &&
    ptxd_eval \
	"${pkg_path}" \
	"${pkg_env}" \
	"${pkg_conf_env}" \
	make "${1}" \
	"${pkg_conf_opt}" &&
    ptxd_make_kconfig_sync
}
export -f ptxd_make_kconfig

ptxd_make_world_kconfig() {
    ptxd_make_world_init &&
    mkdir -p "${pkg_build_dir}" &&
    cd "${pkg_build_dir}" &&
    ptxd_make_kconfig "${ptx_config_target}"
}
export -f ptxd_make_world_kconfig
