#!/bin/bash
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptxd_make_nfsd_exec() {
    local port
    local client_specifications
    local root="/$(basename "${ptx_nfsroot}")"
    local base="$(dirname "${ptx_nfsroot}")"

    if ! port="$(ptxd_get_kconfig "${PTXDIST_BOARDSETUP}" "PTXCONF_BOARDSETUP_NFSPORT")"; then
	port=2049
    fi

    if ! client_specifications="$(ptxd_get_kconfig "${PTXDIST_BOARDSETUP}" "PTXCONF_BOARDSETUP_NFSROOT_CLIENT_SPECIFICATIONS")"; then
	client_specifications="(rw,no_root_squash)"
    fi

    echo
    echo "Mount rootfs with nfsroot=${root},v3,tcp,port=${port},mountport=${port}"
    echo

    echo "/ ${client_specifications}" > "${PTXDIST_TEMPDIR}/exports" &&
    UNFS_BASE="${base}" unfsd -e "${PTXDIST_TEMPDIR}/exports" -n ${port} -m ${port} -p -d "${@}"
}
export -f ptxd_make_nfsd_exec

ptxd_make_nfsd() {
    ptxd_make_image_init &&
    ptxd_get_ipkg_files ${image_pkgs_selected_target} &&

    cd "${ptx_nfsroot}" &&
    if [ "${PTXCONF_SETUP_NFS_VIRTFS}" = "y" ]; then
	ptxd_make_nfsd_exec -V
    else
	{
	    ptxd_dopermissions "${ptxd_reply_perm_files[@]}"
	    echo ptxd_make_nfsd_exec
	} | fakeroot --
    fi
}
export -f ptxd_make_nfsd

