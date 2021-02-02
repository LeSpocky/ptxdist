#!/bin/bash
#
# Copyright (C) 2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

export PTXDIST_LINT_COMMANDS

ptxd_lint_error() {
    while [ $# -gt 0 ]; do
	echo -e "${1}"
	shift
    done
    touch "${PTXDIST_TEMPDIR}/lint-failed"
}
export -f ptxd_lint_error

ptxd_make_world_lint_patches() {
    local findfd

    echo "Checking patch directories ..."
    ptxd_in_path PTXDIST_PATH_PATCHES
    exec {findfd}< <(find "${ptxd_reply[@]}" -mindepth 1 -maxdepth 1 -type d)
    while read path <&${findfd}; do
	if ! [[ " ${ptx_patch_dir_all} " =~ " ${path} " ]]; then
	    ptxd_lint_error "Unused patch dir '$(ptxd_print_path "${path}")'."
	fi
    done
    exec {findfd}<&-
    echo
}
export -f ptxd_make_world_lint_patches
PTXDIST_LINT_COMMANDS="${PTXDIST_LINT_COMMANDS} patches"

ptxd_make_world_lint_symbols_make() {
    local sedfd

    # - drop comments
    # - split after ')' to match multiple symbols in one line
    # - match '$(PTXCONF_*)'
    # - match 'ifdef PTXCONF_*' and similar things
    exec {sedfd}< <(sed -e '/^#/d' -e 's/)/)\n/g' "${1}" | \
	sed -n -e 's/.*\$(PTXCONF_\([A-Z0-9_]\+\)).*/\1/p' \
	       -e 's/.* PTXCONF_\([A-Z0-9_]\+\)$/\1/p' | sort -u)
    while read symbol <&${sedfd}; do
	if ! [[ " ${symbols_all} " =~ " ${symbol} " ]]; then
	    if [[ "${symbol}" =~ ^(BOARD|)SETUP_ ]]; then
		# skip for now because we cannot track those symbols
		continue
	    fi
	    symbol="PTXCONF_${symbol}"
	    if [ -z "${!symbol}" ]; then
		ptxd_lint_error "Undefined symbol ${symbol} used in '$(ptxd_print_path "${1}")'."
	    fi
	fi
    done
    exec {sedfd}<&-
}
export -f ptxd_make_world_lint_symbols_make

ptxd_make_world_lint_makefiles() {
    ptxd_in_path PTXDIST_PATH_PRERULES
    find "${ptxd_reply[@]}" -type f -name "*.make"
    while read cmd file; do
	if [ "${cmd}" = "include" ]; then
	    echo "${file}"
	fi
    done < "${ptx_dgen_rulesfiles_make}"
    ptxd_in_path PTXDIST_PATH_POSTRULES
    find "${ptxd_reply[@]}" -type f -name "*.make"
}
export -f ptxd_make_world_lint_makefiles

ptxd_make_world_lint_symbols() {
    local symbol symbols_all

    echo "Checking kconfig symbols in menu files ..."
    if [ -e "${PTXDIST_TEMPDIR}/SYMBOLS_UNKNOWN" ]; then
        for symbol in $(<${PTXDIST_TEMPDIR}/SYMBOLS_UNKNOWN); do
	    ptxd_lint_error "Undefined symbol '${symbol}' used in a menu file."
	done
    fi
    echo

    echo "Checking kconfig symbols in rule files ..."
    symbols_all="$(<${PTXDIST_TEMPDIR}/SYMBOLS_ALL)"
    symbols_all="${symbols_all//$'\n'/ }"
    exec {filefd}< <(ptxd_make_world_lint_makefiles)
    while read file <&${filefd}; do
	ptxd_make_world_lint_symbols_make "${file}"
    done < "${ptx_dgen_rulesfiles_make}"
    exec {filefd}<&-
    echo
}
export -f ptxd_make_world_lint_symbols
PTXDIST_LINT_COMMANDS="${PTXDIST_LINT_COMMANDS} symbols"

ptxd_make_world_lint_macros_make() {
    local sedfd

    # - drop comments
    # - split before '$(' to match multiple macros in one line
    # - skip any '$$(call ...'
    # - match '$(call macro_name,...)'
    exec {sedfd}< <(sed -e '/^#/d' -e 's/\(\$\?\$(\)/\n\1/g' "${1}" | \
	sed -n -e '/\$\$(call/d' -e 's/.*\$(call \([^,]*\),.*/\1/p' | sort -u)
    while read macro <&${sedfd}; do
	if ! [[ " ${variables_all} " =~ " ${macro} " ]]; then
	    ptxd_lint_error "Undefined macro '${macro}' used in '$(ptxd_print_path "${1}")'."
	fi
    done
    exec {sedfd}<&-
}
export -f ptxd_make_world_lint_macros_make

ptxd_make_world_lint_macros() {
    local macro variables_all

    echo "Checking macros in rule files ..."
    variables_all="$(<${PTXDIST_TEMPDIR}/VARIABLES_ALL)"
    exec {filefd}< <(ptxd_make_world_lint_makefiles)
    while read file <&${filefd}; do
	ptxd_make_world_lint_macros_make "${file}"
    done < "${ptx_dgen_rulesfiles_make}"
    exec {filefd}<&-
    echo
}
export -f ptxd_make_world_lint_macros
PTXDIST_LINT_COMMANDS="${PTXDIST_LINT_COMMANDS} macros"

ptxd_make_world_lint() {
    local command

    for command in ${PTXDIST_LINT_COMMANDS}; do
	ptxd_make_world_lint_${command}
    done
}
export -f ptxd_make_world_lint
