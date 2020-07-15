#!/bin/bash

set -e

set_fit_keys() {
	local r="image-kernel-fit"
	cs_define_role "${r}"

	# HSM use case
	cs_set_uri "${r}" "pkcs11:token=foo;object=kernel-fit"
}

set_rauc_keys() {
	local r="update"
	cs_define_role "${r}"
	cs_set_uri "${r}" "pkcs11:token=foo;object=rauc"
	cs_append_ca_from_uri "${r}"
}

set_imx_habv4_keys() {
	local r

	# HSM use case, assuming it contains only 1st CSF/IMG key
	for i in 1 2 3 4; do
		r="imx-habv4-srk${i}"
		cs_define_role "${r}"
		cs_set_uri "${r}" "pkcs11:token=foo;object=srk${i}"
		cs_append_ca_from_uri "${r}"
	done

	r="imx-habv4-csf1"
	cs_define_role ${r}
	cs_set_uri "${r}" "pkcs11:token=foo;object=csf1"

	r="imx-habv4-img1"
	cs_define_role ${r}
	cs_set_uri "${r}" "pkcs11:token=foo;object=img1"
}


# HSM use case
set_fit_keys
set_rauc_keys
set_imx_habv4_keys
