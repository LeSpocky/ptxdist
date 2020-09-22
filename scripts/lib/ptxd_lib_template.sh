#!/bin/bash
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

if echo | read -i foo -p bar -e > /dev/null 2>&1; then
	_ptxd_can_read_initial=1
fi
export _ptxd_can_read_initial
#
# Read a variable from user input
#
# $1 prompt
# $2 variable name
# $3 optional default value (used if supported)
#
ptxd_template_read() {
    local -a iargs
    if [ -n "$_ptxd_can_read_initial" -a -n "${3}" ]; then
	iargs=( "-i" "${3}" )
    fi
    local prompt="${PTXDIST_LOG_PROMPT}${1}"
    for (( i=$[30-$(wc -c <<< $1)]; $i ; i=$[i-1] )); do
	prompt="${prompt}."
    done
    read -e -p "${prompt}: " "${iargs[@]}" "${2}" &&
    export "${2}"
}
export -f ptxd_template_read
#
# Read a variable from user input, limited to an array of options
#
# $1 prompt prefix
# $2 variable name
# $3..$n options
#
ptxd_template_read_options() {
    local -a options=("${@:3}")
    local i=1
    echo "${PTXDIST_LOG_PROMPT}select option by number:"
    for option in "${options[@]}"; do
	echo "${PTXDIST_LOG_PROMPT}[${i}] ${option}"
	((i++))
    done
    while : ; do
	ptxd_template_read "${1}" chosen
	[ -n "${chosen}" ] && [ "${chosen}" -gt 0 ] &&
	[ "${chosen}" -le "${#options[@]}" ] &&
	break

	echo "${PTXDIST_LOG_PROMPT}invalid option"
    done
    export "${2}=${options[$chosen-1]}"
}
export -f ptxd_template_read_options

ptxd_template_read_name() {
    ptxd_template_read "enter package name" package_name
    export package_filename="${package_name}"
    export package="$(tr "[A-Z]" "[a-z]" <<< "${package_name}")"
    export packagedash="$(tr "[_]" "[\-]" <<< "${package}")"
    export PACKAGE="$(tr "[a-z-]" "[A-Z_]" <<< "${package_name}")"
}
export -f ptxd_template_read_name

ptxd_template_check_existing() {
    if ptxd_in_path PTXDIST_PATH_RULES "${package_name}.make"; then
	export ptxd_template_have_existing=1
	action="${action}-existing-target"
	template="${template}-existing-target"
	conf_tool="$(sed -n 's/.*_CONF_TOOL[\t ]*:= \(.*\)/\1/p' "${ptxd_reply}")"
	export conf_tool
    else
	unset ptxd_template_have_existing
    fi
}
export -f ptxd_template_check_existing

ptxd_template_read_version() {
    if [ -z "${ptxd_template_have_existing}" ]; then
	ptxd_template_read "enter version number" VERSION
    fi
}
export -f ptxd_template_read_version
#
# Read URL of basedir and suffix from user input
#
# $1 default URL of basedir (optional)
# $2 default suffix (optional)
#
ptxd_template_read_url() {
    if [ -z "${ptxd_template_have_existing}" ]; then
	ptxd_template_read "enter URL of basedir" URL "${1}"
	ptxd_template_read "enter suffix" SUFFIX "${2}"
    fi
}
export -f ptxd_template_read_url

ptxd_template_read_author() {
    ptxd_template_read "enter package author" AUTHOR \
	"${PTXCONF_SETUP_USER_NAME} <${PTXCONF_SETUP_USER_EMAIL}>"
}
export -f ptxd_template_read_author

ptxd_template_read_section() {
    local section_name="${1:-project_specific}"
    ptxd_template_read "enter package section" section "${section_name}"
}
export -f ptxd_template_read_section

