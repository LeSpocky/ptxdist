#!/bin/bash
#
# Copyright (C) 2019 Sascha Hauer <s.hauer@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# See doc/dev_code_signing.rst for documentation about PTXdist's code signing
# infrastructure.
#

cs_check_env() {
    if [ -z "${SOFTHSM2_CONF}" ]; then
	ptxd_bailout "SOFTHSM2_CONF is not defined. Maybe \$(CODE_SIGNING_ENV) is not used."
    fi
    if [ ! -e "${SOFTHSM2_CONF}" ]; then
	ptxd_bailout "'${SOFTHSM2_CONF}' is missing."
    fi
    if [ -z "${PKCS11_MODULE_PATH}" ]; then
	ptxd_bailout "PKCS11_MODULE_PATH is not defined. Maybe \$(CODE_SIGNING_ENV) is not used."
    fi
    if [ ! -e "${PKCS11_MODULE_PATH}" ]; then
	ptxd_bailout "'${PKCS11_MODULE_PATH}' is missing."
    fi
}
export -f cs_check_env

#
# softhsm_pkcs11_tool_init <args>
#
# Wrapper around pkcs11-tool. To be called initially when --login
# and --pin options shall not be set.
#
softhsm_pkcs11_tool_init() {
    cs_check_env
    pkcs11-tool --module "${PKCS11_MODULE_PATH}" $*
}
export -f softhsm_pkcs11_tool_init

#
# softhsm_pkcs11_tool <args>
#
# Wrapper around pkcs11-tool. Adds --login and --pin options
#
softhsm_pkcs11_tool() {
    softhsm_pkcs11_tool_init --login --pin 1111 $*
}
export -f softhsm_pkcs11_tool

#
# cs_init_variables
#
# Initialize variables used in the code signing functions. Internal.
#
cs_init_variables() {
    sysroot="$(ptxd_get_ptxconf PTXCONF_SYSROOT_HOST)"
    keyprovider="$(ptxd_get_ptxconf PTXCONF_CODE_SIGNING_PROVIDER)"
    keydir="${sysroot}/var/lib/keys/${keyprovider}"
}
export -f cs_init_variables

#
# cs_init_softhsm
#
# Initialize SoftHSM and set the initial pin
#
cs_init_softhsm() {
    cs_check_env
    cs_init_variables
    local shsm_keys="${sysroot}/var/cache/softhsm/${keyprovider}"

    rm -rf "${shsm_keys}" &&
    rm -rf "${keydir}" &&

    sed -i "s^directories.tokendir =.*^directories.tokendir = ${shsm_keys}^" \
	${SOFTHSM2_CONF} &&

    mkdir -p "${shsm_keys}" &&

    softhsm_pkcs11_tool_init --init-token --label "${keyprovider}" --so-pin 0000 &&
    softhsm_pkcs11_tool_init -l --so-pin 0000 --new-pin 1111 --init-pin
}
export -f cs_init_softhsm

#
# cs_define_role <role>
#
# Define a new key role.
#
cs_define_role() {
    local role="${1}"
    cs_init_variables

    mkdir -p "${keydir}/${role}" &&
    # default for SoftHSM
    cs_set_uri "${role}" "pkcs11:token=${keyprovider};object=${role};pin-value=1111"
}
export -f cs_define_role

#
# cs_set_uri <role> <uri>
#
# Set the uri for a role
#
cs_set_uri() {
    local role="${1}"
    local uri="${2}"
    cs_init_variables

    echo "${uri}" > "${keydir}/${role}/uri"
}
export -f cs_set_uri

