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

ptxd_make_world_lint_symbols_make_get() {
    # - drop comments
    # - split after ')' to match multiple symbols in one line
    # - match '$(PTXCONF_*)'
    # - match 'ifdef PTXCONF_*' and similar things
    # - match '$(call ... PTXCONF_*)'
    sed -e '/^#/d' -e 's/)/)\n/g' "${1}" | \
	sed -e 's/.*\$[{(]\(PTXCONF_[A-Z0-9_]\+\)[})].*/\1/' \
	    -e 's/.* \(PTXCONF_[A-Z0-9_]\+\)$/\1/' \
	    -e 's/.*call .*[, ]\(PTXCONF_[A-Z0-9_]\+\).*/\1/' | \
	sed -n 's/^PTXCONF_\([A-Z0-9_][A-Z0-9_]*\)$/\1/p' | \
	sort -u
}
export -f ptxd_make_world_lint_symbols_make_get

ptxd_make_world_lint_symbols_make() {
    local sedfd

    exec {sedfd}< <(ptxd_make_world_lint_symbols_make_get "${1}")
    while read symbol <&${sedfd}; do
	if ! [[ " ${symbols_all} " =~ " ${symbol} " ]]; then
	    if [[ "${symbol}" =~ ^(BOARD|)SETUP_ ]]; then
		# skip for now because we cannot track those symbols
		continue
	    fi
	    if [ "${symbol}" = "QT5_MODULE_" ]; then
		# used in a macro to build configure options
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

ptxd_make_world_lint_menu_files() {
    sed -n 's;source "\(.*\)";\1;p' ${PTX_KGEN_DIR}/generated/*
}
export -f ptxd_make_world_lint_menu_files

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
    done
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
    if [ ! -e "${PTXDIST_TEMPDIR}/VARIABLES_ALL" ]; then
	echo "Your 'make' version is too old for this check!"
	echo
	return
    fi
    variables_all="$(<${PTXDIST_TEMPDIR}/VARIABLES_ALL)"
    exec {filefd}< <(ptxd_make_world_lint_makefiles)
    while read file <&${filefd}; do
	ptxd_make_world_lint_macros_make "${file}"
    done
    exec {filefd}<&-
    echo
}
export -f ptxd_make_world_lint_macros
PTXDIST_LINT_COMMANDS="${PTXDIST_LINT_COMMANDS} macros"

ptxd_make_world_lint_version() {
    local pkg

    echo "Checking for packages without version ..."
    for pkg in ${ptx_missing_version_pkgs}; do
	ptxd_lint_error "Package '${pkg}' has no version."
    done
    echo
}
export -f ptxd_make_world_lint_version
PTXDIST_LINT_COMMANDS="${PTXDIST_LINT_COMMANDS} version"

ptxd_make_world_lint_autogen() {
    local dir fd file need_autogen

    echo "Checking for missing autogen.sh ..."

    if [ -z "$(type -t diffstat)" ]; then
	    echo "'diffstat' not found, skipping checks for missing autogen.sh"
	    echo
	    return
    fi

    for dir in ${ptx_patch_dir_all}; do
	need_autogen=
	exec {fd}< <(find "${dir}" -type f ! -name autogen.sh ! -name series)
	while read file <&${fd}; do
	    # Check for configure.ac, Makefile.am and similar files. They
	    # indicate that autogen.sh is needed. But not if Makefile.in is
	    # found as well. That means that autoreconf is broken.
	    if diffstat "${file}" | grep -q '\(configure.\(ac\|in\)\|\(GNUm\|m\|M\)ake.*\.am\)' &&
		    ! diffstat "${file}" | grep -q '\(GNUm\|m\|M\)ake.*\.in'; then
		need_autogen=1
		break
	    fi
	done
	exec {fd}<&-
	if [ -n "${need_autogen}" -a ! -e "${dir}/autogen.sh" ]; then
	    ptxd_lint_error "'$(ptxd_print_path "${file}")' touches files that require autoreconf" \
		    "but '$(ptxd_print_path "${dir}/autogen.sh") does not exist."
	fi
    done
    echo
}
export -f ptxd_make_world_lint_autogen
PTXDIST_LINT_COMMANDS="${PTXDIST_LINT_COMMANDS} autogen"

ptxd_make_world_lint_credits() {
    local filefd file

    echo "Checking for obsolete 'See CREDITS for details about who has contributed to this project.' comment ..."

    exec {filefd}< <(ptxd_make_world_lint_makefiles)
    while read file <&${filefd}; do
	if grep -q "See CREDITS for details about who has contributed to this project\." "${file}"; then
	    ptxd_lint_error "'$(ptxd_print_path "${file}")' contains obsolete 'CREDITS' comment."
	fi
    done
    exec {filefd}<&-
    echo
}
export -f ptxd_make_world_lint_credits
PTXDIST_LINT_COMMANDS="${PTXDIST_LINT_COMMANDS} credits"

unset ptxd_make_world_lint_cross_whitelist
# we don't care about the initmethod
ptxd_make_world_lint_cross_whitelist+="INITMETHOD_BBINIT INITMETHOD_SYSTEMD "
# used to add the include path for the kernel headers
ptxd_make_world_lint_cross_whitelist+="KERNEL_HEADER "
# basically global stuff
ptxd_make_world_lint_cross_whitelist+="LOCALES "
ptxd_make_world_lint_cross_whitelist+="PRELINK "
ptxd_make_world_lint_cross_whitelist+="ROOTFS_ETC_HOSTNAME "
# needed for dependencies
ptxd_make_world_lint_cross_whitelist+="SYSTEMD_HWDB "
# needed by the kernel
ptxd_make_world_lint_cross_whitelist+="IMAGE_KERNEL_INITRAMFS IMAGE_KERNEL_INSTALL_EARLY IMAGE_KERNEL_LZOP "
export ptxd_make_world_lint_cross_whitelist

ptxd_make_world_lint_cross() {
    local filefd file pkg packages

    echo "Checking for packages that use symbols from other packages ..."

    packages="$(tr 'a-z-' 'A-Z_' <<<${ptx_packages_all})"

    exec {filefd}< <(ptxd_make_world_lint_makefiles)
    while read file <&${filefd}; do
	pkg="$(sed -n -e 's/^[A-Z_]*PACKAGES-.*\$(PTXCONF_\([A-Z0-9]*\)) +=.*/\1/p' -e '/^[A-Z]/q' "${file}")"
	if [ -z "${pkg}" ]; then
	    continue
	fi
	exec {sedfd}< <(ptxd_make_world_lint_symbols_make_get "${file}")
	while read symbol <&${sedfd}; do
	    found="false"
	    if [[ "${symbol}" =~ ^${pkg} ]]; then
		continue
	    fi
	    if [[ " ${ptxd_make_world_lint_cross_whitelist} " =~ " ${symbol} " ]]; then
		continue
	    fi
	    for tmp in ${packages}; do
		if [[ "${symbol}" =~ ^${tmp}$ || "${symbol}" =~ ^${tmp}_ ]]; then
		    found="true"
		    break
		fi
	    done
	    if ${found}; then
		ptxd_lint_error "'$(ptxd_print_path "${file}")' contains symbol 'PTXCONF_${symbol}' from another package."
	    fi
	done
    done
    exec {filefd}<&-
    echo
}
export -f ptxd_make_world_lint_cross
PTXDIST_LINT_COMMANDS="${PTXDIST_LINT_COMMANDS} cross"

ptxd_make_world_lint_menu() {
    local filefd file

    echo "Checking menu file formating and basic syntax ..."

    exec {filefd}< <(ptxd_make_world_lint_menu_files)
    while read file <&${filefd}; do
	if grep -q "\<default n$" "${file}"; then
	    ptxd_lint_error "'$(ptxd_print_path "${file}")' contains redundant 'default n'."
	fi
	if grep -q "[	 ]$" "${file}"; then
	    ptxd_lint_error "'$(ptxd_print_path "${file}")' contains trailing whitespaces."
	fi
	if grep -q "^  *[^ ]" "${file}"; then
	    ptxd_lint_error "'$(ptxd_print_path "${file}")' uses spaces instead of tabs."
	fi
    done
    exec {filefd}<&-
    echo
}
export -f ptxd_make_world_lint_menu
PTXDIST_LINT_COMMANDS="${PTXDIST_LINT_COMMANDS} menu"

ptxd_make_world_lint() {
    local command

    ptxd_make_world_env_init || return

    for command in ${PTXDIST_LINT_COMMANDS}; do
	ptxd_make_world_lint_${command}
    done
}
export -f ptxd_make_world_lint
