.. _code_signing:

Code Signing
------------

This is an overview over the ptxdist signing infrastructure.
ptxdist uses PKCS#11 internally for providing access to keys and certificates.
Packages that wish to sign something should implement a PKCS#11 interface.

As PKCS#11 URIs usually differ between different usecases (release vs.
development) the URIs normally are not hardcoded in the package configuration.
Instead, ptxdist has the idea of "roles" which are string identifiers used to
access a single private/public key pair and a certificate.

ptxdist supports Hardware Security Modules (HSM).
In case a HSM is not present or shall not be used SoftHSM is used internally to
transparently provide the same API internally.

For each role a PKCS#11 URI must be known by ptxdist.
In case of a HSM the keys and certificates are stored in the HSM, but ptxdist
needs to know the PKCS#11 URI to access the keys.
This is done in ptxdist rule files calling cs_set_uri <role> <uri>.
For SoftHSM the URI is generated internally by ptxdist, but instead the
keys/certificates for each role have have to be imported.
This is done with the cs_import_* functions below.

During each invocation of ptxdist exactly one key provider is active.
The code signing provider can be chosen with the PTXCONF_CODE_SIGNING_PROVIDER
variable.
A code signing provider is a package resposible for providing the role <->
PKCS#11 URI relationships in case a HSM is used or for providing the key
material in case SoftHSM is used.

A package which wants to sign something or which needs access to keys has to
select CODE_SIGNING.
This makes sure the keys are ready when the package is being built.