#
# cs_get_uri <role>
#
# Get the uri from a role
#
cs_get_uri() {
    local role="${1}"
    cs_init_variables

    if [ ! -f "${keydir}/${role}/uri" ]; then
	if [ ${#FUNCNAME[*]} -gt 1 ]; then
	    ptxd_bailout "No PKCS#11 URI for role ${role}"
	else
	    # cs_get_uri was called directly from make prior to cs_set_uri,
	    # which may not be an error if it is evaluated early *and* later
	    # again - return a unique error string in case it is not expected
	    # and a user stumbles upon this
	    echo "ERROR_URI_NOT_YET_SET"
	    return
	fi
    fi
    cat "${keydir}/${role}/uri"
}
export -f cs_get_uri

#
# cs_import_cert_from_der <role> <der>
#
# Import a certificate from DER file to a role. To be used
# with SoftHSM.
#
cs_import_cert_from_der() {
    local role="${1}"
    local der="${2}"
    cs_init_variables

    softhsm_pkcs11_tool --type cert --write-object "${der}" --label "${role}"
}
export -f cs_import_cert_from_der

#
# cs_import_cert_from_pem <role> <pem>
#
# Import a certificate from PEM file to a role. To be used
# with SoftHSM.
#
cs_import_cert_from_pem() {
    local role="${1}"
    local pem="${2}"
    cs_init_variables

    openssl x509 \
	"${openssl_keyopt[@]}" \
	-in "${pem}" -inform pem -outform der |
    softhsm_pkcs11_tool --type cert --write-object /dev/stdin --label "${role}"
}
export -f cs_import_cert_from_pem

#
# cs_import_pubkey_from_pem <role> <pem>
#
# Import a public key from PEM file to a role. To be used
# with SoftHSM.
#
cs_import_pubkey_from_pem() {
    local -a openssl_keyopt
    local role="${1}"
    local pem="${2}"
    cs_init_variables

    if [ -n "${OPENSSL_KEYPASS}" ]; then
	openssl_keyopt=( -passin "file:${OPENSSL_KEYPASS}" )
    fi

    openssl rsa \
	"${openssl_keyopt[@]}" \
	-in "${pem}" -inform pem -pubout -outform der |
    softhsm_pkcs11_tool --type pubkey --write-object /dev/stdin --label "${role}"
    check_pipe_status
}
export -f cs_import_pubkey_from_pem

#
# cs_import_privkey_from_pem <role> <pem>
#
# Import a private key from PEM file to a role. To be used
# with SoftHSM.
#
cs_import_privkey_from_pem() {
    local -a openssl_keyopt
    local role="${1}"
    local pem="${2}"
    cs_init_variables

    if [ -n "${OPENSSL_KEYPASS}" ]; then
	openssl_keyopt=( -passin "file:${OPENSSL_KEYPASS}" )
    fi

    openssl rsa \
	"${openssl_keyopt[@]}" \
	-in "${pem}" -inform pem -outform der |
    softhsm_pkcs11_tool --type privkey --write-object /dev/stdin --label "${role}"
    check_pipe_status
}
export -f cs_import_privkey_from_pem

#
# cs_import_key_from_pem <role> <pem>
#
# Import a private and public key from PEM file to a role. To be used
# with SoftHSM.
#
cs_import_key_from_pem() {
    local role="${1}"
    local pem="${2}"

    cs_import_pubkey_from_pem "${role}" "${pem}"
    cs_import_privkey_from_pem "${role}" "${pem}"
}
export -f cs_import_key_from_pem

#
# cs_get_ca <role>
#
# Get the path to the CA in pem format from a role
#
cs_get_ca() {
    local role="${1}"
    cs_init_variables

    echo "${keydir}/${role}/ca.pem"
}
export -f cs_get_ca

#
# cs_append_ca_from_pem <role> <pem>
#
# Append PEM to CA for a role
#
cs_append_ca_from_pem() {
    local role="${1}"
    local pem="${2}"
    cs_init_variables

    cat "${pem}" >> "${keydir}/${role}/ca.pem"
    # add new line in case ${pem} does not end with an EOL
    echo >> "${keydir}/${role}/ca.pem"
}
export -f cs_append_ca_from_pem

#
# cs_append_ca_from_der <role> <der>
#
# Append DER to CA for a role
#
cs_append_ca_from_der() {
    local role="${1}"
    local der="${2}"
    cs_init_variables

    ptxd_exec openssl x509 -inform der -in "${der}" \
	-out "${tmpdir}/ca.pem" &&
    cs_append_ca_from_pem "${role}" "${tmpdir}/ca.pem"
}
export -f cs_append_ca_from_der

#
# cs_append_ca_from_uri <role> [<uri>]
#
# Append certificate specified by URI or by already set URI to CA for a role
#
cs_append_ca_from_uri() {
    local role="${1}"
    local uri="${2}"
    local tmpdir="$(mktemp -d "${PTXDIST_TEMPDIR}/${role}-ca.XXXXXX")"
    cs_init_variables

    if [ -z "${uri}" ]; then
	uri=$(cs_get_uri "${role}")
    fi

    ptxd_exec extract-cert "${uri}" "${tmpdir}/ca.der" &&
    cs_append_ca_from_der "${role}" "${tmpdir}/ca.der"
}
export -f cs_append_ca_from_uri
