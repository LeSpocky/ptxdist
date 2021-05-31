#!/bin/bash
#
# Copyright (C) 2021 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_log_error() {
    local file="${1}"
    local src="$(ptxd_print_path "${2}")"

    shift 2
    echo "${src}: $*" >> "${file}"
}
export -f ptxd_make_log_error

ptxd_make_report_errors() {
    local line log file="${1}"
    local -a msgs

    exec {log}< "${file}"
    while read line <&${log}; do
	msgs+=( "${line}" )
    done
    ptxd_bailout "${msgs[@]}"
}
export -f ptxd_make_report_errors