ptxd_template_read_conf_tool() {
    if [ -z "${conf_tool}" ]; then
	if [ "${AUTOCONF_CLASS}" = "HOST_CROSS_" ]; then
	    export conf_tool="autoconf"
	else
		supported=("autoconf" "cmake" "kconfig" "meson" "perl"
		    "python3" )
	    if [ -z "${AUTOCONF_CLASS}" ]; then
		supported[${#supported[*]}]="qmake"
	    fi
	    ptxd_template_read_options "conf tool" conf_tool "${supported[@]}"
	fi
    fi
    export CONF_OPT=""
    export  SELECT=""
    export CONF_TOOL="$(tr "[a-z-]" "[A-Z_]" <<< "${conf_tool}")"
    case "${conf_tool}" in
    autoconf)
	if [ -z "${AUTOCONF_CLASS}" ]; then
	    CONF_OPT="\$(CROSS_AUTOCONF_USR)"
	else
	    CONF_OPT="\$(${AUTOCONF_CLASS}AUTOCONF)"
	fi
	;;
    cmake|meson)
	if [ -z "${AUTOCONF_CLASS}" ]; then
	    CONF_OPT="\$(CROSS_${CONF_TOOL}_USR)"
	else
	    CONF_OPT="\$(HOST_${CONF_TOOL}_OPT)"
	fi
	SELECT="HOST_${CONF_TOOL}"
	;;
    qmake)
	CONF_OPT="\$(CROSS_QMAKE_OPT)"
	SELECT="QT5"
	;;
    perl)
	SELECT="PERL"
	;;
    python3)
	if [ -z "${AUTOCONF_CLASS}" ]; then
	    SELECT="PYTHON3"
	else
	    SELECT="HOST_SYSTEM_PYTHON3"
	fi
	;;
    esac
    if [ -n "${CONF_OPT}" ]; then
	CONF_OPT=" \\
#	${CONF_OPT}"
    fi
    if [ -n "${SELECT}" ]; then
	SELECT="	select ${SELECT}
"
    fi
}
export -f ptxd_template_read_conf_tool

ptxd_template_read_basic() {
    ptxd_template_read_name &&
    ptxd_template_read_version
}
export -f ptxd_template_read_basic

ptxd_template_read_remote() {
    ptxd_template_read_basic &&
    ptxd_template_read_url &&
    ptxd_template_read_author &&
    ptxd_template_read_section
}
export -f ptxd_template_read_remote

ptxd_template_read_remote_existing() {
    ptxd_template_read_name &&
    ptxd_template_check_existing &&
    ptxd_template_read_version &&
    ptxd_template_read_url &&
    ptxd_template_read_author &&
    ptxd_template_read_section &&
    ptxd_template_read_conf_tool
}
export -f ptxd_template_read_remote_existing

ptxd_template_read_local() {
    ptxd_template_read_basic &&
    ptxd_template_read_author &&
    ptxd_template_read_section
}
export -f ptxd_template_read_local

