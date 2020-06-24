.. _code_signing:

Code Signing
------------

In order to make sure an artifact was created by a known authority and was not
altered later, digital signatures play a key role when building firmware
images.
This is also essential when a verified boot chain is established, e.g. via
*High Assurance Boot* (HAB), signed FIT images, and a verified root file
system.

PTXdist uses `PKCS#11 <pkcs11-doc_>`_ internally to provide access to keys and
certificates, therefore code signing consumers should implement a PKCS#11
interface to make use of PTXdist's code signing infrastructure.

As PKCS#11 URIs usually differ between different usecases (release vs.
development) the URIs are usually not hardcoded in the package configuration.
Instead, PTXdist has the idea of **roles** which are string identifiers used to
access a single private/public key pair and a certificate.

Finally, one or several **code signing providers** supply the mapping from
roles to the respective key material or even provide it themselves for
development.

PTXdist supports *Hardware Security Modules* (HSM).
In case an HSM is not present or shall not be used, PTXdist can emulate it
using `SoftHSM <softhsm_>`_, while still transparently providing the same API
to code signing consumers.

.. _pkcs11-doc: https://www.cryptsoft.com/pkcs11doc/
.. _softhsm: https://www.opendnssec.org/softhsm/

.. _code_signing_providers:

Code Signing Providers
~~~~~~~~~~~~~~~~~~~~~~

For each role a PKCS#11 URI must be known by PTXdist.
In case of an HSM the keys and certificates are stored in the HSM, but PTXdist
needs to know the PKCS#11 URI to access the keys.
For SoftHSM the URI is generated internally by PTXdist, but instead the
keys/certificates for each role have to be imported by the code signing
provider into the SoftHSM.

A code signing provider is a package responsible for providing the role ↔
PKCS#11 URI relationships in case an HSM is used, or for providing the key
material in case SoftHSM is used.

When ``PTXCONF_CODE_SIGNING`` is enabled exactly one code signing provider is
active during each invocation of PTXdist.

PTXdist comes equipped with a development code signing provider "devel"
implemented via the package ``host-ptx-code-signing-dev``.
It imports publicly available development keys for each role into the SoftHSM.

.. important:: The ``host-ptx-code-signing-dev`` code signing provider can be
  used to sign artifacts for development purposes, but **must not** be used for
  production.

Creating Custom Code Signing Providers
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

When a set of release keys or project-specific development keys should be
used (e.g. to achieve backward compatibility), a new code signing provider
must be introduced.

Use ``ptxdist newpackage code-signing-provider`` to generate such a new code
signing provider.
PTXdist distinguishes between "SoftHSM", "HSMs with OpenSC support" and "other
HSMs".
The generated shell script in ``local_src/<name>-code-signing/`` contains
an examples for the selected HSM use case.
See :ref:`code_signing_helper_functions` for an explanation of the available
code signing helpers.
In case of SoftHSM use cases the keys should also be placed inside
``local_src/<name>-code-signing/``

In case an HSM is used it is required to extend the ``CODE_SIGNING_ENV`` with
additional environment variables via a pre rule in
``$(PTXDIST_PLATFORMCONFIGDIR)/rules/pre/``.
For SoftHSM such a pre rule exists already in upstream PTXdist in
``rules/pre/020-code-signing-softhsm.make``.
For HSMs with *OpenSC* support a pre rule is generated in
``$(PTXDIST_PLATFORMCONFIGDIR)/rules/pre/020-<name>-code-signing-hsm.make``.
For other HSMs a skeleton pre make file is generated and must be adjusted.

For example, for Nitrokey HSMs which use OpenSC the generated pre rule looks
like this:

.. code-block:: make

    ifdef PTXCONF_CODE_SIGNING_PROVIDER_<NAME>
    CODE_SIGNING_ENV += \
    	PKCS11_MODULE_PATH="${PTXDIST_SYSROOT_HOST}/lib/pkcs11/opensc-pkcs11.so"
    endif

Note that the module is built in the BSP in this case.
This is not strictly required, it is also possible to use an otherwise
distributed module, e.g. by the HSM manufacturer.
For HSMs supported by OpenSC the required OpenSC selects are generated.
If an HSM without OpenSC support is used the ``select FIXME`` should either be
replaced with an appropriate host tool that provides the PKCS#11 module or
removed altogether if an external PKCS#11 module is used.

Switching the code signing provider is now finally possible with
``ptxdist platformconfig``, then navigate to *Code signing* → *Code signing
provider*.

.. _code_signing_ca_keyrings:

Managing Certificate Authority Keyrings
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In case a self-signed certificate is used :ref:`cs_append_ca_from_uri` can
be called to add the certificate from the (Soft)HSM.

To allow rollovers multiple certificates can be added by calling the
``cs_append_ca_*`` functions multiple times.
Depending on if the certificate resides on a (Soft)HSM or in a file the
appropriate functions must be called.

More complex public key infrastructures (PKIs) consist of separated CA and
*end-entity*.
The CA certificate is only available as a file, the private key is stored in a
safe and inaccessible location (from the build system's perspective).
The signing key as well as the corresponding certificate are stored on an HSM.
Only the CA certificate should end up in the keyring, so
:ref:`cs_append_ca_from_der` or :ref:`cs_append_ca_from_pem` must be used to
append it to the keyring.

Some HSMs do not support storing certificates at all.
In these cases the certificate is present as a file and must be appended with
:ref:`cs_append_ca_from_der` or :ref:`cs_append_ca_from_pem`.

.. _code_signing_consumers:

Code Signing Consumers
~~~~~~~~~~~~~~~~~~~~~~

A package has to select ``CODE_SIGNING`` if it wants to sign something, or if
it needs access to keys and/or certificates.
The config symbol is available in ptxconfig as well as in platformconfig.
Selecting this symbol makes sure the keys and certificates are ready when the
package is being built.

By adding ``CODE_SIGNING_ENV`` to the package's make/conf/image environment a
tool implementing a PKCS#11 interface can access the HSM or SoftHSM.
The PKCS#11 URI can be retrieved via :ref:`cs_get_uri` and passed on, usually
also via an environment variable.

:ref:`cs_get_ca` can be used to install a keyring to the root file system, e.g.:

.. code-block:: none

    $(call install_copy, rauc, 0, 0, 0644, \
      $(shell cs_get_ca update), \
      /etc/rauc/ca.cert.pem)

.. note:: When code signing helper functions are used in make variables (e.g.
  for environment definitions) recursively expanded variables must be used
  (``=``, not ``:=``).
  Otherwise the variable is expanded before a code signing provider can perform
  its setup.
