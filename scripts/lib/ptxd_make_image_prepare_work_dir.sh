#!/bin/bash
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2011 by George McCollister <george.mccollister@gmail.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#


#
# ptxd_make_image_extract_ipkg_files - extract ipkg for later image generation
#
# in:
# - $1				directory where ipkg are extracted
# - $PTXDIST_IPKG_ARCH_STRING	ARCH variable for ipkg files
#
ptxd_make_image_extract_xpkg_files() {
    # FIXME: consolidate "ptxd_install_setup_src"
    local src="/etc/opkg/opkg.conf"
    local xpkg_conf="$(mktemp ${PTXDIST_TEMPDIR}/XXXXXXXXXX_xpkg.conf)"
    local work_dir="$1"
    local -a list ptxd_reply
    echo "option force_postinstall 1" > "${xpkg_conf}"

    if ! ptxd_get_alternative projectroot "${src}" ; then
	local IFS="
"
	ptxd_bailout "
unable to find '${src}'

These location have been searched:
${list[*]}
"
    fi

    rm -rf "${work_dir}" &&
    install -m 755 -d "${work_dir}" &&

    ARCH="${PTXDIST_IPKG_ARCH_STRING}" \
    SRC="" \
    CHECKSIG="" \
    CAPATH="" \
    CAFILE="" \
	ptxd_replace_magic "${ptxd_reply}" >> "${xpkg_conf}" &&

    DESTDIR="${work_dir}" \
	opkg -f "${xpkg_conf}" -o "${work_dir}" \
	install "${ptxd_reply_ipkg_files[@]}" &&

    # validate directory permissions
    ptxd_check_dir_permissions "${ptxd_reply_perm_files[@]}" &&

    ptxd_install_fixup_timestamps "${work_dir}"
}
export -f ptxd_make_image_extract_xpkg_files
