#!/bin/bash
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# Make a disk image bootable. The bootloader is written to the MBR and
# the following sectors without touching the partition table.
#
# This will fail if the bootloader is too large for the free sectors.
#
# $1	the image to modify
# $2	number of free sectors at the start of the image
# $3	first part of the bootloader for the code area of the MBR
# $4	second part of the bootloader for sector 2..n
#
ptxd_make_bootable() {
    local image="$1"
    local bytes="$[$2 * 512]"
    local stage1="$3"
    local stage2="$4"
    local opt="conv=notrunc"
    local opt2="seek=1"

    if [ ! -w "${image}" ]; then
	ptxd_bailout "Cannot write image file '${stage1}'"
    fi
    if [ ! -r "${stage1}" ]; then
	ptxd_bailout "Cannot open stage1 file '${stage1}'"
    fi
    if [ -z "${stage2}" ]; then
	stage2="${stage1}"
	opt2="${opt2} skip=1"
    elif [ ! -r "${stage2}" ]; then
	ptxd_bailout "Cannot open stage2 file '${stage1}'"
    else
	bytes="$[$bytes - 512]"
    fi
    local needed="$(stat --printf="%s" "${stage2}")"
    if [ "${needed}" -gt "${bytes}" ]; then
	ptxd_bailout "Not enough space to write stage2: available: ${bytes} needed: ${needed}"
    fi

    dd if="${stage1}" of="${image}" ${opt} bs=446 count=1 2>/dev/null &&
    dd if="${stage2}" of="${image}" ${opt} ${opt2} bs=512 2>/dev/null
}
export -f ptxd_make_bootable