ptxd_template_print_path() {
    if [ $# -ne 1 ]; then
	ptxd_bailout "number of arguments must be 1"
    fi
    echo "${1#${PWD}/}"
}
export -f ptxd_template_print_path

ptxd_template_setup_class() {
    export AUTOCONF_CLASS="${1}"
    export class="${action}-"
    export CLASS="$(tr "[a-z-]" "[A-Z_]" <<< "${class}")"
}
export -f ptxd_template_setup_class

ptxd_template_filter() {
    local template_file="${1}"
    local filename="${2}"
    if [ ! -f "${template_file}" ]; then
	echo
	echo "${PTXDIST_LOG_PROMPT}warning: template '${template_file}' does not exist"
	echo
	continue
    fi

    if [ -f "${filename}" ]; then
	echo
	local overwrite
	read -e -p "${PTXDIST_LOG_PROMPT}warning: $(ptxd_template_print_path "${filename}") does already exist, overwrite? [y/n] " overwrite
	if [ "${overwrite}" != "y" ]; then
	echo "${PTXDIST_LOG_PROMPT}aborted."
	echo
	exit
	fi
    fi
    echo "generating $(ptxd_template_print_path ${filename})"
    mkdir -p "$(dirname "${filename}")"
    ptxd_replace_magic "${template_file}" > "${filename}" || return
}
export -f ptxd_template_filter

ptxd_template_file() {
    if ! ptxd_in_path PTXDIST_PATH_TEMPLATES "${1}"; then
	ptxd_bailout "Failed to find '${1}' in '${PTXDIST_PATH_TEMPLATES}'!"
    fi
    echo "${ptxd_reply}"
}
export -f ptxd_template_file

ptxd_template_write_rules() {
    local template_suffix
    echo
    for template_suffix in "make" "in"; do
	local template_file="$(ptxd_template_file "${template}-${template_suffix}")"
	local filename="${PTXDIST_WORKSPACE}/rules/${class}${package_filename}.${template_suffix}"
	ptxd_template_filter "${template_file}" "${filename}"
    done
}
export -f ptxd_template_write_rules

ptxd_template_write_platform_rules() {
    local template_file filename
    echo

    template_file="$(ptxd_template_file "${template}-make")"
    filename="${PTXDIST_PLATFORMCONFIGDIR}/rules/${class}${package_filename}.make"
    ptxd_template_filter "${template_file}" "${filename}"

    template_file="$(ptxd_template_file "${template}-in")"
    filename="${PTXDIST_PLATFORMCONFIGDIR}/platforms/${class}${package_filename}.in"
    ptxd_template_filter "${template_file}" "${filename}"
}
export -f ptxd_template_write_rules

ptxd_template_write_src() {
    local dst="${PTXDIST_WORKSPACE}/local_src/${package}"
    local template_src
    local template_dir

    if [ -d "${dst}" ]; then
	return
    fi

    echo
    local r
    read -e -p "${dst#${PTXDIST_WORKSPACE}/} does not exist, create? [Y/n] " r
    case "${r}" in
	y|Y|"") ;;
	*) return ;;
    esac

    template_src="$(ptxd_template_file "${action}")" &&
    mkdir -p "${dst}" &&
    tar -C "${template_src}" -cf - --exclude .svn . | \
	tar -C "${dst}" -xf - &&

    if [ -e "${dst}/wizard.sh" ]; then
	template_dir=$(dirname "${template_src}") &&
	(
	    cd "${dst}" &&
	    bash wizard.sh "${package}" "${template_dir}" "${VERSION}"
	) &&
	rm -f "${dst}/wizard.sh"
    fi &&
    echo &&
    for file in "${dst}"/*; do
	echo "generating $(ptxd_template_print_path "$file")"
    done
}
export -f ptxd_template_write_src

ptxd_template_src_base() {
    ptxd_template_read_local &&
    ptxd_template_write_rules &&
    ptxd_template_write_src
}
export -f ptxd_template_src_base

ptxd_template_src_autogen() {
    local link_target="${PTXDIST_WORKSPACE}/patches/autogen.sh"
    local patches="${PTXDIST_WORKSPACE}/patches/${package}-${VERSION}"
    local autogen="${patches}/autogen.sh"

    mkdir -p "${patches}" &&
    if [ ! -e "${link_target}" ]; then
	echo "generating $(ptxd_template_print_path "${link_target}")"
	cp "${PTXDIST_TOPDIR}/patches/autogen.sh" "${link_target}"
    fi &&
    echo "generating $(ptxd_template_print_path "${autogen}")" &&
    ln -s "../autogen.sh" "${autogen}"
}
export -f ptxd_template_src_autogen

ptxd_template_autoconf_base() {
    template=template-src-autoconf
    ptxd_template_src_base &&
    ptxd_template_src_autogen
}
export -f ptxd_template_autoconf_base

ptxd_template_new() {
# start a new shell here, so we can export everything for ptxd_replace_magic
(
    export action="${1}"
    export template="template-${action}"
    export YEAR="$(date +%Y)"

    local func="ptxd_template_new_${action//-/_}"
    if ! declare -F | grep -q "${func}$"; then
	ptxd_template_help
	return
    fi
    echo
    echo "${PTXDIST_LOG_PROMPT}creating a new '${action}' package:"
    echo
    "${func}"
)
}
export -f ptxd_template_new

ptxd_template_help() {
    echo
    echo "usage: 'ptxdist newpackage <type>', where type is:"
    echo
    set -- "${ptxd_template_help_list[@]}"
    while [ $# -gt 0 ]; do
	while [ -z "${1}" ]; do
	    echo
	    shift
	done
	printf "  %-24s %s\n" "${1}" "${2}"
	shift 2
    done
    echo
}
export -f ptxd_template_help
export -a ptxd_template_help_list

#
# action functions
#

ptxd_template_new_host() {
    template=template-class
    ptxd_template_setup_class HOST_ &&
    ptxd_template_read_remote_existing &&
    ptxd_template_write_rules
}
export -f ptxd_template_new_host
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="host"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create package for development host"

ptxd_template_new_target() {
    ptxd_template_read_remote &&
    ptxd_template_read_conf_tool &&
    ptxd_template_write_rules
}
export -f ptxd_template_new_target
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="target"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create package for embedded target"

ptxd_template_new_cross() {
    template=template-class
    ptxd_template_setup_class HOST_CROSS_ &&
    ptxd_template_read_remote_existing &&
    ptxd_template_write_rules
}
export -f ptxd_template_new_cross
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="cross"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create cross development package"

ptxd_template_new_python3() {
    ptxd_template_read_basic &&
    ptxd_template_read_author &&
    ptxd_template_read_url \
	"\$(call ptx/mirror-pypi, ${package}, \$(PYTHON3_${PACKAGE}).\$(PYTHON3_${PACKAGE}_SUFFIX))" \
	"tar.gz"
    # turn URL of basedir into complete URL
    [[ "$URL" != "\$(call ptx/mirror"* ]] \
	&& URL="$URL/\$(${PACKAGE}).\$(${PACKAGE}_SUFFIX)"
    package_filename="python3-${package_filename}"
    ptxd_template_write_rules
}
export -f ptxd_template_new_python3
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="python3"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create python3 package for embedded target"

ptxd_template_new_src_autoconf_lib() {
    ptxd_template_autoconf_base
}
export -f ptxd_template_new_src_autoconf_lib
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="src-autoconf-lib"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create autotoolized library"

ptxd_template_new_src_autoconf_prog() {
    ptxd_template_autoconf_base
}
export -f ptxd_template_new_src_autoconf_prog
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="src-autoconf-prog"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create autotoolized binary"

ptxd_template_new_src_autoconf_proglib() {
    ptxd_template_autoconf_base
}
export -f ptxd_template_new_src_autoconf_proglib
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="src-autoconf-proglib"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create autotoolized binary+library"

ptxd_template_new_src_cmake_prog() {
    ptxd_template_src_base
}
export -f ptxd_template_new_src_cmake_prog
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="src-cmake-prog"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create cmake binary"

ptxd_template_new_src_qmake_prog() {
    ptxd_template_src_base
}
export -f ptxd_template_new_src_qmake_prog
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="src-qmake-prog"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create qmake binary"

ptxd_template_new_src_meson_prog() {
    ptxd_template_src_base
}
export -f ptxd_template_new_src_meson_prog
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="src-meson-prog"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create meson binary"

ptxd_template_new_src_linux_driver() {
    ptxd_template_src_base
}
export -f ptxd_template_new_src_linux_driver
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="src-linux-driver"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create a linux kernel driver"

ptxd_template_new_src_make_prog() {
    ptxd_template_src_base
}
export -f ptxd_template_new_src_make_prog
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="src-make-prog"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create a plain makefile binary"

ptxd_template_new_src_stellaris() {
    ptxd_template_src_base &&
    ptxd_template_src_autogen
}
export -f ptxd_template_new_src_stellaris
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="src-stellaris"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create stellaris firmware"

ptxd_template_new_font() {
    ptxd_template_read_remote &&
    ptxd_template_write_rules
}
export -f ptxd_template_new_font
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="font"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create a font package"

ptxd_template_new_file() {
    ptxd_template_read_local &&
    ptxd_template_write_rules
}
export -f ptxd_template_new_file
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="file"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create package to install existing files"

ptxd_template_new_kernel() {
    export class="kernel-"
    ptxd_template_read_basic &&
    ptxd_template_read "enter kernel image" image "zImage"
    ptxd_template_read_author &&
    ptxd_template_write_platform_rules
}
export -f ptxd_template_new_kernel
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="kernel"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create package for an extra kernel"

ptxd_template_new_barebox() {
    export class="barebox-"
    ptxd_template_read_basic &&
    ptxd_template_read "enter barebox image" image "barebox.bin"
    ptxd_template_read_author &&
    ptxd_template_write_platform_rules
}
export -f ptxd_template_new_barebox
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="barebox"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create package for an extra barebox"

ptxd_template_new_barebox_imx_habv4() {
    ptxd_template_new_barebox
}
export -f ptxd_template_new_barebox_imx_habv4
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="barebox-imx-habv4"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create package for an extra barebox with i.MX HABv4 enabled"

ptxd_template_new_image_tgz() {
    export class="image-"
    ptxd_template_read_name &&
    ptxd_template_read_author &&
    ptxd_template_read "add packages" PACKAGES '$(PTX_PACKAGES_INSTALL)'
    ptxd_template_read "add files" FILES
    package_filename="${package_filename}-tgz"
    ptxd_template_write_platform_rules
}
export -f ptxd_template_new_image_tgz
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="image-tgz"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create package for a tgz image"

ptxd_template_new_image_genimage() {
    export class="image-"
    ptxd_template_read_name &&
    ptxd_template_read_author &&
    ptxd_template_read "image type" TYPE
    ptxd_template_read "add archives" FILES "\$(IMAGEDIR)/root.tgz"
    ptxd_template_read "genimage config" CONFIG "${package_name}.config"
    ptxd_template_write_platform_rules
    local template_file="$(ptxd_template_file "${template}-config")"
    local filename="${PTXDIST_PLATFORMCONFIGDIR}/config/images/${CONFIG}"
    if ptxd_get_alternative config/images "${CONFIG}"; then
	echo "using existing config file $(ptxd_template_print_path ${ptxd_reply})"
    else
	ptxd_template_filter "${template_file}" "${filename}"
    fi
}
export -f ptxd_template_new_image_genimage
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="image-genimage"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create package for a genimage image"

ptxd_template_new_blspec_entry() {
    export class="blspec-"
    ptxd_template_read_name &&
    ptxd_template_read_author &&
    ptxd_template_read "title" TITLE "PTXdist - $(ptxd_get_ptxconf PTXCONF_PROJECT_VENDOR)-$(ptxd_get_ptxconf PTXCONF_PROJECT)"
    ptxd_template_read "version" VERSION "$(ptxd_get_ptxconf PTXCONF_KERNEL_VERSION)"
    ptxd_template_read "kernel command-line" CMDLINE
    ptxd_template_read "kernel path" KERNEL "/boot/zImage"
    ptxd_template_read "devicetree path" DEVICETREE "/boot/oftree"
    export ENTRY="${package_name}.conf"
    ptxd_template_write_platform_rules
    local template_file="$(ptxd_template_file "${template}-conf")"
    local filename="${PTXDIST_PLATFORMCONFIGDIR}/projectroot/loader/entries/${ENTRY}"
    if ptxd_get_alternative loader/entries "${ENTRY}"; then
	echo "using existing config file $(ptxd_template_print_path ${ptxd_reply})"
    else
	ptxd_template_filter "${template_file}" "${filename}"
    fi
}
export -f ptxd_template_new_blspec_entry
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="blspec-entry"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create package for a bootloader spec entry"

ptxd_template_new_code_signing_provider() {
    export class="host-"
    ptxd_template_read_basic &&
    ptxd_template_read_author &&
    ptxd_template_read_options "provider type" TYPE "SoftHSM" "HSM with OpenSC support" "other HSM"
    package_filename="${package_filename}-code-signing"
    local template_file="$(ptxd_template_file "${template}-choice-in")"
    local filename="${PTXDIST_PLATFORMCONFIGDIR}/platforms/${class}${package_filename}-choice.in"
    ptxd_template_filter "${template_file}" "${filename}"
    template_file="$(ptxd_template_file "${template}-pre-make")"
    filename="${PTXDIST_PLATFORMCONFIGDIR}/rules/pre/020-${package_filename}-hsm.make"
    if [ "$TYPE" = "SoftHSM" ]; then
	export EXTRA_DEPENDENCIES="select HOST_SOFTHSM"
    elif [ "$TYPE" = "HSM with OpenSC support" ]; then
	export EXTRA_DEPENDENCIES="select HOST_OPENSC
	select HOST_OPENSC_PCSC"
	export MODULE_PATH="\${PTXDIST_SYSROOT_HOST}/lib/pkcs11/opensc-pkcs11.so"
	ptxd_template_filter "${template_file}" "${filename}"
    elif [ "$TYPE" = "other HSM" ]; then
	export EXTRA_DEPENDENCIES="select FIXME"
	export MODULE_PATH="\${PTXDIST_SYSROOT_HOST}/fix/me"
	ptxd_template_filter "${template_file}" "${filename}"
    fi
    ptxd_template_write_platform_rules
    package="${package}-code-signing"
    ptxd_template_write_src
}
export -f ptxd_template_new_code_signing_provider
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="code-signing-provider"
ptxd_template_help_list[${#ptxd_template_help_list[@]}]="create package for a code signing provider"
